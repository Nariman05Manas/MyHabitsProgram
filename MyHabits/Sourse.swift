//
//  Sourse.swift
//  MyHabits
//
//  Created by qwerty on 27.03.2022.
//

import UIKit

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

struct ConstSize {
    static var cornerRadius: CGFloat = 16
    static var smallCornerRadius: CGFloat = 8
    static var bigCornerRadius: CGFloat = 19
    
    static var titleIndent: CGFloat = 21
    static var indent: CGFloat = 16
    static var downIndent: CGFloat = -16
    static var smallIndent: CGFloat = 8
    
    static var height: CGFloat = 60
    static var bigHeight: CGFloat = 130
    
    static var leadingMargin: CGFloat = 16
    static var bigLeadingMargin: CGFloat = 25
    static var overBigLeadingMargin: CGFloat = 40
    
    static var trailingMargin: CGFloat = -16
    static var bigTrailingMargin: CGFloat = -25
    static var overBigTrailingMargin: CGFloat = -40
    
    static var circleSize: CGFloat = 30
    static var bigCircleSize: CGFloat = 38
    
    static var purpurColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
    static var foneColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    static var standartColor = UIColor(red: 41/255, green: 109/255, blue: 255/255, alpha: 1)
}
