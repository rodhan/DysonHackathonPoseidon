import UIKit
import Moscapsule

class ViewController: UIViewController {
    var leftSpeed = 0;
    var rightSpeed = 0;

    let mqttConfig = MQTTConfig(clientId: "cid", host: "192.168.1.103", port: 1883, keepAlive: 60)
    var mqttClient: MQTTClient!

    @IBOutlet weak var rightTrack: UISlider!
    @IBOutlet weak var leftTrack: UISlider!
    @IBOutlet weak var imageView360: UIImageView!

    override func viewDidLoad() {
        mqttConfig.onPublishCallback = { messageId in
            NSLog("published (mid=\(messageId))")
        }

        mqttClient = MQTT.newConnection(mqttConfig)
    }
    
    @IBAction func rightSlider(_ sender: UISlider){
        rightSpeed = Int(sender.value)
        let payload = "{\"Left\":\(leftSpeed), \"Right\":\(rightSpeed)}"

        mqttClient.publishString(payload, topic: "command/wheel_speed", qos: 0, retain: false)
    }

    @IBAction func leftSlider(_ sender: UISlider) {
        leftSpeed = Int(sender.value)
        let payload = "{\"Left\":\(leftSpeed), \"Right\":\(rightSpeed)}"

        mqttClient.publishString(payload, topic: "command/wheel_speed", qos: 0, retain: false)
    }
}

