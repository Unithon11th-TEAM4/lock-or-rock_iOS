//
//  LikeView.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import UIKit
import SnapKit

protocol LikeViewDelegate: AnyObject {
    func likeButtonTapped()
}

final class LikeView: UIView {
    
    weak var delegate: LikeViewDelegate?
    
    // MARK: - Properties
    private let likeLabel: UILabel = {
        $0.text = "좋아요"
        $0.font = .oAGothicMedium(size: 18)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let heartButton: UIButton = {
        $0.setImage(UIImage(named: "heart.fill")?.withTintColor(.pink, renderingMode: .alwaysOriginal), for: .normal)
        return $0
    }(UIButton())
    
    let likeNumberLabel: UILabel = {
        $0.text = ""
        $0.font = .oAGothicMedium(size: 18)
        $0.textColor = .pink
        return $0
    }(UILabel())
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    private func setView() {
        [
            likeLabel,
            heartButton,
            likeNumberLabel
        ].forEach {
            addSubview($0)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(25)
        }
        
        heartButton.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(26)
            make.centerY.equalToSuperview()
            make.leading.equalTo(likeLabel.snp.trailing).inset(-10)
        }
        
        likeNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(heartButton.snp.trailing).inset(-10)
        }
    }
    
    func addGesture() {
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    @objc func heartButtonTapped() {
        delegate?.likeButtonTapped()
    }
}
