import SpriteKit

class PlayerNode: SKNode {

    private let start1: CGPoint
    private let start2: CGPoint
    private let points: [CGPoint]
    private let color: UIColor

    private var pegIndexes = [Int]()
    
    init(start1: CGPoint, start2: CGPoint, points: [CGPoint], color: UIColor, isPlaying: Bool) {

        self.start1 = start1
        self.start2 = start2
        self.points = points
        self.color = color

        if isPlaying {
            pegIndexes = [-1, -2]
        }

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    func addToScene(_ scene: SKScene) {
        zPosition = Layer.pegHoles
        scene.addChild(self)
        
        addPegHoleNode(position: start1)
        addPegHoleNode(position: start2)
        
        for point in points {
            addPegHoleNode(position: point)
        }
        
        for pegIndex in pegIndexes {
            let position = getPositionForHoleIndex(pegIndex)
            addPegNode(position: position)
        }
    }
    
    private func addPegHoleNode(position: CGPoint) {
        let pegHoleNode = PegHoleNode(position: position)
        addChild(pegHoleNode)
    }
    
    private func addPegNode(position: CGPoint) {
        let pegNode = PegNode(position: position, color: color)
        addChild(pegNode)
    }
    
    private func getPositionForHoleIndex(_ index: Int) -> CGPoint {
        switch index {
        case -2:
            return start2
        case -1:
            return start1
        default:
            return points[index]
        }
    }
}
