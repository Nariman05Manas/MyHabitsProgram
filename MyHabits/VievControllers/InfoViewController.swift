//
//  InfoViewController.swift
//  MyHabits
//
//  Created by qwerty on 27.03.2022.
//

import UIKit


class InfoViewController: UIViewController {
            
        let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.toAutoLayout()
            scrollView.backgroundColor = .white
            scrollView.isScrollEnabled = true
            scrollView.indicatorStyle = .black
            return scrollView
        }()
        
        let titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.toAutoLayout()
            titleLabel.text = "Привычка за 21 день"
            titleLabel.contentMode = .scaleAspectFit
            titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
            return titleLabel
        }()
        
        let textView: UITextView = {
            let textView = UITextView()
            textView.toAutoLayout()
            textView.isScrollEnabled = false
            textView.text = textInfo
            textView.font = .systemFont(ofSize: 17)
            return textView
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.addSubview(scrollView)
            scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
            scrollView.addSubviews(titleLabel, textView)
            
            initialLayout()
            
        }
        
        //MARK: Initial Layout
        func initialLayout() {
            NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                         scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                         scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                         scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                         
                                         titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
                                         titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                                         titleLabel.widthAnchor.constraint(equalToConstant: 218),
                                         titleLabel.heightAnchor.constraint(equalToConstant: 24),
                                         
                                         textView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 62),
                                         textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                                         textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
                                        ])
        }
        
 

}
