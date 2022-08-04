using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerControls : MonoBehaviour
{
    public int speed = 6;
    public GameObject lazerPrefab;
    private float nextFire;
    private float fireRate = 0.3f;

    // Start is called before the first frame update
    void Start()
    {
        transform.position = new Vector3(0, 0, 0);
    }

    private void SpaceMovement()
    {
        float horizonInput = Input.GetAxis("Horizontal");
        float vertInput = Input.GetAxis("Vertical");
        transform.Translate(Vector3.right * Time.deltaTime * speed * horizonInput);
        transform.Translate(Vector3.up * Time.deltaTime * speed * vertInput);
        if (transform.position.y > 0)
        {
            transform.position = new Vector3(transform.position.x, 0, 0);
        }
        else if (transform.position.y < -4.07f)
        {
            transform.position = new Vector3(transform.position.x, -4.07f, 0);
        }
        if (transform.position.x > 9.7f)
        {
            transform.position = new Vector3(-9.7f, transform.position.y, 0);
        }
        else if (transform.position.x < -9.7f)
        {
            transform.position = new Vector3(9.7f, transform.position.y, 0);
        }
    }

    // Update is called once per frame
    void Update()
    {
        SpaceMovement();
        if (Input.GetMouseButton(0))
        {
            if (Time.time> nextFire)
            {
                Instantiate(lazerPrefab, transform.position + new Vector3(0, 1.3f, 0), Quaternion.identity);
                nextFire = Time.time + fireRate;
            }
        }
    }
}
