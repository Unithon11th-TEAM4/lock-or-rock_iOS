//
//  QuestionButton.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import UIKit
import SnapKit
import Kingfisher

final class QuestionButton: UIButton {
    
    var question: QuestionAnswerResponse? {
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
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.oAGothicExtraBold(size: 20)
        layer.borderWidth = 3
        layer.cornerRadius = 12
        clipsToBounds = true
        
    }
    
    private func configure() {
        guard let question else { return }
        
        if question.url != Optional("") {
            kf.setImage(with: URL(string: question.url ?? ""), for: .normal)
            setTitle(nil, for: .normal)
        } else {
            if question.content.count > 4 {
                titleLabel?.font = UIFont.waguri(size: 12)
            } else {
                titleLabel?.font = UIFont.waguri(size: 20)
            }
            setImage(nil, for: .normal)
            setTitle(question.content, for: .normal)
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

