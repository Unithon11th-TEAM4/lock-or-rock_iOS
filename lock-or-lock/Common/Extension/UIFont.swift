//
//  UIFont.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import UIKit

enum LockOrLockFont: CaseIterable {
    case waguri
    case oAGothicMedium
    case oAGothicExtraBold
    
    var fontName: String {
        switch self {
        case .waguri: return "WAGURI"
        case .oAGothicMedium: return "OAGothic-Medium"
        case .oAGothicExtraBold: return "OAGothic-ExtraBold"
        
        }
    }
}

extension UIFont {
    static func lockOrLock(font: LockOrLockFont, size: CGFloat) -> UIFont {
        return UIFont(name: font.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func waguri(size: CGFloat) -> UIFont {
        return UIFont(name: LockOrLockFont.waguri.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func oAGothicMedium(size: CGFloat) -> UIFont {
        return UIFont(name: LockOrLockFont.oAGothicMedium.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func oAGothicExtraBold(size: CGFloat) -> UIFont {
        return UIFont(name: LockOrLockFont.oAGothicExtraBold.fontName, size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
