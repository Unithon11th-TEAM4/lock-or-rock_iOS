//
//  CompletedQuestionViewController.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/7/24.
//

import UIKit

class CompletedQuestionViewController: UIViewController {
    
    private let completedImage = UIImageView().then {
        $0.image = UIImage(named: "completedImage")
        $0.contentMode = .scaleToFill
    }
    
    private let thanksLaebl = UILabel().then {
        $0.text = "소중한 의견 감사합니다!"
        $0.font = .waguri(size: 22)
        $0.textAlignment = .center
        $0.textColor = .white
    }
    
    private let thanksDetailLaebl = UILabel().then {
        $0.text = "관리자가 검토 후\n퀴즈에 반영할 예정입니다."
        $0.font = .oAGothicMedium(size: 18)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let submitButton = UIButton().then {
        $0.setTitle("홈으로 가기", for: .normal)
        $0.titleLabel?.font = .waguri(size: 18)
        $0.backgroundColor = UIColor(named: "primary")
        $0.setTitleColor(UIColor(named: "white"), for: .normal)
        $0.layer.borderColor = UIColor(named: "black")?.cgColor
        $0.layer.cornerRadius = 6
        $0.contentHorizontalAlignment = .center
        $0.layer.borderWidth = 3
        $0.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "black")
        self.navigationController?.navigationBar.isHidden = true
        addSubViews()
        setupLayout()
    }
    
    private func addSubViews() {
        [completedImage,
         thanksLaebl,
         thanksDetailLaebl,
         submitButton].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        completedImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(180)
            $0.height.equalTo(150)
            $0.width.equalTo(227)
        }
        
        thanksLaebl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(78)
            $0.top.equalTo(completedImage.snp.bottom).offset(70)
        }
        
        thanksDetailLaebl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(78)
            $0.top.equalTo(thanksLaebl.snp.bottom).offset(50)
        }
        
        submitButton.snp.makeConstraints {
            $0.top.equalTo(thanksDetailLaebl.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(10)
            $0.height.equalTo(64)
        }
    }
    
    @objc func homeButtonTapped() {
        let homeVC = HomeViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false)
    }
}
