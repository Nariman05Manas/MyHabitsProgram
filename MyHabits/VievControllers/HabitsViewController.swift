//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by qwerty on 27.03.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    static let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ConstSize.titleIndent
        layout.sectionInsetReference = .fromContentInset
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: ConstSize.height)
        layout.sectionInset = UIEdgeInsets(top: ConstSize.indent, left: ConstSize.leadingMargin, bottom: ConstSize.indent, right: ConstSize.leadingMargin)
        return layout
    }()
    
    static let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HabitsViewController.layout)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = ConstSize.foneColor
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus",
                                                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 17))?.withTintColor(ConstSize.purpurColor, renderingMode: .alwaysOriginal),
                                            style: .plain ,
                                            target: self,
                                            action: #selector(addNewHabit))
        navigationItem.rightBarButtonItem = barButtonItem
        
        view.backgroundColor = ConstSize.foneColor
        HabitsViewController.collectionView.dataSource = self
        HabitsViewController.collectionView.delegate = self
        
        view.addSubviews(HabitsViewController.collectionView)
        
        HabitsViewController.collectionView.register(ProgressCollectionViewCell.self,
                                                     forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        HabitsViewController.collectionView.register(HabitCollectionViewCell.self,
                                                     forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        HabitsViewController.collectionView.register(HabitCollectionViewHeader.self,
                                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                     withReuseIdentifier: HabitCollectionViewHeader.identifier)
        useConstraint()
       
    }
    
    func useConstraint() {
        [HabitsViewController.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         HabitsViewController.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         HabitsViewController.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         HabitsViewController.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach({$0.isActive = true})
    }
    

    @objc func addNewHabit() {
     navigationController?.present(HabitViewController(nil), animated: true, completion: nil)
    }
    
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier,
                                                                for: indexPath) as? ProgressCollectionViewCell else { return UICollectionViewCell() }
            cell.setup()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier,
                                                                for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(habit: HabitsStore.shared.habits[indexPath.item - 1])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: HabitCollectionViewHeader.identifier,
                                                                         for: indexPath) as? HabitCollectionViewHeader else { return UICollectionReusableView() }
        return cell
                
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width - (ConstSize.leadingMargin * 2), height: ConstSize.height)
        } else {
            return CGSize(width: collectionView.frame.width - (ConstSize.leadingMargin * 2), height: ConstSize.bigHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(indexPath.item == 0) {
            guard let item = collectionView.cellForItem(at: indexPath) as? HabitCollectionViewCell else { return }
            
            if let habit = item.habit {
                navigationController?.pushViewController(HabitDetailsViewController(habit), animated: true)
            }
        }
    }

}
