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

        mqttConfig.onMessageCallback = { message in
            NSLog("message (mid=\(message.payloadString))")
        }

        mqttClient = MQTT.newConnection(mqttConfig)

        mqttClient.subscribe("status/psd", qos: 0)
    }

    func move(left: Int, right: Int) {
        let payload = "{\"Left\":\(left), \"Right\":\(right)}"

        mqttClient.publishString(payload, topic: "command/wheel_speed", qos: 0, retain:false)
    }

    var proximityDetected: ((Position, Int) -> Void)?

    var bumpDetected: (() -> Void)?
}
