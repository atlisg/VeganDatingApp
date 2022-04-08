//
//  UserTableViewCell.swift
//  VeganDatingApp
//
//  Created by Atli Saevar on 7.4.2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let identifier = "UserTableViewCell"

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let nameLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private let ageLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabelView)
        contentView.addSubview(ageLabelView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
