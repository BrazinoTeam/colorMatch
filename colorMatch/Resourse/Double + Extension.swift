//
//  Double + Extension.swift

import Foundation
import UIKit

extension Double {
    var autoSize: CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let statusBarOrientation = windowScene.interfaceOrientation
            let screenSize = UIScreen.main.bounds.size
            let referenceSizeHeight: CGFloat = 852
            let referenceSizeWidth: CGFloat = 393

            let screenSizeOrientationHeight = statusBarOrientation.isPortrait ? screenSize.height : screenSize.width
            let screenSizeOrientationWidth = statusBarOrientation.isPortrait ? screenSize.width : screenSize.height

            let maxAspectRatioHeight = screenSizeOrientationHeight / referenceSizeHeight
            let maxAspectRatioWidth = screenSizeOrientationWidth / referenceSizeWidth
            
            let maxAspectRatio = min(maxAspectRatioHeight, maxAspectRatioWidth)
            
            return CGFloat(self) * maxAspectRatio
        }
        return CGFloat(self) 
    }
}


