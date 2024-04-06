//
//  HomeViewController.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import UIKit
import Then
import SnapKit

class HomeViewController: UIViewController {
    
    private let cautionImage = UIImageView().then {
        $0.image = UIImage(named: "caution")
        $0.contentMode = .scaleToFill
    }
    
    var labelStackView: UIStackView!
    
    private let userLaebl = UILabel().then {
        $0.text = "평화호소인님"
        $0.font = .waguri(size: 30)
        $0.textColor = .white
    }
    
    private let welcomeLaebl = UILabel().then {
        $0.text = "환영합니다!"
        $0.font = .waguri(size: 26)
        $0.textColor = .white
    }
    
    private let mainImage = UIImageView().then {
        $0.image = UIImage(named: "mainImage")
        $0.contentMode = .scaleToFill
    }
    
    private let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: "backgroundHeart")
        $0.contentMode = .scaleToFill
    }
    
    private let startQuestionButton = UIButton().then {
        $0.setTitle("퀴즈 풀기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "primary")
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.white.cgColor
        $0.titleLabel?.font = .waguri(size: 30)
        $0.addTarget(self, action: #selector(startQuestionButtonTapped), for: .touchUpInside)
    }
    
    private let checkRankgingButton = UIButton().then {
        $0.setTitle("랭킹 확인하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.titleLabel?.font = .waguri(size: 18)
        $0.addTarget(self, action: #selector(checkRankgingButtonTappend), for: .touchUpInside)
    }
    
    private let proposeQuestionButton = UIButton().then {
        $0.setTitle("퀴즈 제안하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "lightBlack")
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.titleLabel?.font = .waguri(size: 18)
        $0.addTarget(self, action: #selector(proposeQuestionButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "black")
        
        addSubViews()
        setupLayout()
    }
    
    private func addSubViews() {
        labelStackView = UIStackView(arrangedSubviews: [userLaebl, welcomeLaebl])
        [cautionImage,
         labelStackView,
         backgroundImage,
         mainImage,
         startQuestionButton,
         checkRankgingButton,
         proposeQuestionButton].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        labelStackView.axis = .vertical
        labelStackView.spacing = 3
        
        cautionImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(cautionImage.snp.bottom)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(84)
        }
        
        backgroundImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(171)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(380)
        }
        
        mainImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(33)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cautionImage.snp.bottom).offset(60)
        }
        
        startQuestionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.top.equalTo(mainImage.snp.bottom).offset(50)
            $0.height.equalTo(84)
        }
        
        checkRankgingButton.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.top.equalTo(startQuestionButton.snp.bottom).offset(30)
            $0.height.equalTo(84)
            $0.width.equalTo(170)
        }
        
        proposeQuestionButton.snp.makeConstraints {
            $0.leading.equalTo(checkRankgingButton.snp.trailing).offset(5)
            $0.trailing.equalTo(view.snp.trailing).offset(-15)
            $0.top.equalTo(startQuestionButton.snp.bottom).offset(30)
            $0.height.equalTo(84)
        }
    }
    
    @objc func startQuestionButtonTapped() {
//        let questionVC = QuestionViewController()
//        self.navigationController?.pushViewController(questionVC, animated: true)
    }
    
    @objc func proposeQuestionButtonTapped() {
//        let proposeQuizVC = proposeQuizViewController()
//        self.navigationController?.pushViewController(proposeQuizVC, animated: true)
    }
    
    @objc func checkRankgingButtonTappend() {
//        let leaderBoardVC = RankingViewController()
//        self.navigationController?.pushViewController(leaderBoardVC, animated: true)
    }
}
