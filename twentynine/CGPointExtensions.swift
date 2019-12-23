import UIKit

extension CGPoint {
    func fromRelative(_ width: CGFloat, _ height: CGFloat) -> CGPoint {
        CGPoint(x: self.x * width, y: self.y * height)
    }
    
    func distance(point: CGPoint) -> CGFloat {
        return CGFloat(hypotf(Float(point.x - self.x), Float(point.y - self.y)))
    }
}
