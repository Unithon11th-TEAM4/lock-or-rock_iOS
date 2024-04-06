//
//  ReportViewController.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReactorKit

class ReportViewController: UIViewController {
    
    private let reactor: ReportReactor
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    private let nameTitleLabel: UILabel = {
        $0.text = "000님의\n레포트입니다."
        $0.font = UIFont.waguri(size: 25)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let reportView = ReportView()
    private let likeButton = LikeButton()
    
    private let instagramButton: UIButton = {
        $0.setTitle("인스타그램으로 공유하기", for: .normal)
        $0.titleLabel?.font = UIFont.waguri(size: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .clear
        return $0
    }(UIButton())
    
    private let rankingButton: UIButton = {
        $0.setTitle("랭킹 확인하기", for: .normal)
        $0.titleLabel?.font = UIFont.waguri(size: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.backgroundColor = .primary
        return $0
    }(UIButton())
    
    // MARK: - Life Cycles
    init(reactor: ReportReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setView()
        addView()
        setLayout()
        bind(reactor: reactor)
        
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = UIColor.dark
    }
    
    private func addView() {
        [
           nameTitleLabel,
           reportView,
           likeButton,
           instagramButton,
           rankingButton
        ].forEach {
            view.addSubview($0)
        }

    }
    
    private func setLayout() {
        nameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
        }
        
        reportView.snp.makeConstraints { make in
            make.top.equalTo(nameTitleLabel.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(380)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(reportView.snp.bottom).inset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(30)
        }
        
        rankingButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(33)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(64)
        }
        
        instagramButton.snp.makeConstraints { make in
            make.bottom.equalTo(rankingButton.snp.top).inset(-10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(64)
        }
    }
}

// MARK: - Bind
extension ReportViewController: View {
    func bind(reactor: ReportReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    func bindAction(reactor: ReportReactor) {
        
    }

    func bindState(reactor: ReportReactor) {
        
    }
}
