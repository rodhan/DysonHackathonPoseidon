import UIKit
import Moscapsule

class ViewController: UIViewController {
    var leftSpeed = 0;
    var rightSpeed = 0;
    
    let ipAddress = "192.168.1.103"

    let mqttConfig = MQTTConfig(clientId: "cid", host: "192.168.1.103", port: 1883, keepAlive: 60)
    var mqttClient: MQTTClient!
    var firstTimeAppearing = true

    @IBOutlet weak var rightTrack: UISlider!
    @IBOutlet weak var leftTrack: UISlider!
    @IBOutlet weak var imageView360: DysonCameraImageView!

    override func viewDidLoad() {
        
        let increaseOfHitArea : CGFloat = 50.0;
        let rectLeft = CGRect(x: leftTrack.frame.origin.x, y: leftTrack.frame.origin.y, width: leftTrack.frame.size.width + increaseOfHitArea, height: leftTrack.frame.size.height + increaseOfHitArea)
        leftTrack.frame = rectLeft
        
        mqttConfig.onPublishCallback = { messageId in
            NSLog("published (mid=\(messageId))")
        }

        mqttClient = MQTT.newConnection(mqttConfig)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if firstTimeAppearing == true {
            imageView360.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
            imageView360.startUpdates(url: URL(string: "http://\(ipAddress):8080/frame.jpg")!)
        }
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
        let ipAddresses = [103]; // [101,102,104,105,106,107,108,109,110,111,112,113,114,115,116]
        
        for address in ipAddresses {
            mqttClient.disconnect()
            _ = MQTTConfig(clientId: "cid", host: "192.168.1.\(address)", port: 1883, keepAlive: 60)
            mqttClient = MQTT.newConnection(mqttConfig)

            let payload = "{\"Left\":-400, \"Right\":-400}"
            mqttClient.publishString(payload, topic: "command/wheel_speed", qos: 0, retain: false)

        }
        
        // return to us
        mqttClient.disconnect()

        _ = MQTTConfig(clientId: "cid", host: "192.168.1.103", port: 1883, keepAlive: 60)
        mqttClient = MQTT.newConnection(mqttConfig)


    }
    
    
}

