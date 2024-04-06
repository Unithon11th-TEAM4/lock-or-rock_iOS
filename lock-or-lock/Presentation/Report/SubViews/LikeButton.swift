//
//  LikeButton.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import UIKit
import SnapKit

final class LikeButton: UIButton {
    
    // MARK: - Properties
    private let likeLabel: UILabel = {
        $0.text = "좋아요"
        $0.font = .oAGothicMedium(size: 18)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let heartImageView: UIImageView = {
        $0.image = UIImage(named: "heart.fill")?.withTintColor(.pink, renderingMode: .alwaysOriginal)
        return $0
    }(UIImageView())
    
    private let likeNumberLabel: UILabel = {
        $0.text = "0"
        $0.font = .oAGothicMedium(size: 18)
        $0.textColor = .pink
        return $0
    }(UILabel())
    
    private let likeStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        return $0
    }(UIStackView())
    
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
        addSubview(likeStackView)
        
        heartImageView.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(26)
        }
        
        [
            likeLabel,
            heartImageView,
            likeNumberLabel
        ].forEach {
            likeStackView.addArrangedSubview($0)
        }
        
        likeStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
