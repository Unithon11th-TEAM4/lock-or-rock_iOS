//
//  RankingViewController.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/6/24.
//

import UIKit

class RankingViewController: UIViewController {
    
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
    
    private let rankingTableView = UITableView().then {
        $0.isScrollEnabled = false
    }
    
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
        view.backgroundColor = UIColor(named: "black")
        setTableView()
        addSubViews()
        setLayout()
        registerCell()
    }
    
    private func setTableView() {
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
    }
    
    private func addSubViews() {
        [titleView, background1, mainImage, background2, rankingTableView, homeButton].forEach { view.addSubview($0) }
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
            $0.height.equalTo(282)
            $0.centerX.equalToSuperview()
        }
        
        homeButton.snp.makeConstraints {
            $0.top.equalTo(rankingTableView.snp.bottom).offset(80)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as! RankingTableViewCell
        
        cell.selectionStyle = .none
//        cell.configureCell(rank: rankList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}
