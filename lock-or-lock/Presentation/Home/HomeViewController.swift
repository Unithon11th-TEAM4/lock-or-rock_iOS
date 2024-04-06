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
    
    private let devilImage = UIImageView().then {
        $0.image = UIImage(named: "devil")
        $0.contentMode = .scaleToFill
    }
    
    func configurationButton(_ button: UIButton, action: Selector) {
        button.backgroundColor = UIColor(named: "primary")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(named: "black")?.cgColor
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets.left = 20
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        
    }
    
    private let startQuestionButton = UIButton().then {
        $0.setTitle("퀴즈 풀기", for: .normal)
        $0.addTarget(self, action: #selector(startQuestionButtonTapped), for: .touchUpInside)
    }
    
    private let proposeQuestionButton = UIButton().then {
        $0.setTitle("퀴즈 제안하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.borderColor = UIColor(named: "black")?.cgColor
        $0.addTarget(self, action: #selector(proposeQuestionButtonTapped), for: .touchUpInside)
    }
    
    private let viewRankgingButton = UIButton().then {
        $0.setTitle("랭킹 확인하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor(named: "black")?.cgColor
        $0.addTarget(self, action: #selector(viewRankgingButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        addSubViews()
        setupLayout()
    }
    
    private func addSubViews() {
        [cautionImage, devilImage, startQuestionButton, proposeQuestionButton, viewRankgingButton].forEach { view.addSubview($0) }
        devilImage.bringSubviewToFront(cautionImage)
    }
    
    private func setupLayout() {
        cautionImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        devilImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        startQuestionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.top.equalTo(view.snp.bottom).offset(296)
            $0.height.equalTo(245)
        }
        
        proposeQuestionButton.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.top.equalTo(startQuestionButton.snp.bottom).offset(30)
        }
        
        viewRankgingButton.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(50)
            $0.top.equalTo(startQuestionButton.snp.bottom).offset(30)
            $0.height.equalTo(169)
        }
    }
    
    @objc func startQuestionButtonTapped() {
//        let quizVC = QuizViewController()
//        self.navigationController?.pushViewController(quizVC, animated: true)
    }
    
    @objc func proposeQuestionButtonTapped() {
//        let proposeQuizVC = proposeQuizViewController()
//        self.navigationController?.pushViewController(proposeQuizVC, animated: true)
    }
    
    @objc func viewRankgingButtonTapped() {
//        let leaderBoardVC = leaderBoardViewController()
//        self.navigationController?.pushViewController(leaderBoardVC, animated: true)
    }
}
