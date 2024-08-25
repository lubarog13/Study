using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;

public class MissionManager : MonoBehaviour, IGameManager
{
    public ManagerStatus status {get;private set;}
    public int curLevel {get; private set;}
    public int maxLevel {get; private set;}

    private NetworkService _network;

    public void Startup(NetworkService service) {
        Debug.Log("Mission manager start...");
        _network = service;
        UpdateData(0, 1);
        status = ManagerStatus.Started;
    }

    public void GoToNext() {
        if (curLevel < maxLevel) {
            curLevel++;
            string name = "Level" + curLevel;
            Debug.Log("Loading " + name);
            SceneManager.LoadScene(name);
        } else {
            Debug.Log("Last level");
        }
    }

    public void ReachObjective() {
        Messenger.Broadcast(GameEvent.LEVEL_COMPLETE);
    }

    public void RestartCurrent() {
        string name = "Level" + curLevel;
        Debug.Log("Loading" + name);
        SceneManager.LoadScene(name);
    }

    public void UpdateData(int curLevel, int maxLevel) {
        this.curLevel = curLevel;
        this.maxLevel = maxLevel;
    }
}
