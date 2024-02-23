using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioManager : MonoBehaviour, IGameManager
{
    public ManagerStatus status {get; private set;}
    private NetworkService _network;

    public float soundVolume {
        get {return AudioListener.volume;}
        set {AudioListener.volume = value;}
    }

    public bool soundMute {
        get {return AudioListener.pause;}
        set {AudioListener.pause = value;}
    }
    // Start is called before the first frame update
    public void Startup(NetworkService service) 
    {
        Debug.Log("AudioManager starting...");
        _network = service;
        soundVolume = 1f;
        status = ManagerStatus.Started;

    }
}
