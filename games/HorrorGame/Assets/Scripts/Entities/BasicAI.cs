using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BasicAI : MonoBehaviour
{
    protected bool _alive;
    public float speed = 3.0f;
    public const float baseSpeed = 3.0f;

    void Start()
    {
        _alive = true;
    }


    void Update()
    {
        
    }

    public void SetAlive(bool alive)
    {
        _alive = alive;
    }
}
