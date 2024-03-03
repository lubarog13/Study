using System.Collections;
using System.Collections.Generic;
using System.Runtime.Versioning;
using UnityEngine;


public class AudioManager : MonoBehaviour, IGameManager
{
    [SerializeField] private AudioSource soundSource;
    [SerializeField] private AudioSource music1Source;

    [SerializeField] private string introBgMusic;
    [SerializeField] private string levelBgMusic;
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

    public void PlaySound(AudioClip clip) {
        soundSource.PlayOneShot(clip);
    }

    public void PlayIntroMusic() {
        Debug.Log("intro");
        PlayMusic(Resources.Load("Music/"+introBgMusic) as AudioClip);
    }

    public void PlayLevelMusic() {
        PlayMusic(Resources.Load("Music/"+levelBgMusic) as AudioClip);
    }
    private void PlayMusic(AudioClip clip) {
        music1Source.clip = clip;
        music1Source.Play();
    }

    public void StopMusic() {
        music1Source.Stop();
    }
}
