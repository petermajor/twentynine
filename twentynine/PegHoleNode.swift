import SpriteKit

class PegHoleNode : SKShapeNode {

    override init() {
        super.init()
    }

    convenience init(position: CGPoint) {
        self.init(circleOfRadius: CGFloat(8))

        self.zPosition = Layer.pegHoles
        self.position = position
        self.fillColor = SKColor.white

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
