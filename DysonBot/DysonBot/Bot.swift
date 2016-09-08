import Foundation

enum Position {
    case frontLeft
    case frontRight
    case backLeft
    case backRight
}

protocol Bot {
    func move(left:Int, right:Int)

    var proximityDetected: (_ position: Position, _ value:Int) -> Void { get set }

    var bumpDetected: () -> Void { get set }
}
