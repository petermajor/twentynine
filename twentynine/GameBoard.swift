import UIKit

enum BoardNodesDataFiles {
    static let twentyNine = "GameBoardTwentyNine.plist"
}

struct GameBoard: Decodable {
    let player1: GameBoardPlayer
    let player2: GameBoardPlayer
    let player3: GameBoardPlayer
    let finish: CGPoint
    let pointRadius: CGFloat
    let canvasWidth: CGFloat
    let canvasHeight: CGFloat
}

struct GameBoardPlayer: Decodable {
    let start1: CGPoint
    let start2: CGPoint
    let points: [CGPoint]
}

