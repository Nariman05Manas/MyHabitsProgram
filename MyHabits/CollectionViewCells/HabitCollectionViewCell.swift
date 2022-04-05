//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by qwerty on 29.03.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HabitCollectionViewCell"
    
    var habit: Habit?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dataText: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.numberOfLines = 1
        return label
    }()
    
    lazy var counterText: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray2
        label.numberOfLines = 1
        return label
    }()
    
    lazy var checker: UIButton = {
        let checkButton = UIButton()
        checkButton.toAutoLayout()
        checkButton.layer.cornerRadius = ConstSize.bigCornerRadius
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.addTarget(self, action: #selector(tapToChecker), for: .touchUpInside)
        return checkButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = ConstSize.smallCornerRadius
        contentView.addSubviews(nameLabel, dataText, counterText, checker)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(habit: Habit) {
        self.habit = habit
        nameLabel.text = habit.name
        nameLabel.textColor = habit.color
        dataText.text = habit.dateString
        counterText.text = "Счётчик: " + String(habit.trackDates.count)
        if habit.isAlreadyTakenToday {
            checker.backgroundColor = habit.color
            checker.layer.borderWidth = 1
            checker.layer.borderColor = habit.color.cgColor
            checker.setTitle("✔︎", for: .normal)
            checker.isUserInteractionEnabled = false
        } else {
            checker.backgroundColor = .white
            checker.layer.borderWidth = 1
            checker.layer.borderColor = habit.color.cgColor
            checker.backgroundColor = .white
            checker.setTitle("", for: .normal)
            checker.isUserInteractionEnabled = true
        }
        useConstraint()
    }
    
    func useConstraint() {
        [nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstSize.titleIndent),
         nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstSize.leadingMargin),
         
         dataText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: ConstSize.smallIndent),
         dataText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstSize.leadingMargin),
         
         checker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
         checker.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: ConstSize.overBigLeadingMargin),
         checker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstSize.bigTrailingMargin),
         checker.widthAnchor.constraint(equalToConstant: ConstSize.bigCircleSize),
         checker.heightAnchor.constraint(equalToConstant: ConstSize.bigCircleSize),
         
         counterText.topAnchor.constraint(equalTo: checker.bottomAnchor, constant: ConstSize.indent),
         counterText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstSize.leadingMargin),
         counterText.trailingAnchor.constraint(equalTo: checker.leadingAnchor, constant: ConstSize.overBigTrailingMargin)
        ].forEach({$0.isActive = true})
    }
    
    @objc func tapToChecker() {
        
        if let trackHabit = habit {
            HabitsStore.shared.track(trackHabit)
            HabitsViewController.collectionView.reloadData()
        }
    }
}
