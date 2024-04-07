//
//  ReportView.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import UIKit
import SnapKit

final class ReportView: UIView {
    
    var reportReponse: ReportReponse? {
        didSet {
            configure()
        }
    }
    
    // MARK: - Properties
    private let imageBackgroundView: UIImageView = {
        $0.image = UIImage(named: "card")
        return $0
    }(UIImageView())
    
    var keywordStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    let nicknameLabel: UILabel = {
        $0.text = "불러오는 중!"
        $0.font = UIFont.oAGothicExtraBold(size: 28)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        addViews()
        setLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented xib init")
    }

    // MARK: - Set UI
    private func setView() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .primary
    }
    
    private func addViews() {
        addSubview(imageBackgroundView)
        
        [
            keywordStackView,
            nicknameLabel
        ].forEach {
            imageBackgroundView.addSubview($0)
        }
    }
    
    private func setLayouts() {
        imageBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        keywordStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(75)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configure() {
        guard let reportReponse else { return }
        nicknameLabel.text = "\(reportReponse.data.nickname) 님!"
        
        if keywordStackView.arrangedSubviews.count > 2 {
            return
        }
        for memberPersonality in reportReponse.data.memberPersonality {
            let keywordLabel: UILabel = {
                    let attributedString = NSMutableAttributedString(string: "\(memberPersonality.content) \(memberPersonality.verb)")
                    let strCount = memberPersonality.content.count
                    
                attributedString.addAttribute(.font, value: UIFont.oAGothicExtraBold(size: 11), range: NSRange(location: 0, length: attributedString.length))
                    attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: strCount))
                    attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: strCount, length: 1))
                    $0.attributedText = attributedString
                    return $0
                }(UILabel())
            
            keywordStackView.addArrangedSubview(keywordLabel)
        }
    }
}
