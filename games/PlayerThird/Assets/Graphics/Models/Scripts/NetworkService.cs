using UnityEngine;
using UnityEngine.Networking;
using System.Collections;
using System;

public class NetworkService
{
    private const string xmlApi = "https://api.openweathermap.org/data/2.5/weather?lat=59.938732&lon=30.316229&mode=xml&appid=728abff1d97171ab28a008e3e5800944";
    // Start is called before the first frame update
    private IEnumerator CallAPI(string url, Action<string> callback) {
        using (UnityWebRequest request = UnityWebRequest.Get(url)) {
            yield return request.Send();
            if(request.isNetworkError) {
                Debug.Log("Network Error: ", error);
            } else if (request.responseCode != (long)System.Net.HttpStatusCode.OK) {
                Debug.Log("Error: ", request.responseCode);
            } else {
                callback(request.downloadHandler.text);
            }
        }
    }
    
    public IEnumerator GetWeatherXML(Action<string> callback) {
        return CallAPI(xmlApi, callback);
    }
}
