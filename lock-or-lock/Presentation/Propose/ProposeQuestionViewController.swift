//
//  ProposeQuestionViewController.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/7/24.
//

import UIKit
import Moya

protocol TextFieldCellDelegate: AnyObject {
    func textFieldDidEndEditing(value: String)
}

class ProposeQuestionViewController: UIViewController {
    
    let provider = MoyaProvider<ProposeService>(plugins: [NetworkLogger()])
    var questionAnswers: [String] = []

    lazy var titleView = UIView().then {
        $0.backgroundColor = UIColor(named: "primary")
        addBorderStyle($0)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "퀴즈를 제안해주세요!"
        $0.font = .waguri(size: 24)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let questionLabel = UILabel().then {
        $0.text = "문제를 적어주세요."
        $0.font = .oAGothicMedium(size: 16)
        $0.textAlignment = .left
        $0.textColor = .white
    }
    
    lazy var containerQuestionView = UIView().then {
        $0.backgroundColor = .white
        addBorderStyle($0)
    }
    
    private let questionTextView = UITextView().then {
        $0.font = .oAGothicMedium(size: 18)
        $0.textColor = UIColor(named: "gray4")
        $0.text = "내용을 입력해주세요"
    }
    
    private let numberOfCharacter = UILabel().then {
        $0.textColor = UIColor(named: "gray")
        $0.font = .waguri(size: 14)
        $0.text = "0자/50자"
    }
    
    private let optionLabel = UILabel().then {
        $0.text = "보기를 적어주세요."
        $0.font = .oAGothicMedium(size: 16)
        $0.textAlignment = .left
        $0.textColor = .white
    }
    
    private let optionTableView = UITableView().then {
        $0.backgroundColor = UIColor(named: "black")
        $0.isScrollEnabled = false
    }
    
    private let submitButton = UIButton().then {
        $0.setTitle("제출하기", for: .normal)
        $0.titleLabel?.font = .waguri(size: 18)
        $0.backgroundColor = UIColor(named: "primary")
        $0.setTitleColor(UIColor(named: "white"), for: .normal)
        $0.layer.borderColor = UIColor(named: "black")?.cgColor
//        $0.backgroundColor = UIColor(named: "gray3")
//        $0.setTitleColor(UIColor(named: "brightGray"), for: .normal)
        $0.layer.cornerRadius = 6
        $0.contentHorizontalAlignment = .center
        $0.layer.borderWidth = 3
//        $0.layer.borderColor = UIColor(named: "gray2")?.cgColor
//        $0.isEnabled = false
        $0.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "black")
        addSubViews()
        setLayout()
    }
    
    private func addSubViews() {
        [titleView,
         questionLabel,
         containerQuestionView,
         optionLabel,
         optionTableView,
         submitButton].forEach { view.addSubview($0) }
        titleView.addSubview(titleLabel)
        [questionTextView,
         numberOfCharacter].forEach { containerQuestionView.addSubview($0) }
        setDelegate()
        registerCell()
    }
    
    private func addBorderStyle(_ view: UIView) {
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
        view.clipsToBounds = true
    }
    
    private func configureOptionLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .oAGothicExtraBold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegate() {
        questionTextView.delegate = self
        optionTableView.delegate = self
        optionTableView.dataSource = self
    }
    
    private func setLayout() {
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(80)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(63)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(titleView.snp.centerX)
            $0.top.equalTo(titleView.snp.top).offset(19)
            $0.leading.equalTo(titleView.snp.leading).offset(30)
        }
        
        questionLabel.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.top.equalTo(titleView.snp.bottom).offset(49)
        }
        
        containerQuestionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.top.equalTo(questionLabel.snp.bottom).offset(20)
            $0.height.equalTo(116)
        }
        
        questionTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(96)
        }
        
        numberOfCharacter.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        optionLabel.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.top.equalTo(containerQuestionView.snp.bottom).offset(20)
        }
        
        optionTableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.top.equalTo(optionLabel.snp.bottom).offset(20)
            $0.height.equalTo(280)
        }
        
        submitButton.snp.makeConstraints {
            $0.top.equalTo(optionTableView.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(10)
            $0.height.equalTo(64)
        }
    }
    
    private func registerCell() {
        self.optionTableView.register(OptionTableViewCell.self, forCellReuseIdentifier: OptionTableViewCell.identifier)
    }
    
    private func checkTextFieldStatus() {
        // 모든 텍스트 필드의 값을 검사
        var allFieldsHaveText = true
        if questionTextView.text?.isEmpty ?? true {
            allFieldsHaveText = false
            disabledSubmitButton()
        }
        submitButton.isEnabled = allFieldsHaveText
        activateSubmitButton()
    }
    
    private func activateSubmitButton() {
        submitButton.backgroundColor = UIColor(named: "primary")
        submitButton.setTitleColor(UIColor(named: "white"), for: .normal)
        submitButton.layer.borderColor = UIColor(named: "black")?.cgColor
    }
    
    private func disabledSubmitButton() {
        submitButton.backgroundColor = UIColor(named: "gray3")
        submitButton.setTitleColor(UIColor(named: "brightGray"), for: .normal)
        submitButton.layer.borderColor = UIColor(named: "gray2")?.cgColor
        submitButton.isEnabled = false
    }

    @objc private func submitButtonTapped() {
        guard let questionTextView = questionTextView.text else { return }
        
        for section in 0..<optionTableView.numberOfSections {
            // 각 섹션의 모든 행을 순회
            for row in 0..<optionTableView.numberOfRows(inSection: section) {
                // 현재 indexPath에 해당하는 셀 조회
                if let cell = optionTableView.cellForRow(at: IndexPath(row: row, section: section)) as? OptionTableViewCell {
                    questionAnswers.append(cell.optionTextField.text ?? "")
                }
            }
        }
        
        let proposedQuestion = ProposedQuestion(
            memberId: TokenManager.shared.getIntUserId(), questionContent: questionTextView, questionAnswers: questionAnswers)
        
        provider.request(.addQuestions(proposedQuestion: proposedQuestion)) { [weak self] (result) in
            switch result {
            case let .success(response):
                guard let result = try? response.map(ProposeResponse.self) else { return }
                if result.message == "OK" {
                    print("성공적으로 질문을 등록했당")
                    let completedQuestionVC = CompletedQuestionViewController()
                    self?.navigationController?.pushViewController(completedQuestionVC, animated: true)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ProposeQuestionViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        checkTextFieldStatus()
        let currentText = questionTextView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        numberOfCharacter.text = "\(changedText.count)/50자"
        return changedText.count < 50
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textView.text.isEmpty {
            textView.textColor = UIColor(named: "black")
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = .placeholderText
        }
    }
}

extension ProposeQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.identifier, for: indexPath) as! OptionTableViewCell
        
        cell.selectionStyle = .none
        cell.configureCell(at: indexPath)
        cell.optionTextField.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ProposeQuestionViewController: TextFieldCellDelegate {
    func textFieldDidEndEditing(value: String) {
        print(value)
//        questionAnswers.append(value)
//        print(questionAnswers)
//        print("화이팅")
    }
}
