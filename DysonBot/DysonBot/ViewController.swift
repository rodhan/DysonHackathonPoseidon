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
        
        // Make the sliders vertical
//        let trans = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
//        rightTrack.transform = trans;
//        leftTrack.transform = trans;
        
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
    
    @IBAction func killOthers() {
        let ipAddresses = [101,102,104,105,106,107,108,109,110,111,112,113,114,115,116]
        
        for address in ipAddresses {
            _ = MQTTConfig(clientId: "cid", host: "192.168.1.\(address)", port: 1883, keepAlive: 60)
            let payload = "{\"Left\":-200, \"Right\":-200}"
            mqttClient.publishString(payload, topic: "command/wheel_speed", qos: 0, retain: false)

        }
        
        // return to us
        _ = MQTTConfig(clientId: "cid", host: "192.168.1.103", port: 1883, keepAlive: 60)

    }
    
    
}

