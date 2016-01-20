// For License please refer to LICENSE file in the root of Persei project

import Foundation
import CoreGraphics

extension CGRect {
    init(boundingCenter center: CGPoint, radius: CGFloat) {
        assert(0 <= radius, "radius must be a positive value")
        
        self = CGRectInset(CGRect(origin: center, size: CGSizeZero), -radius, -radius)
    }
}