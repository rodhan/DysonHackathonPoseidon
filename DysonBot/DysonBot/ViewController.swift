import UIKit
import Moscapsule

class ViewController: UIViewController {

    var payloadToggle = true
    let mqttConfig = MQTTConfig(clientId: "cid", host: "192.168.1.103", port: 1883, keepAlive: 60)
    var mqttClient: MQTTClient!

    override func viewDidLoad() {
        mqttConfig.onPublishCallback = { messageId in
            NSLog("published (mid=\(messageId))")
        }

        mqttClient = MQTT.newConnection(mqttConfig)
    }

    @IBAction func buttonTap(_ sender: AnyObject) {

        let payload = payloadToggle ? "{\"Left\":-3000, \"Right\":1000}" : "{\"Left\":0, \"Right\":0}"
        payloadToggle = !payloadToggle

        mqttClient.publishString(payload, topic: "command/wheel_speed", qos: 0, retain: false)
    }
}

