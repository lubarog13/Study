import nltk
import pandas as pd
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
from nltk.tokenize import RegexpTokenizer
from sklearn.ensemble import RandomForestClassifier
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_selection import RFECV
from sklearn.metrics import accuracy_score, f1_score, precision_score, recall_score
from collections import Counter
from tqdm import tqdm
import warnings
warnings.filterwarnings("ignore")

nltk.download('stopwords')
nltk.download('punkt')

tokenizer = RegexpTokenizer(r'[a-zA-Z]+')
stemmer = PorterStemmer()

# Загрузка тренировочного датасета (файл должен быть в одной папке с исполняемым скриптом)
df_train = pd.read_csv('Task_3_id_train.csv')

# Все тексты в одной строке
corpus = ' '.join(df_train.iloc[:, 0])

# Вся используемая в корпусе пунктуация, сохраняется для дальнейшего использования
punct = set([x for x in corpus if not x.isalnum() and not x.isspace()])

# Распределение частот слов
word_freq = Counter([stemmer.stem(x) for x in tokenizer.tokenize(corpus)])

# Единожды использованные в корпусе слова, сохраняются для дальнейшего использования
hapax_legomena = [x for x in word_freq.keys() if word_freq[x] == 1]

# Дважды использованные в корпусе слова, сохраняются для дальнейшего использования
dis_legomena = [x for x in word_freq.keys() if word_freq[x] == 2]


def stylistic(df_column, hapax_legomena, dis_legomena, punct):
    # Вектор имен признаков
    stylistic_names = ['avg_word_len', 'short_word_freq', 'digit_freq', 'uppercase_freq', 'alpha_freq'] + \
                      ['hapax' + x for x in hapax_legomena] + ['dis' + x for x in dis_legomena] + \
                      ['stopword_freq'] + [x + '_freq' for x in punct]

    stylistic_feature_array = []

    for idx, text in tqdm(enumerate(df_column)):
        words = tokenizer.tokenize(text)

        # Средняя длина слов в тексте
        avg_word_len = sum(len(x) for x in words) / len(words)

        # Частота коротких слов
        short_word_freq = len([x for x in words if len(x) <= 5]) / len(words)

        # Частота цифр в тексте
        digit_freq = sum(c.isdigit() for c in text) / len(text)

        # Частота заглавных букв в тексте
        uppercase_freq = sum(c.isupper() for c in text) / len(text)

        # Частота букв в тексте
        alpha_freq = sum(c.isalpha() for c in text) / len(text)

        # Бинарный вектор для гапаксов корпуса
        hapaxes = [x in words for x in hapax_legomena]

        # Бинарный вектор для дислегоменонов корпуса
        dises = [x in words for x in dis_legomena]

        # Частота стоп-слов в тексте
        stopword_freq = sum(x in stopwords.words('english') for x in words)

        # Вектор частот знаков препинания в тексте
        char_count = [text.count(x) / len(text) for x in punct]

        stylistic_feature_array.append([avg_word_len, short_word_freq, digit_freq, uppercase_freq, alpha_freq]
                                       + hapaxes + dises + [stopword_freq] + char_count)

    stylistic_features = pd.DataFrame(stylistic_feature_array)
    stylistic_features.columns = stylistic_names

    return stylistic_features
# Векторизаторы n-грамм слов, сохраняются для дальнейшего использования
word_vectorizers = {}

# Предобработка текстов: удаление всего, кроме слов, и их стемминг
def preprocess(text):
    return ' '.join([stemmer.stem(x).lower() for x in tokenizer.tokenize(text) \
                     if x not in stopwords.words('english')])

for i in tqdm(range(1, 4)):
    vectorizer = CountVectorizer(ngram_range=(i, i), max_features=100, preprocessor=preprocess)
    vectorizer.fit(df_train.iloc[:, 0].to_list())
    word_vectorizers.update({i: vectorizer})

def content(df_column, vectorizer_dict):
    feature_names = []
    content_features = pd.DataFrame()

    for i in vectorizer_dict.keys():
        vectorizer = vectorizer_dict[i]
        ngram_counts = vectorizer.transform(df_column.to_list())

        feature_names += ['_'.join(x.split(' ')) for x in vectorizer.get_feature_names()]
        content_features = pd.concat([content_features, pd.DataFrame.sparse.from_spmatrix(ngram_counts)], axis=1)

    content_features.columns = feature_names

    return content_features

# Векторизаторы n-грамм символов, сохраняются для дальнейшего использования
char_vectorizers = {}

for i in tqdm(range(2, 4)):
    vectorizer = CountVectorizer(ngram_range=(i, i), max_features=100, analyzer='char')
    vectorizer.fit(df_train.iloc[:, 0].to_list())
    char_vectorizers.update({i: vectorizer})

def hybrid(df_column, vectorizer_dict):
    feature_names = []
    hybrid_features = pd.DataFrame()

    for i in vectorizer_dict.keys():
        vectorizer = vectorizer_dict[i]
        ngram_counts = vectorizer.transform(df_column.to_list())

        feature_names += vectorizer.get_feature_names()
        hybrid_features = pd.concat([hybrid_features, pd.DataFrame.sparse.from_spmatrix(ngram_counts)], axis=1)

    hybrid_features.columns = feature_names

    return hybrid_features
stylistic_train = stylistic(df_train.iloc[:, 0], hapax_legomena, dis_legomena, punct)

content_train = content(df_train.iloc[:, 0], word_vectorizers)
hybrid_train = hybrid(df_train.iloc[:, 0], char_vectorizers)

# Матрица из всех сгенерированных признаков
x_train = pd.concat([stylistic_train, content_train, hybrid_train], axis=1)
y_train = df_train.iloc[:, 1]

# Эстимейтор, использующийся для удаления признаков. Необходимо указать определенный random_state
rfc = RandomForestClassifier(n_jobs=20, random_state=1)

# Селектор признаков. Шаг указывается равным 0.1 для быстроты вычислений, минимальное количество остающихся
# признаков равно 10% количества изначальных признаков (округляется)
selector = RFECV(rfc, step=0.1, cv=5, min_features_to_select=round(x_train.shape[1] * 0.1))
selector = selector.fit(x_train, y_train)

feature_mask = selector.support_

# В финальном датасете оставляются все признаки, выбранные селектором
x_train = x_train.iloc[:, feature_mask]

a = pd.concat([x_train, y_train], axis=1)
a.to_csv('train_data.csv')

df_test = pd.read_csv('Task_3_id_test.csv')

# При формировании признаков используются данные, полученные с тренировочного датасета
stylistic_test = stylistic(df_test.iloc[:, 0], hapax_legomena, dis_legomena, punct)
content_test = content(df_test.iloc[:, 0], word_vectorizers)
hybrid_test = hybrid(df_test.iloc[:, 0], char_vectorizers)

x_test = pd.concat([stylistic_test, content_test, hybrid_test], axis=1)
y_test = df_test.iloc[:, 1]

# Оставляются те же признаки, что были выбраны для тренировочного датасета
x_test = x_test.iloc[:, feature_mask]

b = pd.concat([x_test, y_test], axis=1)
b.to_csv('test_data.csv')