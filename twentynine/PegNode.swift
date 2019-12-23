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
        self.init(circleOfRadius: CGFloat(8))

        self.zPosition = Layer.peg
        self.position = position
        self.fillColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
