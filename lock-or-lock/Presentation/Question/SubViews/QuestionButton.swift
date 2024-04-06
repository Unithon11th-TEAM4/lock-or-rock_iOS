//
//  QuestionButton.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import UIKit
import SnapKit

final class QuestionButton: UIButton {
    
    var question: Question? {
        didSet {
            configure()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            isSelectedConfigure()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    private func setButton() {
        backgroundColor = .white
        setTitle("냠냠", for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.oAGothicExtraBold(size: 20)
        layer.borderWidth = 3
        layer.cornerRadius = 12
        clipsToBounds = true
        
    }
    
    private func configure() {
        if let image = question?.image {
            setImage(image, for: .normal)
            setTitle(nil, for: .normal)
        }
        
        if let answer = question?.answer {
            setImage(nil, for: .normal)
            setTitle(answer, for: .normal)
        }
    }
    
    private func isSelectedConfigure() {
        if isSelected {
            setTitleColor(.black, for: .normal)
            layer.borderColor = UIColor.primary.cgColor
        } else {
            setTitleColor(UIColor.lightGray, for: .normal)
            layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    
    func resetLayout() {
        setTitle(nil, for: .normal)
        setImage(nil, for: .normal)
        isSelected = false
    }
}

