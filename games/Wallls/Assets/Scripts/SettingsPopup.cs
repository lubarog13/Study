using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using UnityEngine;

public class SettingsPopup : MonoBehaviour
{
    [SerializeField] private Slider speedSlider;
    [SerializeField] private Slider soundSlider;
    void Start() {
        speedSlider.value = PlayerPrefs.GetFloat("speed", 1);
    }
    public void Open() {
        gameObject.SetActive(true);
    }
    public void Close() {
        gameObject.SetActive(false);
    }
    public void OnSubmitName(string name) {
        Debug.Log(name);
    }
    public void OnSpeedValue(Slider slider) {
        Messenger<float>.Broadcast(GameEvent.SPEED_CHANGED, slider.value);
        PlayerPrefs.SetFloat("speed", slider.value);
    }

    public void OnSoundToggle() {
        Managers.Audio.soundMute = !Managers.Audio.soundMute;
    }

    public void OnSoundValue(Slider slider) {
        Managers.Audio.soundVolume = slider.value;
    }
}
