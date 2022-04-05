//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by qwerty on 29.03.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    static let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped )
         table.toAutoLayout()
         table.refreshControl = UIRefreshControl()
         table.isScrollEnabled = true
         table.separatorInset = .zero
         table.rowHeight = UITableView.automaticDimension
         table.refreshControl?.addTarget(HabitDetailsViewController.self, action: #selector(updateTable), for: .valueChanged)
         return table
     }()
     
     static var isDeleted = false
     
     let habit: Habit
     
     init(_ habit: Habit) {
         HabitDetailsViewController.isDeleted = false
         self.habit = habit
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         let rightBarButtonItem = UIBarButtonItem(title: "Править",
                                             style: .plain ,
                                             target: self,
                                             action: #selector(editHabit))
         rightBarButtonItem.tintColor = ConstSize.purpurColor
         navigationItem.rightBarButtonItem = rightBarButtonItem
         
         let leftBarButtonItem = UIBarButtonItem(title: "❮ Сегодня",
                                             style: .plain ,
                                             target: self,
                                             action: #selector(tapToCancel))
         leftBarButtonItem.tintColor = ConstSize.purpurColor
         navigationItem.leftBarButtonItem = leftBarButtonItem
         
         view.backgroundColor = ConstSize.foneColor
         
         HabitDetailsViewController.tableView.dataSource = self
         HabitDetailsViewController.tableView.delegate = self
         
         HabitDetailsViewController.tableView.register(HabitDetailTableViewHeader.self,
                                                       forHeaderFooterViewReuseIdentifier: HabitDetailTableViewHeader.identifier)
         HabitDetailsViewController.tableView.register(HabitDetailTableViewCell.self,
                                                       forCellReuseIdentifier: HabitDetailTableViewCell.identifier)
         
         view.addSubview(HabitDetailsViewController.tableView)
         
         NSLayoutConstraint.activate([
             HabitDetailsViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             HabitDetailsViewController.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
             HabitDetailsViewController.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             HabitDetailsViewController.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
         ])
         
     }
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         if HabitDetailsViewController.isDeleted {
             HabitDetailsViewController.isDeleted = false
             navigationController?.popViewController(animated: true)
         } else {
             title = habit.name
         }
     }
     
     @objc func tapToCancel() {
         navigationController?.popViewController(animated: true)
     }
     
     @objc func editHabit() {
         navigationController?.present(HabitViewController(habit), animated: true, completion: nil)
     }
     
     @objc func updateTable() {
         HabitDetailsViewController.tableView.reloadData()
         HabitDetailsViewController.tableView.refreshControl?.endRefreshing()
     }
 }

 extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitDetailTableViewCell.identifier, for: indexPath) as? HabitDetailTableViewCell else { return UITableViewCell() }
         let date = HabitsStore.shared.dates[indexPath.row]
         cell.setup(date: date, check: HabitsStore.shared.habit(habit, isTrackedIn: date))
         
         return cell
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         HabitsStore.shared.dates.count
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HabitDetailTableViewHeader.identifier) as? HabitDetailTableViewHeader else { return nil }
         return headerView
     }
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 44
         
     }

}
