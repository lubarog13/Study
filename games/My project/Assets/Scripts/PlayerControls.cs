using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerControls : MonoBehaviour
{
    public Rigidbody2D rigidBody;

    void Start()
    {

        rigidBody = GetComponent<Rigidbody2D>();

    }

    // Update is called once per frame
    void Update()
    {
        rigidBody.velocity = new Vector2(3, rigidBody.velocity.y);
        if (Input.GetMouseButton(0))
        {
            rigidBody.velocity = new Vector2(rigidBody.velocity.x, 7);
        }
    }
}
