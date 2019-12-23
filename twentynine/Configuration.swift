import SpriteKit

struct Configuration {
    static let shared = Configuration()
    
    let sceneSize = CGSize(width: 1366, height: 1024)
    let sceneScaleMode: SKSceneScaleMode = .aspectFill

    
    let pegHoleColor: UIColor = .black
    let pegHoleRadius: CGFloat = 5

    let pegColorPlayer1: UIColor = .red
    let pegColorPlayer2: UIColor = .green
    let pegColorPlayer3: UIColor = .blue
    let pegRadius: CGFloat = 8
}
