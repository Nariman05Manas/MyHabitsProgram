//
//  HabitCollectionViewHeader.swift
//  MyHabits
//
//  Created by qwerty on 29.03.2022.
//

import UIKit

class HabitCollectionViewHeader: UICollectionReusableView {
    
    static let identifire = "HabitCollectionViewHeader"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.text = "Сегодня"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(label)
        useConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: topAnchor, constant: ConstSize.indent),
                                     label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ConstSize.leadingMargin),
                                     label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ConstSize.downIndent)])
    }
        
}
