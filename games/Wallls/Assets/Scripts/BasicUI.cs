using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BasicUI : MonoBehaviour
{
    // Start is called before the first frame update
    void OnGUI()
    {
        if (GUI.Button(new Rect(10, 10, 40, 20), "Test")) {
            Debug.Log("Text button");
        }
    }
}