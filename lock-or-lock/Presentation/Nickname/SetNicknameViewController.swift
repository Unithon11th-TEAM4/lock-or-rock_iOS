//
//  SetNicknameViewController.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/6/24.
//

import UIKit
import Moya

class SetNicknameViewController: UIViewController {
    
    let provider = MoyaProvider<NameService>(plugins: [NetworkLogger()])
    
    private let cautionImage = UIImageView().then {
        $0.image = UIImage(named: "caution")
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
        $0.font = .waguri(size: 24)
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    
    private let mainLabel = UILabel().then {
        $0.text = "본인은 락or락을 이용하는 동안\n아래 사항을 준수할 것을 약속합니다."
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .oAGothicExtraBold(size: 14)
    }
    
    private let detailLabel1 =  UILabel().then {
        $0.text = "첫째\n어떠한 퀴즈 질문에도 성실히 답변할 것을\n약속합니다."
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .oAGothicMedium(size: 14)
        
        let attributedString = NSMutableAttributedString(string: $0.text ?? "")
        attributedString.addAttribute(.font, value: UIFont(name: LockOrLockFont.oAGothicExtraBold.fontName, size: 14), range: ($0.text! as NSString).range(of: "첫째"))
        $0.attributedText = attributedString
    }
    
    
    private let detailLabel2 = UILabel().then {
        $0.text = "둘째\n퀴즈 결과는 오롯이 재미로만 받아들일 것을\n약속합니다."
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .oAGothicMedium(size: 14)
        
        let attributedString2 = NSMutableAttributedString(string: $0.text ?? "")
        attributedString2.addAttribute(.font, value: UIFont(name: LockOrLockFont.oAGothicExtraBold.fontName, size: 14), range: ($0.text! as NSString).range(of: "둘째"))
        $0.attributedText = attributedString2
    }
    
    private let detailLabel3 = UILabel().then {
        $0.text = "셋째\n퀴즈 결과를 공유하여 평화(?)에 기여할 것을\n약속합니다"
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .oAGothicMedium(size: 14)
        
        let attributedString3 = NSMutableAttributedString(string: $0.text ?? "")
        attributedString3.addAttribute(.font, value: UIFont(name: LockOrLockFont.oAGothicExtraBold.fontName, size: 14), range: ($0.text! as NSString).range(of: "셋째"))
        $0.attributedText = attributedString3
    }
    
    private let nicknameTextField = UITextField().then {
        $0.textColor = .white
        $0.borderStyle = .none
        $0.font = .waguri(size: 18)
    }
    
    private let numberOfCharacter = UILabel().then {
        $0.textColor = UIColor(named: "gray")
        $0.font = .pretendardMedium(size: 14)
        
    }
    
    private let borderLine = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.font = .waguri(size: 18)
        $0.backgroundColor = UIColor(named: "gray3")
        $0.setTitleColor(UIColor(named: "brightGray"), for: .normal)
        $0.layer.cornerRadius = 6
        $0.contentHorizontalAlignment = .center
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor(named: "gray2")?.cgColor
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "black")
        nicknameTextField.delegate = self
        addSubViews()
        setLayout()
        setupKeyboardEvent()
        updateCharacterCountLabel()
    }
    
    private func addSubViews() {
        [cautionImage, containerView, pledgeView, nicknameTextField, numberOfCharacter, borderLine, startButton].forEach { view.addSubview($0) }
        pledgeView.addSubview(pledgeLabel)
        pledgeLabel.bringSubviewToFront(containerView)
        [mainLabel, detailLabel1, detailLabel2, detailLabel3].forEach { containerView.addSubview($0) }
    }
    
    private func setLayout() {
        cautionImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        pledgeView.snp.makeConstraints {
            $0.top.equalTo(cautionImage.snp.bottom).offset(20)
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
            $0.top.equalTo(mainLabel.snp.bottom).offset(20)
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
            $0.top.equalTo(containerView.snp.bottom).offset(20)
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.width.equalTo(100)
            $0.height.equalTo(59)
        }
        
        numberOfCharacter.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(40)
            $0.trailing.equalToSuperview()
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
        guard let nicknameText = nicknameTextField.text else { return }
        provider.request(.saveName(nickname: nicknameText)) { [weak self] (result) in
            switch result {
            case let .success(response):
                guard let result = try? response.map(NicknameResponse.self) else { return }
                TokenManager.shared.saveUserId(userId: result.data.memberId)
                self?.presentHomeViewController()
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func presentHomeViewController() {
        let homeVC = HomeViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false)
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
        updateCharacterCountLabel()
        activateStartButton()
        
       if let char = string.cString(using: String.Encoding.utf8) {
              let isBackSpace = strcmp(char, "\\b")
              if isBackSpace == -92 {
                  return true
              }
        }
        guard textField.text!.count < 20 else { return false }
        return true
    }
    
    
    func activateStartButton() {
        startButton.isEnabled = true
        startButton.backgroundColor = UIColor(named: "primary")
        startButton.setTitleColor(UIColor(named: "white"), for: .normal)
        startButton.layer.borderColor = UIColor(named: "black")?.cgColor
    }
    
    // 글자 수 확인
    func updateCharacterCountLabel() {
        if let text = nicknameTextField.text {
            let characterCount = text.count
            numberOfCharacter.text = "\(characterCount)/20자"
        } else {
            numberOfCharacter.text = "0자/20자"
        }
    }
}
