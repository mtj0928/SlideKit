//
//  UISceneSessionRole+extension.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if canImport(UIKit)
import UIKit

extension UISceneSession.Role {

    public static var externalDisplay: UISceneSession.Role {
        if #available(iOS 16.0, tvOS 16.0, *) {
            return .windowExternalDisplayNonInteractive
        } else {
            return .windowExternalDisplay
        }
    }
}
#endif
