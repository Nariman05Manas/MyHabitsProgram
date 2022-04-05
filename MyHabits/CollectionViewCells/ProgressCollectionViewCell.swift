//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by qwerty on 29.03.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProgressCollectionViewCell"
    
    lazy var motivationLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Все получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.backgroundColor = .white
        label.textColor = .systemGray2
        label.numberOfLines = 1
        return label
    }()
    
    lazy var procentLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.backgroundColor = .white
        label.textColor = .systemGray2
        label.numberOfLines = 1
        return label
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar )
        progressBar.toAutoLayout()
        progressBar.trackTintColor = .systemGray2
        progressBar.progressTintColor = ConstSize.purpurColor
        progressBar.backgroundColor = .white
        progressBar.layer.cornerRadius = 8
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = ConstSize.smallIndent/3
        progressBar.subviews[1].clipsToBounds = true
        return progressBar
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = ConstSize.smallCornerRadius
        contentView.addSubviews(motivationLabel, procentLabel, progressBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        progressBar.progress = HabitsStore.shared.todayProgress
        procentLabel.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
        useConstraint()
    }
    
    func useConstraint() {
        [motivationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstSize.indent),
         motivationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstSize.leadingMargin),
         procentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstSize.indent),
         procentLabel.leadingAnchor.constraint(equalTo: motivationLabel.trailingAnchor, constant: ConstSize.leadingMargin),
         procentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstSize.trailingMargin),
         progressBar.topAnchor.constraint(equalTo: motivationLabel.bottomAnchor, constant: ConstSize.smallIndent),
         progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstSize.leadingMargin),
         progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstSize.trailingMargin),
         progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ConstSize.indent),
         progressBar.heightAnchor.constraint(equalToConstant: ConstSize.smallIndent * 0.5)
        ].forEach({$0.isActive = true})
    }
}
