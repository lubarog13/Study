using System;
using UnityEngine;

public class LaserControls : MonoBehaviour
{
    public int laserSpeed = 6;

    private void Update()
    {
        transform.Translate(Vector3.up* laserSpeed * Time.deltaTime);
        if (transform.position.y >= 5.7)
        {
            Destroy(this.gameObject, 1);
        }
    }
}