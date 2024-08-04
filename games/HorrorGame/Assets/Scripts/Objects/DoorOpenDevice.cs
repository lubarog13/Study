using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DoorOpenDevice : MonoBehaviour
{
    [SerializeField] private Vector3 dPos;

    private bool _open;
    // Start is called before the first frame update
    void Start()
    {
    }

    public void Operate() {
        if(_open) {
            Vector3 pos = transform.position - dPos;
            iTween.MoveTo(gameObject, iTween.Hash("position",pos,"time",2.0f,"delay",0f));
        } else {
            Vector3 pos = transform.position + dPos;
            iTween.MoveTo(gameObject, iTween.Hash("position",pos,"time",2.0f,"delay",0f));
        }
        _open = !_open;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void Activate() {
        Debug.Log(_open);
        if (!_open) {
            Vector3 pos = transform.position + dPos;
            transform.position = pos;
            _open = true;
        }
    }

    public void Deactivate() {
        if (_open) {
            Vector3 pos = transform.position - dPos;
            transform.position = pos;
            _open = false;
        }
    }
}
