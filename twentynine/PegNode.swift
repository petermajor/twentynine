import SpriteKit

class PegNode : SKShapeNode {

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
