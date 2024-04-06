//
//  PaddingLabel.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import UIKit

public final class PaddingLabel: UILabel {
    
    private let padding: UIEdgeInsets
    
    public init(text: String,
                font: UIFont,
                backgroundColor: UIColor = .orange,
                padding: Padding = .medium) {
        self.padding = padding.insets
        super.init(frame: .zero)
        self.text = text
        configure(font: font, bgColor: backgroundColor)
        textAlignment = .center
        clipsToBounds = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect.inset(by: padding))
    }
    
    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        if contentSize == .zero { return contentSize }
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

    func configure(font: UIFont, bgColor: UIColor) {
        self.font = font
        self.textColor = .white
        backgroundColor = bgColor
        layer.cornerRadius = 22
    }
}

public enum Padding {
    case small
    case medium
    case custom(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    
    var insets: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        case .medium:
            return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        case .custom(let top, let left, let bottom, let right):
            return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        }
    }
}
