import Foundation
import Moscapsule

struct DysonBot: Bot {
    let mqttConfig: MQTTConfig
    let mqttClient: MQTTClient

    init(ipAddress: String) {
        mqttConfig = MQTTConfig(clientId: "cid", host: ipAddress, port: 1883, keepAlive: 60)

        mqttConfig.onPublishCallback = { messageId in
            print("published (mid=\(messageId))")
        }

        mqttClient = MQTT.newConnection(mqttConfig)

        let x = self
        mqttConfig.onMessageCallback = {
            message in
            print("message (mid=\(message.payloadString))")

            switch message.topic {

            case "status/psd":
                let data = DysonBot.parse(jsonPayload: message.payloadString!)!

                for key in data.keys {
                    if key == "FrontLeft" {
                        x.proximityDetected?(.frontLeft, data[key]!)
                    }

                    if key == "FrontRight" {
                        x.proximityDetected?(.frontRight, data[key]!)
                    }

                    if key == "BackLeft" {
                        x.proximityDetected?(.backLeft, data[key]!)
                    }

                    if key == "BackRight" {
                        x.proximityDetected?(.backRight, data[key]!)
                    }
                }
            default:
                break
            }
        }

        mqttClient.subscribe("status/psd", qos: 0)
    }

    func move(left: Int, right: Int) {
        let payload = "{\"Left\":\(left), \"Right\":\(right)}"

        mqttClient.publishString(payload, topic: "command/wheel_speed", qos: 0, retain:false)
    }

    var proximityDetected: ((Position, Int) -> Void)?

    var bumpDetected: (() -> Void)?


    static func parse(jsonPayload: String) -> [String: Int]? {
        var payload: [String: Int]?

        do {
            let data = jsonPayload.data(using: .utf8)!
            payload = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions()) as? [String: Int]
        } catch {
            print(error)
        }

        return payload
    }
}
