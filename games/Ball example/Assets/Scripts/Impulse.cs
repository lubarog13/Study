using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Impulse : MonoBehaviour
{

    public GameObject stone;
    public float fireRate = 0.5f;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(ThrowStone());
        
    }

    // Update is called once per frame
    void Update()
    {

    }

    IEnumerator ThrowStone()
    {
        yield return new WaitForSeconds(2.0f);
        while(true)
        {
            Instantiate(stone, transform.position, Random.rotation);
            yield return new WaitForSeconds(fireRate);
        }
    }

}
