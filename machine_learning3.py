import pandas as pd
from sklearn.metrics import accuracy_score, f1_score, precision_score, recall_score
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split

df = pd.read_csv('train_data.csv')
df.head()
x_train, x_test, y_train, y_test = train_test_split(df.iloc[:,:821], df.iloc[:,-1], test_size=0.2, random_state=1, stratify = df.iloc[:,-1])
rfc = RandomForestClassifier(n_jobs=20, random_state=1)
from sklearn.metrics import classification_report
rfc.fit(x_train, y_train)

# Определенные моделью классы
y_pred = rfc.predict(x_test)

# Оценки
a = classification_report(y_test, y_pred, digits=3, output_dict = True)

print('Precision: ', round(a['macro avg']['precision'],3))
print('Recall: ', round(a['macro avg']['recall'],3))
print('F1: ', round(a['macro avg']['f1-score'],3))
