//
//  SetNicknameViewController.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/6/24.
//

import UIKit

class SetNicknameViewController: UIViewController {
    
    private let chainImage1 = UIImageView().then {
        $0.image = UIImage(named: "chain1")
        $0.contentMode = .scaleToFill
    }
    
    private let chainImage2 = UIImageView().then {
        $0.image = UIImage(named: "chain2")
        $0.contentMode = .scaleToFill
    }
    
    private let pledgeView = UIView().then {
        $0.backgroundColor = UIColor(named: "primary")
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor(named: "black")?.cgColor
    }
    
    private let pledgeLabel = UILabel().then {
        $0.text = "서약서"
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    
    private let mainLabel = UILabel().then {
        $0.text = "본인은 락or락을 이용하는 동안\n아래 사항을 준수할 것을 약속합니다."
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let detailLabel1 = UILabel().then {
        $0.text = "첫째\n어떠한 퀴즈 질문에도 성실히 답변할 것을\n약속합니다."
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let detailLabel2 = UILabel().then {
        $0.text = "둘째\n퀴즈 결과는 오롯이 재미로만 받아들일 것을\n약속합니다."
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let detailLabel3 = UILabel().then {
        $0.text = "셋째\n퀴즈 결과를 공유하여 평화(?)에 기여할 것을 약속합니다"
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let nicknameTextField = UITextField().then {
        $0.textColor = .white
        $0.borderStyle = .none
    }
    
    private let numberOfCharacter = UILabel().then {
        $0.text = "0자/20자"
        $0.textColor = UIColor(named: "gray")
    }
    
    private let borderLine = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.backgroundColor = UIColor(named: "primary")
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 6
        $0.contentHorizontalAlignment = .center
        $0.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        nicknameTextField.delegate = self
        addSubViews()
        setLayout()
        setupKeyboardEvent()
    }
    
    private func addSubViews() {
        [chainImage1, chainImage2, containerView, pledgeView, nicknameTextField, numberOfCharacter, borderLine, startButton].forEach { view.addSubview($0) }
        pledgeView.addSubview(pledgeLabel)
        pledgeLabel.bringSubviewToFront(containerView)
        [mainLabel, detailLabel1, detailLabel2, detailLabel3].forEach { containerView.addSubview($0) }
    }
    
    private func setLayout() {
        chainImage1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(169)
            $0.width.equalTo(100)
        }
        
        chainImage2.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(169)
            $0.width.equalTo(200)
        }
        
        pledgeView.snp.makeConstraints {
            $0.top.equalTo(chainImage1.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(124)
            $0.height.equalTo(63)
        }
        
        pledgeLabel.snp.makeConstraints {
            $0.top.equalTo(pledgeView.snp.top).offset(19)
            $0.centerX.equalTo(pledgeView.snp.centerX)
            $0.leading.equalTo(view.snp.leading).offset(30)
        }
        
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(pledgeLabel.snp.bottom).offset(-10)
            $0.leading.equalTo(view.snp.leading).offset(10)
            $0.height.equalTo(343)
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(45)
            $0.centerX.equalTo(containerView)
        }
        
        detailLabel1.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(containerView)
            $0.leading.trailing.equalTo(containerView).inset(10)
        }
        
        detailLabel2.snp.makeConstraints {
            $0.top.equalTo(detailLabel1.snp.bottom).offset(12)
            $0.centerX.equalTo(containerView)
            $0.leading.trailing.equalTo(containerView).inset(10)
        }
        
        detailLabel3.snp.makeConstraints {
            $0.top.equalTo(detailLabel2.snp.bottom).offset(12)
            $0.centerX.equalTo(containerView)
            $0.leading.trailing.equalTo(containerView).inset(10)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(12)
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.width.equalTo(100)
            $0.height.equalTo(59)
        }
        
        numberOfCharacter.snp.makeConstraints {
            $0.leading.equalTo(nicknameTextField.snp.trailing).offset(10)
            $0.trailing.equalTo(view.snp.trailing).offset(-10)
            $0.width.equalTo(78)
            $0.height.equalTo(18)
        }
        
        borderLine.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(-10)
            $0.leading.equalTo(13)
            $0.height.equalTo(1)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.height.equalTo(64)
        }
    }
    
    @objc private func startButtonTapped() {
        let homeVC = HomeViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardHeight
        }
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      view.endEditing(true)
  }
}


extension SetNicknameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if let char = string.cString(using: String.Encoding.utf8) {
              let isBackSpace = strcmp(char, "\\b")
              if isBackSpace == -92 {
                  return true
              }
        }
        guard textField.text!.count < 20 else { return false }
        return true
    }
}
