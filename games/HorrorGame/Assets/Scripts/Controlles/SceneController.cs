using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SceneController : MonoBehaviour
{
    [SerializeField] private GameObject enemyPrefab;
    private GameObject _enemy;
    public float baseSpeed = 1.0f;

     void Awake() {
        Messenger<float>.AddListener(GameEvent.SPEED_CHANGED, OnSpeedChanged);
        Messenger<int, int>.AddListener(StartupEvent.MANAGERS_PROGRESS, OnManagersProgress);
        Messenger.AddListener(StartupEvent.MANAGERS_STARTED, OnManagersStarted);
    }

    void OnDestroy() {
        Messenger<float>.RemoveListener(GameEvent.SPEED_CHANGED, OnSpeedChanged);
        Messenger<int, int>.RemoveListener(StartupEvent.MANAGERS_PROGRESS, OnManagersProgress);
        Messenger.RemoveListener(StartupEvent.MANAGERS_STARTED, OnManagersStarted);
    }

     private void OnSpeedChanged(float value) {
        baseSpeed = value;
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    private void OnManagersProgress(int numReady, int numModules) {
    }

    private void OnManagersStarted() {
    }

    // Update is called once per frame
    void Update()
    {
        if (_enemy==null) {
            _enemy = Instantiate(enemyPrefab) as GameObject;
            _enemy.transform.position = new Vector3(0, 1, 0);
            Messenger<float>.Broadcast(GameEvent.SPEED_CHANGED, baseSpeed);
            float angle = Random.Range(0, 360);
            _enemy.transform.Rotate(0, angle, 0);
        }
    }
}
