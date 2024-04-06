//
//  RankingTableViewCell.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/6/24.
//

import UIKit

class RankingTableViewCell: UITableViewCell {
    
    static let identifier = "RankingTableViewCell"
    
    private let containerView1 = UIView().then {
        $0.backgroundColor = UIColor(named: "lightGray")
        $0.layer.cornerRadius = 6
    }
    
    private let rankNumber = UILabel().then {
        $0.text = "1"
        $0.font = .waguri(size: 20)
    }
    
    private let containerView2 = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 6
    }
    
    private let userName = UILabel().then {
        $0.text = "행복한다람쥐"
        $0.font = .oAGothicMedium(size: 18)
    }
    
    private let heartImage = UIImageView().then {
        $0.image = UIImage(named: "heart")
        $0.contentMode = .scaleToFill
    }
    
    private let heartNumber = UILabel().then {
        $0.text = "111"
        $0.textColor = UIColor(named: "pink")
        $0.font = .pretendardMedium(size: 18)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .black
        addSubViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func addSubViews() {
        [containerView1, containerView2].forEach { contentView.addSubview($0) }
        containerView1.addSubview(rankNumber)
        [userName, heartImage, heartNumber].forEach { containerView2.addSubview($0)}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0))
    }
    
    private func setLayout() {
        containerView1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        
        rankNumber.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(18)
            $0.width.equalTo(14)
        }
        
        containerView2.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(containerView1.snp.trailing).offset(10)
            $0.height.equalTo(50)
        }
        
        userName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        heartImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(heartNumber.snp.leading).offset(-5)
        }
        
        heartNumber.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
