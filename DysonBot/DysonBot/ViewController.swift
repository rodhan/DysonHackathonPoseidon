//
//  ViewController.swift
//  DysonBot
//
//  Created by Gareth Maguire on 08/09/2016.
//  Copyright © 2016 GJAM. All rights reserved.
//

import UIKit
import Moscapsule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // set MQTT Client Configuration
    let mqttConfig = MQTTConfig(clientId: "cid", host: "test.mosquitto.org", port: 1883, keepAlive: 60)
    mqttConfig.onPublishCallback = { messageId in
        NSLog("published (mid=\(messageId))")
    }
    mqttConfig.onMessageCallback = { mqttMessage in
        NSLog("MQTT Message received: payload=\(mqttMessage.payloadString)")
    }
    
    // create new MQTT Connection
    let mqttClient = MQTT.newConnection(mqttConfig)
    
    // publish and subscribe
    mqttClient.publishString("message", topic: "publish/topic", qos: 2, retain: false)
    mqttClient.subscribe("subscribe/topic", qos: 2)
    
    // disconnect
    mqttClient.disconnect()
}

