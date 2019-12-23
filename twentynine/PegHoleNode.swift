import SpriteKit

class PegHoleNode : SKShapeNode {

    override init() {
        super.init()
    }

    convenience init(position: CGPoint) {
        self.init(circleOfRadius: Configuration.shared.pegHoleRadius)

        self.zPosition = Layer.pegHoles
        self.position = position
        self.fillColor = Configuration.shared.pegHoleColor
        self.strokeColor = self.fillColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}
