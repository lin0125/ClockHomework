//
//  MainViewController.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/7/20.
//

import UIKit
import RealmSwift


class MainViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet weak var TimeItemTableView: UITableView!
    
    //MARK: - Variables
    var rightBarButton: UIBarButtonItem!
    var leftBarButton: UIBarButtonItem!
    var timeFormatTimeTatol: Date?
    var timeFormatAPM: String = ""
    var timeFormatHours: String = ""
    var timeFormatMinutes: String = ""
    var timeFormatTitle: String = ""
    var timeFormaSeledtDay: [String]!
    var tempSelectDay: String = ""
    var iteamTabel: [IteamTable] = []
    var switches = [UISwitch]()
    var switchselect = true
    var jumpStop = false
    var clickOn: Int?
    var convertingEditBool: Bool = true

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotification()
        setUI()
        TimeItemTableView.allowsSelectionDuringEditing = true
        TimeItemTableView?.delegate = self
        TimeItemTableView?.dataSource = self
        TimeItemTableView?.register(UINib(nibName: "AddTimeIteamTableViewCell", bundle: nil), forCellReuseIdentifier: AddTimeIteamTableViewCell.identifier)
        TimeItemTableView?.register(UINib(nibName: "SleepTableViewCell", bundle: nil), forCellReuseIdentifier: SleepTableViewCell.identifier)
        TimeItemTableView?.register(UINib(nibName: "SleepSetTableViewCell", bundle: nil), forCellReuseIdentifier: SleepSetTableViewCell.identifier)
        TimeItemTableView?.register(UINib(nibName: "SleepOptionTableViewCell", bundle: nil), forCellReuseIdentifier: SleepOptionTableViewCell.identifier)

        


        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    //MARK: - UI Settings
    
    func setUI(){
        setupNavigation()
    }
    
    func setupNavigation() {
        self.title = "鬧鐘"
        rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(jumpTOBviewcontroller))
        leftBarButton = UIBarButtonItem(title: "編輯", style: .plain, target: self, action: #selector(handleButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func fetchData() {
        iteamTabel = []
        let realm = try! Realm()
        let timeDatabase = realm.objects(iteamTable.self)
        if timeDatabase.count > 0 {
            for i in 0...timeDatabase.count - 1 {
                let item = IteamTable(Totaltime: timeDatabase[i].Totaltime,
                                      APm: timeDatabase[i].APm,
                                      hours: timeDatabase[i].hours,
                                      minutes: timeDatabase[i].minutes,
                                      Title: timeDatabase[i].Title,
                                      SelectDay: timeDatabase[i].SelectDay,
                                      uuid: timeDatabase[i].uuid)
                iteamTabel.append(item)
            }
        }
        print("file\(realm.configuration.fileURL!)")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // 取消第 2 個 row 的編輯模式
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
                return false
            } else {
                return true
            }
        }
    //MARK: - IBAction
    @objc func jumpTOBviewcontroller(){
        let nextVC = BViewController()
        nextVC.delegate = self
        TimeItemTableView.isEditing = false
        leftBarButton.title = "編輯"
        self.present(nextVC, animated: true, completion: nil)
        TimeItemTableView.reloadData()
    }
    
    @objc func handleButtonTapped() {
//        TimeItemTableView.isEditing = true
        TimeItemTableView.isEditing = !TimeItemTableView.isEditing
        if TimeItemTableView.isEditing == true {
            leftBarButton.title = "完成"

        }
        else {
            leftBarButton.title = "編輯"
        }
        TimeItemTableView.reloadData()


    }
    
}

//MARK: - Extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ TimeItemTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iteamTabel.count + 3
    }
    func tableView(_ TimeItemTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            TimeItemTableView.rowHeight = 45
            let cell = TimeItemTableView.dequeueReusableCell(withIdentifier: SleepTableViewCell.identifier, for: indexPath) as! SleepTableViewCell
            cell.SleepTitle.text = "🛏️睡眠｜起床鬧鐘"
            return cell
            
        } else if indexPath.row == 1 {
            TimeItemTableView.rowHeight = 60
            let cell = TimeItemTableView.dequeueReusableCell(withIdentifier: SleepSetTableViewCell.identifier, for: indexPath) as! SleepSetTableViewCell
            return cell
            
        } else if indexPath.row == 2 {
            TimeItemTableView.rowHeight = 60
            let cell = TimeItemTableView.dequeueReusableCell(withIdentifier: SleepOptionTableViewCell.identifier, for: indexPath) as! SleepOptionTableViewCell
            return cell
            
        } else {
            TimeItemTableView.rowHeight = 109
            let cell = TimeItemTableView.dequeueReusableCell(withIdentifier: AddTimeIteamTableViewCell.identifier, for: indexPath) as! AddTimeIteamTableViewCell
            
            cell.APMTimeLabel?.text = iteamTabel[indexPath.row - 3].APm
            cell.SetTimeLabel?.text = "\(iteamTabel[indexPath.row - 3].hours):\(iteamTabel[indexPath.row - 3].minutes)"
            cell.SetTitleLabel?.text = iteamTabel[indexPath.row - 3].Title
            cell.setSelectDay?.text = iteamTabel[indexPath.row - 3].SelectDay
            
//            if TimeItemTableView.isEditing == true   {
//                cell.switchView.isHidden = true
//                cell.editingAccessoryType = .disclosureIndicator
//            } else {
//                cell.editingAccessoryType = .none
//                cell.switchView.isHidden = false
//                
//            }
            return cell
            
        }
    }
    
    
    //左滑刪除
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, sourceView, complete) in
            let realm = try! Realm()
            let timeDatabase = realm.objects(iteamTable.self)
            
            let todoToDelete = timeDatabase[indexPath.row].uuid
            try! realm.write {
                let todosInProgress = timeDatabase.where {
                    $0.uuid == todoToDelete
                }
                deleteNotification(UuidIdentifier: todoToDelete)
                realm.delete(todosInProgress)
            }
            self.iteamTabel.remove(at: indexPath.row)
            self.TimeItemTableView.deleteRows(at: [indexPath], with: .top)
            self.TimeItemTableView.reloadData()
            complete(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        let trailingSwipConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return trailingSwipConfiguration
        
    }
    //點擊tableview.row跳回編輯
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            TimeItemTableView.deselectRow(at: indexPath, animated: true)
        } else {
            let nextVC = BViewController()
            nextVC.changeEdit = false
            nextVC.chooseRowValue = indexPath.row - 3
            nextVC.delegate = self
            TimeItemTableView.isEditing = false
            present(nextVC, animated: true)
            leftBarButton.title = "編輯"
            TimeItemTableView.reloadData()
        }
    }
}


extension MainViewController: SendMessageToDelegate {
    func sendMessage(setTotalTime: Date,setAPm: String, sethour: String, setminutes: String, settitle: String, setSelectDay: [String], Hint: String) {
        print(sethour,setminutes, setAPm)
        
        self.timeFormatTimeTatol = setTotalTime
        self.timeFormatAPM = setAPm
        self.timeFormatHours = sethour
        self.timeFormatMinutes = setminutes
        self.timeFormatTitle = settitle
        self.timeFormaSeledtDay = setSelectDay
        print(setSelectDay)
        if timeFormaSeledtDay == [] {
            tempSelectDay = ""
        } else if timeFormaSeledtDay == nil {
            tempSelectDay = ""
        } else if timeFormaSeledtDay == ["星期日", "星期六"] {
            tempSelectDay = "週末"
        } else if timeFormaSeledtDay == ["星期一" , "星期二" , "星期三" , "星期四" , "星期五"]{
            tempSelectDay = "平日"
        } else {
            tempSelectDay = ""
            for i in timeFormaSeledtDay {
                tempSelectDay = tempSelectDay + i
            }
        }
        
        let realm = try! Realm()                      //將資料寫入Realm
        let pp = iteamTable(Totaltime: setTotalTime,
                            APm: setAPm,
                            hours: sethour,
                            minutes: setminutes,
                            Title: settitle,
                            SelectDay: tempSelectDay,
                            Hint: Hint
        )
        try! realm.write {
            realm.add(pp)
        }
        fetchData()
        createNotification()
        TimeItemTableView.reloadData()
    }
    
    func reload() {
        fetchData()
        TimeItemTableView.reloadData()
    }
    
}
