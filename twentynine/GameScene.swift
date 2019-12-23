import SpriteKit

class GameScene: SKScene {
    
    private var width: CGFloat!
    private var height: CGFloat!
    
    private var movingPeg: PegNode?
    
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        
        size = Configuration.shared.sceneSize
        scaleMode = Configuration.shared.sceneScaleMode
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
        
        setup(player: gameBoard.player1, pegColor: Configuration.shared.pegColorPlayer1, isPlaying: true)
        setup(player: gameBoard.player2, pegColor: Configuration.shared.pegColorPlayer2, isPlaying: true)
        setup(player: gameBoard.player3, pegColor: Configuration.shared.pegColorPlayer3, isPlaying: false)
        setup(finish: gameBoard.finish)
    }
    
    private func setup(player: GameBoardPlayer, pegColor: UIColor, isPlaying: Bool) {
        let playerNode = PlayerNode(
                holePositions: player.positions.map{ $0.fromRelative(self.width, self.height) },
                pegColor: pegColor,
                isPlaying: isPlaying)
        playerNode.addToScene(self)
    }
    
    private func setup(finish relativePosition: CGPoint) {
        let pegHoleNode = PegHoleNode(position: relativePosition.fromRelative(width, height))
        addChild(pegHoleNode)
    }
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard
            let location = touches.first?.location(in: self),
            let peg = nodes(at: location).first(where: { $0 is PegNode }) as? PegNode
        else {
            return
        }

        print("touchesBegan")
        
        let player = peg.player
        
        let actualPeg = player.getBackPeg()
        actualPeg.position = location
        
        movingPeg = actualPeg
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard
            let peg = movingPeg,
            let location = touches.first?.location(in: self)
        else {
            return
        }

        //print("touchesMoved")
        peg.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let peg = movingPeg else { return }
        
        print("touchesEnded")

        movingPeg = nil

        let player = peg.player
        player.setPositionToClosestHole(peg)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let peg = movingPeg else { return }

        print("touchesCancelled")
        
        movingPeg = nil

        let player = peg.player
        player.resetPosition(peg)
    }
}
