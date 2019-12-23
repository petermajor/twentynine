import SpriteKit

class PegNode : SKShapeNode {
    
    var player: PlayerNode {
        guard let player = self.parent as? PlayerNode else {
            fatalError(".parent is not set or is not a PlayerNode")
        }
        return player
    }
    
    override init() {
        super.init()
    }

    convenience init(position: CGPoint, color: UIColor) {
        self.init(circleOfRadius: Configuration.shared.pegRadius)

        self.zPosition = Layer.peg
        self.position = position
        self.fillColor = color
        self.strokeColor = self.fillColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}
