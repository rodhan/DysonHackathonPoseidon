import Foundation
import Moscapsule

struct DysonBot: Bot {

    let mqttConfig: MQTTConfig
    let mqttClient: MQTTClient

    init(ipAddress: String) {
        mqttConfig = MQTTConfig(clientId: "cid", host: ipAddress, port: 1883, keepAlive: 60)
        mqttConfig.onPublishCallback = { messageId in
            NSLog("published (mid=\(messageId))")
        }

        mqttClient = MQTT.newConnection(mqttConfig)
    }

    func move(left: Int, right: Int) {
        let payload = "{\"Left\":\(left), \"Right\":\(right)}"

        mqttClient.publishString(payload, topic: "command/wheel_speed", qos: 0, retain:false)
    }

    var proximityDetected: ((Position, Int) -> Void)?

    var bumpDetected: (() -> Void)?
}
