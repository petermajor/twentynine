import SpriteKit
//import GameplayKit

class GameScene: SKScene {
    
    var width: CGFloat!
    var height: CGFloat!

    override func willMove(from view: SKView) {
        super.willMove(from: view)
        
        size = CGSize(width: 1366, height: 1024)
        scaleMode = .aspectFill
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        print("scene size: \(size)")
        print("scene anchorPoint: \(anchorPoint)")
        
        width = size.width
        height = size.height

        setupBackground()
        setupGameBoard()
    }

    private func setupBackground() {
        
        let background = SKSpriteNode(imageNamed: ImageName.backgroundWood)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
    }
 
    private func setupGameBoard() {
        let gameBoard = readGameBoard()
        
        setupPlayer(gameBoard.player1)
        setupPlayer(gameBoard.player2)
        setupPlayer(gameBoard.player3)
        
        //setupFinish(gameBoard.finish)
    }
    
    private func setupPlayer(_ player: GameBoardPlayer) {
        let playerNode = PlayerNode(start1: toAbsolute(player.start1), start2: toAbsolute(player.start2), points: player.points.map{ toAbsolute($0) })
        playerNode.addToScene(self)
    }
    
    private func toAbsolute(_ relative: CGPoint) -> CGPoint {
        CGPoint(x: relative.x * width, y: relative.y * height)
    }
    
//    private func setupFinish() {
//
//    }
    
    private func readGameBoard() -> GameBoard {
        let decoder = PropertyListDecoder()
        guard
            let dataFile = Bundle.main.url(forResource: BoardNodesDataFiles.twentyNine, withExtension: nil),
            let data = try? Data(contentsOf: dataFile),
            let gameBoard = try? decoder.decode(GameBoard.self, from: data)
        else {
            fatalError("Unable to read game board nodes")
        }
        
        return gameBoard
    }

    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//    
//    override func didMove(to view: SKView) {
//        
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//        
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//        
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//            
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
//    }
//    
//    
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//    
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//    
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//        
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//    
//    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
}
