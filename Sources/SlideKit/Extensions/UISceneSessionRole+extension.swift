//
//  UISceneSessionRole+extension.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if os(iOS)
import UIKit

extension UISceneSession.Role {

    static var externalDisplay: UISceneSession.Role {
        if #available(iOS 16.0, *) {
            return .windowExternalDisplayNonInteractive
        } else {
            return .windowExternalDisplay
        }
    }
}
#endif
