using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class reciveValue : MonoBehaviour
{
    private Material _material;
    
    // Start is called before the first frame update
    void Start()
    {
        this._material = gameObject.GetComponent<Renderer>().material;
    }

    // Update is called once per frame
    void Update()
    {
        float _value = (float) OSCController.value;
        this._material.SetFloat("_RadSize", _value * 0.005f);
        
    }
}
