//
//  QuestionViewController.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReactorKit

class QuestionViewController: UIViewController {
    
    private let reactor: QuestionReactor
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    private let questionNumLabel: UILabel = {
        $0.text = "1/5"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let questionTitleLabel: UILabel = {
        $0.text = "다음 중 지지하는\n 정치사상을 고르세요."
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let leftTopButton = QuestionButton()
    private let rightTopButton = QuestionButton()
    private let leftBottomButton = QuestionButton()
    private let rightBottomButton = QuestionButton()
    
    private lazy var topStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var bottomStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private let nextButton: UIButton = {
        $0.setTitle("다음질문", for: .normal)
        $0.backgroundColor = .lightGray
        $0.titleLabel?.font = UIFont.waguri(size: 18)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 3
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        return $0
    }(UIButton())
    
    
    // MARK: - Life Cycles
    init(reactor: QuestionReactor) {
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
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = .white
    }
    
    private func addView() {
        [
            questionNumLabel,
            questionTitleLabel,
            topStackView,
            bottomStackView,
            nextButton
        ].forEach {
            view.addSubview($0)
        }
        
        [
            leftTopButton,
            rightTopButton
        ].forEach {
            topStackView.addArrangedSubview($0)
        }
        
        [
            leftBottomButton,
            rightBottomButton
        ].forEach {
            bottomStackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        questionNumLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerX.equalToSuperview()
        }
        
        questionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(questionNumLabel.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(questionTitleLabel.snp.bottom).inset(-40)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(150)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(150)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(64)
        }
    }
}

// MARK: - Bind
extension QuestionViewController: View {
    func bind(reactor: QuestionReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    func bindAction(reactor: QuestionReactor) {
        
    }

    func bindState(reactor: QuestionReactor) {
        
    }
}
