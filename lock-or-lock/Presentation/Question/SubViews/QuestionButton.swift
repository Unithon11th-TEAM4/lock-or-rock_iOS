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
        setTitle("냠냠", for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 18)
        backgroundColor = .clear
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 12
        clipsToBounds = true
        
    }
    
    private func configure() {
        if let image = question?.image {
            setImage(image, for: .normal)
        }
        
        if let answer = question?.answer {
            setTitle(answer, for: .normal)
        }
    }
    
    private func isSelectedConfigure() {
        if isSelected {
            layer.borderColor = UIColor.yellow.cgColor
        } else {
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    private func resetLayout() {
        setTitle(nil, for: .normal)
        setImage(nil, for: .normal)
    }
}

