using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class objectScaling : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        float _value = (float) OSCController.value;
        _value *= 0.01f;
        this.transform.localScale = new Vector3(1 + _value, 1 + _value, 1 + _value);
    }
}
