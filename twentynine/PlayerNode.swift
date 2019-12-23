import SpriteKit

class PlayerNode: SKNode {

    private let holePositions: [CGPoint]
    
    private let pegColor: UIColor
    private var pegPositionIndexes = [Int]()
    
    private var pegs = [PegNode]()

    init(holePositions: [CGPoint], pegColor: UIColor, isPlaying: Bool) {
        self.holePositions = holePositions
        self.pegColor = pegColor

        if isPlaying {
            pegPositionIndexes = [0, 0]
        }

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    func addToScene(_ scene: SKScene) {
        zPosition = Layer.pegHoles
        scene.addChild(self)
        
        for holePosition in holePositions {
            addPegHoleNode(position: holePosition)
        }
        
        for pegPositionIndex in pegPositionIndexes {
            let position = holePositions[pegPositionIndex]
            addPegNode(position: position)
        }
    }
    
    private func addPegHoleNode(position: CGPoint) {
        let pegHoleNode = PegHoleNode(position: position)
        addChild(pegHoleNode)
    }
    
    private func addPegNode(position: CGPoint) {
        let pegNode = PegNode(position: position, color: pegColor)
        pegs.append(pegNode)
        addChild(pegNode)
    }
    
    func getBackPeg() -> PegNode {
        if pegs.count == 0 {
            fatalError("getBackPeg called on for player that is not playing")
        }

        return pegPositionIndexes[0] < pegPositionIndexes[1] ? pegs[0] : pegs[1]
    }
    
    func resetPosition(_ peg: PegNode) {
        guard let index = pegs.firstIndex(of: peg) else {
            fatalError("resetPosition called on peg that is not a child of the player")
        }
        
        let holeIndex = pegPositionIndexes[index]
        
        peg.position = holePositions[holeIndex]
    }
    
    func setPositionToClosestHole(_ peg: PegNode) {
        guard let pegIndex = pegs.firstIndex(of: peg) else {
            fatalError("setPositionToClosestHole called on peg that is not a child of the player")
        }

        let holeIndex = closestHolePositionIndex(point: peg.position)
        let position = holePositions[holeIndex]
        
        peg.position = position
        pegPositionIndexes[pegIndex] = holeIndex
    }
    
    func closestHolePositionIndex(point: CGPoint) -> Int {
        return holePositions
            .enumerated()
            .map { (index: $0, distance: $1.distance(point: point)) }
            .sorted(by: { $0.1 < $1.1 })
            .map { $0.0 }
            .first!
    }
}
