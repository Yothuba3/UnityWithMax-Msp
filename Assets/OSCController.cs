using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OSCController : MonoBehaviour
{
    public string serverId = "MaxMSP";
    public string serverIp = "127.0.0.1";
    public int serverPort = 12000;

    public KeyCode debugKey = KeyCode.S;
    public string debugMessage = "/sample";
    private long latestTimeStamp = 0;
    public static double value;
    
    void Start()
    {
        OSCHandler.Instance.Init(this.serverId, this.serverIp, this.serverPort);
    }

    // Update is called once per frame
    void Update()
    {

        OSCHandler.Instance.UpdateLogs();

        foreach (KeyValuePair<string, ServerLog> item in OSCHandler.Instance.Servers)
        {
            if (item.Value.packets.Count == 0)
            {
                continue;
            }

            int latestPacketIndex = item.Value.packets.Count - 1;

            if (this.latestTimeStamp == item.Value.packets[latestPacketIndex].TimeStamp)
            {
                continue;
            }

            this.latestTimeStamp = item.Value.packets[latestPacketIndex].TimeStamp;

            /*Debug.Log("Receive : "
                      + item.Value.packets[latestPacketIndex].TimeStamp
                      + "/"
                      + item.Value.packets[latestPacketIndex].Address
                      + "/"
                      + item.Value.packets[latestPacketIndex].Data[0]);*/
            var objectResult = item.Value.packets[latestPacketIndex].Data[0];

            value = Convert.ToDouble(objectResult);

        }
    }
}
