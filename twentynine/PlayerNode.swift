import UIKit
import SpriteKit

class PlayerNode: SKNode {

    let circleRadius: CGFloat = 8
    
    let start1: CGPoint
    let start2: CGPoint
    let points: [CGPoint]
    
    init(start1: CGPoint, start2: CGPoint, points: [CGPoint]) {
        self.start1 = start1
        self.start2 = start2
        self.points = points

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        start1 = aDecoder.decodeCGPoint(forKey: "start1")
        start2 = aDecoder.decodeCGPoint(forKey: "start2")
        points = aDecoder.decodeObject(forKey: "points") as! [CGPoint]

        super.init(coder: aDecoder)
    }

    func addToScene(_ scene: SKScene) {
        zPosition = Layer.points
        scene.addChild(self)
        
        addCircleNode(position: start1)
        addCircleNode(position: start2)
        
        for point in points {
            addCircleNode(position: point)
        }
    }
    
    private func addCircleNode(position: CGPoint) {
        let circle = SKShapeNode(circleOfRadius: circleRadius)
        circle.position = position
//        circle.strokeColor = SKColor.black
//        circle.glowWidth = 1.0
        circle.fillColor = SKColor.white
        addChild(circle)
    }
}
