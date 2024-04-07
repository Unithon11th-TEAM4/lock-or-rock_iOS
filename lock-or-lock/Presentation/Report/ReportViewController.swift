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
        $0.text = "불러오는 중"
        $0.font = UIFont.waguri(size: 25)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let reportView = ReportView()
    private let likeView = LikeView()
    
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
        setNavigationBar()
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = UIColor.dark
        likeView.delegate = self
    }
    
    private func addView() {
        [
           nameTitleLabel,
           reportView,
           likeView,
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
        
        likeView.snp.makeConstraints { make in
            make.top.equalTo(reportView.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview()
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
    
    private func setNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .label
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}

// MARK: - Bind
extension ReportViewController: View {
    func bind(reactor: ReportReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    func bindAction(reactor: ReportReactor) {
        instagramButton.rx.tap
            .observe(on: MainScheduler.instance)
            .bind {
                if let storiesUrl = URL(string: "instagram-stories://share?source_application=" +
                                        "921665266122530") {
                    if UIApplication.shared.canOpenURL(storiesUrl) {
                        let renderer = UIGraphicsImageRenderer(size: self.reportView.bounds.size)

                        let renderImage = renderer.image { _ in
                            self.reportView.drawHierarchy(in: self.reportView.bounds, afterScreenUpdates: true)
                        }
                        guard let imageData = renderImage.pngData() else { return }
                        let pasteboardItems: [String: Any] = [
                            "com.instagram.sharedSticker.stickerImage": imageData,
                            "com.instagram.sharedSticker.backgroundTopColor": "#F7550F",
                            "com.instagram.sharedSticker.backgroundBottomColor": "#D93400"
                        ]
                        let pasteboardOptions = [
                            UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
                        ]
                        UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                        UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
                    } else {
                        print("User doesn't have instagram on their device.")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        rankingButton.rx.tap
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                let rankingViewController = RankingViewController()
                self?.navigationController?.pushViewController(rankingViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func bindState(reactor: ReportReactor) {
        reactor.state
            .map { $0.reportReponse }
            .bind { [weak self] reportReponse in
                self?.nameTitleLabel.text = "\(reportReponse.data.nickname)님의\n레포트입니다."
                self?.reportView.reportReponse = reportReponse
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.likeCount }
            .bind { [weak self] likeCount in
                guard let likeCount else { return }
                self?.likeView.likeNumberLabel.text = "\(likeCount)"
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - 하트버튼 Tap
extension ReportViewController: LikeViewDelegate {
    func likeButtonTapped() {
        self.reactor.likePost()
    }
}

