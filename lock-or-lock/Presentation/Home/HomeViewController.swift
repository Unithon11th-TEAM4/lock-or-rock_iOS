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
    
    var leaderBoardStackView: UIStackView!

    private let imageView = UIImageView()
    
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
    
    lazy var viewLeaderBoardButton = UIButton().then {
        $0.setTitle("리더보드 보기", for: .normal)
        configurationButton($0, action: #selector(viewleaderBoardButtonTapped))
    }
    
    lazy var startQuestionButton = UIButton().then {
        $0.setTitle("퀴즈 풀기", for: .normal)
        configurationButton($0, action: #selector(startQuestionButtonTapped))
    }
    lazy var proposeQuestionButton = UIButton().then {
        configurationButton($0, action: #selector(startQuestionButtonTapped))
        $0.setTitle("퀴즈 제안하기", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        addSubViews()
        setupLayout()
    }
    
    private func addSubViews() {
        leaderBoardStackView = 
        UIStackView(arrangedSubviews: [imageView, viewLeaderBoardButton]).then({
            $0.axis = .horizontal
            $0.spacing = 5
        })
        
        [leaderBoardStackView, startQuestionButton, proposeQuestionButton].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        leaderBoardStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(20)
            $0.top.equalTo(view.snp.top).offset(40)
            $0.height.equalTo(71)
        }
        
        startQuestionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(50)
            $0.top.equalTo(leaderBoardStackView.snp.bottom).offset(30)
            $0.height.equalTo(169)
        }
        
        proposeQuestionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(50)
            $0.top.equalTo(startQuestionButton.snp.bottom).offset(30)
            $0.height.equalTo(169)
        }
    }
    
    @objc func viewleaderBoardButtonTapped() {
//        let leaderBoardVC = leaderBoardViewController()
//        self.navigationController?.pushViewController(leaderBoardVC, animated: true)
    }
    
    @objc func startQuestionButtonTapped() {
//        let quizVC = QuizViewController()
//        self.navigationController?.pushViewController(quizVC, animated: true)
    }
    
    @objc func proposeQuestionButtonTapped() {
//        let proposeQuizVC = proposeQuizViewController()
//        self.navigationController?.pushViewController(proposeQuizVC, animated: true)
    }
}
