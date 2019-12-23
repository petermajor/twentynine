import UIKit

extension CGPoint {
    func toAbsolute(_ width: CGFloat, _ height: CGFloat) -> CGPoint {
        CGPoint(x: self.x * width, y: self.y * height)
    }
}
