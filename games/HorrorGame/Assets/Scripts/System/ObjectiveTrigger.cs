using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectiveTrigger : MonoBehaviour
{
    // Start is called before the first frame update
    void OnTriggerEnter(Collider other)
    {
        Managers.Mission.ReachObjective();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
