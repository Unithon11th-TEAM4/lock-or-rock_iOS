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

enum QuestionButtonType: Int {
    case leftTop = 0
    case rightTop = 1
    case leftBottom = 2
    case rightBottom = 3
}

class QuestionViewController: UIViewController {
    
    private let reactor: QuestionReactor
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    private let questionNumLabel = PaddingLabel(text: "1/5", font: UIFont.oAGothicExtraBold(size: 18), backgroundColor: .primary, padding: .medium)
    
    private let questionTitleLabel: UILabel = {
        $0.text = "퀴즈를 불러오는 중"
        $0.font = UIFont.lockOrLock(font: .oAGothicMedium, size: 20)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .white
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
    
    private let toolTipLabel: UILabel = {
        $0.text = "한 번 선택하면 되돌릴 수 없어요!"
        $0.font = UIFont.oAGothicExtraBold(size: 14)
        $0.textColor = .red
        $0.isHidden = false
        return $0
    }(UILabel())
    
    private let nextButton: UIButton = {
        $0.setTitle("다음질문", for: .normal)
        $0.backgroundColor = .lightGray
        $0.titleLabel?.font = UIFont.waguri(size: 18)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 3
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.isEnabled = false
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
        bind(reactor: reactor)
        reactor.fetchQuestions()
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = UIColor.dark
    }
    
    private func addView() {
        [
            questionNumLabel,
            questionTitleLabel,
            topStackView,
            bottomStackView,
            toolTipLabel,
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
            make.leading.trailing.equalToSuperview().inset(40)
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
        
        toolTipLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomStackView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(90)
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
        leftTopButton.rx.tap
            .bind { [weak self] _ in
                self?.reactor.action.onNext(.answerNumber(.leftTop))
            }
            .disposed(by: disposeBag)
        
        rightTopButton.rx.tap
            .bind { [weak self] _ in
                self?.reactor.action.onNext(.answerNumber(.rightTop))
            }
            .disposed(by: disposeBag)
        
        leftBottomButton.rx.tap
            .bind { [weak self] _ in
                self?.reactor.action.onNext(.answerNumber(.leftBottom))
            }
            .disposed(by: disposeBag)
        
        rightBottomButton.rx.tap
            .bind { [weak self] _ in
                self?.reactor.action.onNext(.answerNumber(.rightBottom))
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] _ in
                if self?.reactor.currentState.currentQuestionNum == 5 {
                    self?.reactor.postAnswer()
                } else {
                    self?.reactor.appendAnswer()
                }
            }
            .disposed(by: disposeBag)
    }

    func bindState(reactor: QuestionReactor) {
        reactor.state
            .map { $0.currentAnswerNum }
            .bind { [weak self] answerNum in
                if let answerNum {
                    switch answerNum {
                    case .leftTop:
                        self?.leftTopButton.isSelected = true
                        self?.rightTopButton.isSelected = false
                        self?.leftBottomButton.isSelected = false
                        self?.rightBottomButton.isSelected = false
                    case .rightTop:
                        self?.leftTopButton.isSelected = false
                        self?.rightTopButton.isSelected = true
                        self?.leftBottomButton.isSelected = false
                        self?.rightBottomButton.isSelected = false
                    case .leftBottom:
                        self?.leftTopButton.isSelected = false
                        self?.rightTopButton.isSelected = false
                        self?.leftBottomButton.isSelected = true
                        self?.rightBottomButton.isSelected = false
                    case .rightBottom:
                        self?.leftTopButton.isSelected = false
                        self?.rightTopButton.isSelected = false
                        self?.leftBottomButton.isSelected = false
                        self?.rightBottomButton.isSelected = true
                    }
                    self?.toolTipLabel.isHidden = false
                    self?.nextButton.isEnabled = true
                    self?.nextButton.backgroundColor = .primary
                    self?.nextButton.layer.borderColor = UIColor.black.cgColor
                } else {
                    self?.toolTipLabel.isHidden = true
                    self?.leftTopButton.isSelected = false
                    self?.rightTopButton.isSelected = false
                    self?.leftBottomButton.isSelected = false
                    self?.rightBottomButton.isSelected = false
                    self?.nextButton.isEnabled = false
                    self?.nextButton.backgroundColor = UIColor.lightGray
                    self?.nextButton.layer.borderColor = UIColor.gray.cgColor
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.currentQuestionNum }
            .bind { [weak self] questionNum in
                self?.questionNumLabel.text = "\(questionNum)/5"
                guard let questions = self?.reactor.currentState.questionsResponse else { return }
                
                if !questions.isEmpty {
                    self?.questionTitleLabel.text = questions[questionNum-1].content
                    self?.leftTopButton.question = questions[questionNum-1].answers[0]
                    self?.rightTopButton.question = questions[questionNum-1].answers[1]
                    self?.leftBottomButton.question = questions[questionNum-1].answers[2]
                    self?.rightBottomButton.question = questions[questionNum-1].answers[3]
                }
                
                if questionNum == 5 {
                    self?.nextButton.setTitle("결과보기", for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.issuccessedPost }
            .bind { [weak self] reportReponse in
                guard let reportReponse else { return }
                let reportReactor = ReportReactor(reportReponse: reportReponse)
                let reportViewController = ReportViewController(reactor: reportReactor)
                reportViewController.modalPresentationStyle = .overFullScreen
                self?.present(reportViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
