import SpriteKit

class GameScene: SKScene {
    
    private var width: CGFloat!
    private var height: CGFloat!
    
    private var movingPeg: PegNode?
    
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
        background.position = CGPoint(x: width / 2, y: height / 2)
        addChild(background)
    }
    
    private func setupGameBoard() {
        let gameBoard = readGameBoard()
        
        setup(player: gameBoard.player1, color: .red, isPlaying: true)
        setup(player: gameBoard.player2, color: .green, isPlaying: true)
        setup(player: gameBoard.player3, color: .blue, isPlaying: false)
        setup(finish: gameBoard.finish)
    }
    
    private func setup(player: GameBoardPlayer, color: UIColor, isPlaying: Bool) {
        let playerNode = PlayerNode(
            start1: player.start1.toAbsolute(width, height),
            start2: player.start2.toAbsolute(width, height),
            points: player.points.map{ $0.toAbsolute(self.width, self.height) },
            color: color,
            isPlaying: isPlaying)
        playerNode.addToScene(self)
    }
    
    private func setup(finish relativePosition: CGPoint) {
        let pegHoleNode = PegHoleNode(position: relativePosition.toAbsolute(width, height))
        addChild(pegHoleNode)
    }
    
    private func readGameBoard() -> GameBoard {
        let decoder = PropertyListDecoder()
        guard
            let dataFile = Bundle.main.url(forResource: BoardNodesDataFiles.twentyNine, withExtension: nil),
            let data = try? Data(contentsOf: dataFile),
            let gameBoard = try? decoder.decode(GameBoard.self, from: data)
            else { fatalError("Unable to read game board nodes") }
        
        return gameBoard
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        
        movingPeg = nodes(at: location).first { $0 is PegNode } as? PegNode
        if let peg = movingPeg {
            print("touched peg at \(peg.position)")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard
            let peg = movingPeg,
            let location = touches.first?.location(in: self)
            else { return }
        
        peg.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingPeg = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingPeg = nil
    }
}
