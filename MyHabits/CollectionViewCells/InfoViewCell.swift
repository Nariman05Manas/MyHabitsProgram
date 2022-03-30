//
//  InfoViewCell.swift
//  MyHabits
//
//  Created by qwerty on 29.03.2022.
//

import UIKit

class InfoViewCell: UITableViewCell {

    static let identifire = "InfoViewCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(label)
        useConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstSize.indent),
                                     label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstSize.leadingMargin),
                                     label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ConstSize.indent),
                                     label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstSize.trailingMargin)
                                    ])
    }
    
    func setup(text: String) {
        label.text = text
    }

}
