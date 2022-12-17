using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Move : MonoBehaviour
{
    public float forceValue;
    private Rigidbody rb;
    public float jumpValue;
    private AudioSource audiosource;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        audiosource = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetButtonDown("Jump") && Mathf.Abs(rb.velocity.y) < 0.01f) {
            rb.AddForce(Vector3.up * jumpValue, ForceMode.Impulse);
            audiosource.Play();
        }
    }

    private void FixedUpdate()
    {
        rb.AddForce(new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")) * forceValue);
        rb.AddForce(new Vector3(Input.acceleration.x, 0, Input.acceleration.y) * forceValue);
    }

    // private void OnCollisionEnter(Collision collision) {
    //     if(collision.gameObject.tag == "Enemy") {
    //         print("Collision");
    //         Destroy(collision.gameObject);
    //     }
    // }
    //
    // private void OnTriggerEnter(Collider other)
    // {
    //     print("I am entering the area");
    // }
}
