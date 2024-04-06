//
//  UILabel+Extension.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/6/24.
//

import Foundation
import UIKit

extension UILabel {
    /* 텍스트 구간 폰트 변경 */
    func setFont(_ font: UIFont, range: NSRange) {
        guard let attributedString = self.mutableAttributedString() else { return }
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        self.attributedText = attributedString
    }
    
    /* 텍스트 구간 볼드 폰트 변경 */
    func setBoldFont(_ boldFontName: String, range: NSRange) {
        guard let font = self.font,
              let boldFont = UIFont(name: boldFontName, size: font.pointSize) else {
            return
        }
        
        return setFont(boldFont, range: range)
    }
    
    private func mutableAttributedString() -> NSMutableAttributedString? {
        guard let labelText = self.text, let labelFont = self.font else { return nil }
        
        var attributedString: NSMutableAttributedString?
        if let attributedText = self.attributedText {
            attributedString = attributedText.mutableCopy() as? NSMutableAttributedString
        } else {
            attributedString = NSMutableAttributedString(string: labelText,
                                                         attributes: [NSAttributedString.Key.font :labelFont])
        }
        return attributedString
    }
}
