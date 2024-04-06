//
//  OptionTableViewCell.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/7/24.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    
    static let identifier = "OptionTableViewCell"
    
    private let optionNumber = UILabel().then {
        $0.text = "1"
        $0.font = .waguri(size: 20)
        $0.textColor = .white
    }
    
    let optionTextField = UITextField().then {
        $0.placeholder = "보기를 입력해주세요."
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.clipsToBounds = true
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: "black")
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
        [optionNumber, optionTextField].forEach { contentView.addSubview($0) }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    private func setLayout() {
        optionNumber.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview()
            $0.width.equalTo(12)
        }
        
        optionTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(optionNumber.snp.trailing).offset(10)
        }
    }
    
    func configureCell(at indexPath: IndexPath) {
        var number = String(indexPath.row + 1)
        optionNumber.text = number
    }
}
