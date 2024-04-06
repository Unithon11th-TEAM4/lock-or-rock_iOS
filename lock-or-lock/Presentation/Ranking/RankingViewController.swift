//
//  RankingViewController.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/6/24.
//

import UIKit
import SnapKit
import Moya

class RankingViewController: UIViewController {
    
    let provider = MoyaProvider<RankingService>(plugins: [NetworkLogger()])
    var responseData: [Leaderboard] = []
    
    private let titleView = UIView().then {
        $0.backgroundColor = UIColor(named: "primary")
        $0.layer.cornerRadius = 12
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "락올락 나락왕들"
        $0.font = .waguri(size: 24)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let background1 = UIImageView().then {
        $0.image = UIImage(named: "background1")
        $0.contentMode = .scaleToFill
    }
    
    private let mainImage = UIImageView().then {
        $0.image = UIImage(named: "mainDevil")
        $0.contentMode = .scaleToFill
    }
    
    private let background2 = UIImageView().then {
        $0.image = UIImage(named: "background2")
        $0.contentMode = .scaleToFill
    }
    
    private var tableHeaderView = UIView(frame: CGRect(x: 15, y: 293, width: 345, height: 50)).then {
        $0.backgroundColor = UIColor(named: "primary")
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.white.cgColor
        $0.clipsToBounds = true
    }
    
    private let myRankNumber = UILabel().then {
        $0.text = "5"
        $0.font = .waguri(size: 20)
        $0.textColor = .white
    }
    
    private let myName = UILabel().then {
        $0.text = "평화호소인"
        $0.font = .oAGothicMedium(size: 18)
        $0.textColor = .white
    }
    
    private let myHeartImage = UIImageView().then {
        $0.image = UIImage(named: "myHeart")
        $0.contentMode = .scaleToFill
    }
    
    private let myHeartNumber = UILabel().then {
        $0.text = "1"
        $0.font = .waguri(size: 18)
        $0.textColor = .white
    }
    
    private let rankingTableView = UITableView()
    
    private let homeButton = UIButton().then {
        $0.setTitle("홈으로 가기", for: .normal)
        $0.titleLabel?.font = .waguri(size: 18)
        $0.backgroundColor = UIColor(named: "primary")
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 6
        $0.contentHorizontalAlignment = .center
        $0.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        addSubViews()
        setLayout()
        registerCell()
        getRanking()
    }
    
    // MARK: API
    private func getRanking() {
        let memberId = TokenManager.shared.getIntUserId()
        
        provider.request(.getRanking(memberId: memberId)) { [weak self] (result) in
            switch result {
            case let .success(response):
                guard let result = try? response.map(RankingResponse.self) else { return }
                self?.setData(rankingResponse: result.data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setData(rankingResponse: RankingDto) {
        // 나의 랭킹 정보
        myRankNumber.text = String(rankingResponse.leaderboards[0].rankNo)
        myName.text = rankingResponse.leaderboards[0].nickname
        myHeartNumber.text = String(rankingResponse.leaderboards[0].likeCount)
        
        // 전체 랭킹 정보
        for leaderboard in rankingResponse.leaderboards {
            if leaderboard.rankNo != 0 {
                responseData.append(leaderboard)
            }
        }
    }
    
    private func attribute() {
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.tableHeaderView = tableHeaderView
    }
    
    private func addSubViews() {
        [titleView, background1, mainImage, background2, rankingTableView, homeButton].forEach { view.addSubview($0) }
        [myRankNumber, myName, myHeartImage, myHeartNumber].forEach {         tableHeaderView.addSubview($0) }
        titleView.addSubview(titleLabel)
    }
    
    private func setLayout() {
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(73)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(63)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(titleView.snp.centerX)
            $0.top.equalTo(titleView.snp.top).offset(19)
            $0.leading.equalTo(titleView.snp.leading).offset(30)
        }
        
        background1.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(55)
            $0.top.equalTo(titleView.snp.bottom).offset(30)
            $0.width.equalTo(74.41)
        }
        
        mainImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(107)
            $0.top.equalTo(titleView.snp.bottom).offset(40)
        }
        
        background2.snp.makeConstraints {
            $0.leading.equalTo(mainImage.snp.trailing).offset(20)
            $0.top.equalTo(titleView.snp.bottom).offset(40)
            $0.width.equalTo(59.43)
        }
        
        rankingTableView.snp.makeConstraints {
            $0.top.equalTo(mainImage.snp.bottom).offset(30)
            $0.leading.equalTo(view.snp.leading).offset(10)
            $0.height.equalTo(340)
            $0.centerX.equalToSuperview()
        }
        
        myRankNumber.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        myName.snp.makeConstraints {
            $0.leading.equalTo(myRankNumber.snp.trailing).offset(41)
            $0.centerY.equalToSuperview()
        }
        
        myHeartImage.snp.makeConstraints {
            $0.trailing.equalTo(myHeartNumber.snp.leading).offset(-5)
            $0.centerY.equalToSuperview()
        }
        
        myHeartNumber.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        homeButton.snp.makeConstraints {
            $0.top.equalTo(rankingTableView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(15)
            $0.height.equalTo(64)
        }
    }
    
    private func registerCell() {
        self.rankingTableView.register(RankingTableViewCell.self, forCellReuseIdentifier: RankingTableViewCell.identifier)
    }
    
    @objc private func homeButtonTapped() {
        let homeVC = HomeViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as! RankingTableViewCell
        
        cell.selectionStyle = .none
        cell.configureCell(at: indexPath)
        
        // 응답 데이터
//        let data = responseData[indexPath.row]
//        cell.userName.text = data.nickname
//        cell.heartNumber.text = String(data.likeCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
