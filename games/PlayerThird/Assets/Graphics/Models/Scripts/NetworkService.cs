using UnityEngine;
using UnityEngine.Networking;
using System.Collections;
using System;

public class NetworkService
{
    private const string webImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/%D0%93%D0%BE%D1%80%D0%B0_%D0%A1%D1%82%D1%80%D0%B8%D0%BC%D0%B1%D0%B0_%D0%B2%D0%B7%D0%B8%D0%BC%D0%BA%D1%83.jpg/300px-%D0%93%D0%BE%D1%80%D0%B0_%D0%A1%D1%82%D1%80%D0%B8%D0%BC%D0%B1%D0%B0_%D0%B2%D0%B7%D0%B8%D0%BC%D0%BA%D1%83.jpg";

    private const string jsonApi = "https://api.openweathermap.org/data/2.5/weather?lat=59.938732&lon=30.316229&appid=728abff1d97171ab28a008e3e5800944";
    // Start is called before the first frame update
    private IEnumerator CallAPI(string url, Action<string> callback) {
        using (UnityWebRequest request = UnityWebRequest.Get(url)) {
            yield return request.Send();
            if(request.isNetworkError) {
                Debug.Log("Network Error: " + request.error);
            } else if (request.responseCode != (long)System.Net.HttpStatusCode.OK) {
                Debug.Log("Error: " + request.responseCode);
            } else {
                callback(request.downloadHandler.text);
            }
        }
    }
    
    public IEnumerator GetWeatherJSON(Action<string> callback) {
        return CallAPI(jsonApi, callback);
    }

    public IEnumerator DownloadImage(Action<Texture2D> callback) {
        UnityWebRequest request = UnityWebRequestTexture.GetTexture(webImage);
        yield return request.Send();
        callback(DownloadHandlerTexture.GetContent(request));
    }
}
