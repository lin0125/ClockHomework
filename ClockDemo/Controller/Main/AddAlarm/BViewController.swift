//
//  BViewController.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/7/20.
//

import UIKit
import RealmSwift

class BViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var editors: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    var TimeStringTatal: String = ""
    var dateTimerData: Date!
    var hour12: String = ""
    var ap: String = ""
    var minuteString = ""
    var setMainTitleSelect: String = ""
    var delegate: SendMessageToDelegate?
    var date: Date!
    var selectday: [String]!
    var temp: String = ""
    var Hint: String = ""
    
    var changeEdit: Bool = true
 
    var chooseRowValue: Int!
    
    var todoToDelete: ObjectId?
    var selectedTotaltime: Date?
    var selectedAPm: String!
    var selectedHour: String!
    var selectedMinutes: String!
    var selectedTitle: String!
    var selectedSelectDay: String!
    var selectedHint: String!
    var selectedUuid: ObjectId?
    var stepuuid: ObjectId?
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        print(changeEdit)
        
 

        if changeEdit == false {

            let realm = try! Realm()
            let dogs = realm.objects(iteamTable.self)
            selectedTotaltime = dogs[chooseRowValue].Totaltime
//            print(dogs[chooseRowValue!].Totaltime)
            selectedAPm = dogs[chooseRowValue].APm
            selectedHour = dogs[chooseRowValue].hours
            selectedMinutes = dogs[chooseRowValue].minutes
            selectedTitle = dogs[chooseRowValue].Title
            selectedSelectDay = dogs[chooseRowValue].SelectDay
            selectedHint = dogs[chooseRowValue].Hint
            selectedUuid = dogs[chooseRowValue].uuid
        }
        if changeEdit == true{
             
        } else {
            datePicker.date = selectedTotaltime ?? Date()
            print(datePicker.date)
            date = datePicker.date
        }
        tableView.register(UINib(nibName: "BDuplicateTableViewCell", bundle: nil), forCellReuseIdentifier: BDuplicateTableViewCell.identifier)
        tableView.register(UINib(nibName: "mainTitleTableViewCell", bundle: nil), forCellReuseIdentifier: mainTitleTableViewCell.identifier)
        tableView.register(UINib(nibName: "BDuplicateTableViewCell", bundle: nil), forCellReuseIdentifier: BDuplicateTableViewCell.identifier)
        tableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: ReminderTableViewCell.identifier)
        
//        tableView?.delegate = self
//        tableView?.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 

        if changeEdit == false {

            let realm = try! Realm()
            let dogs = realm.objects(iteamTable.self)
            selectedTotaltime! = dogs[chooseRowValue].Totaltime ?? Date()
//            print(dogs[chooseRowValue!].Totaltime)
            selectedAPm = dogs[chooseRowValue].APm
            selectedHour = dogs[chooseRowValue].hours
            selectedMinutes = dogs[chooseRowValue].minutes
            selectedTitle = dogs[chooseRowValue].Title
            selectedSelectDay = dogs[chooseRowValue].SelectDay
            selectedHint = dogs[chooseRowValue].Hint
            selectedUuid = dogs[chooseRowValue].uuid
            
        }
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    //MARK: - UI Settings
    
    func setformat(){
        let formatter = DateFormatter()
            // 設置時間顯示的格式
            formatter.dateFormat = "HH:mm"
            //設定地區時間
            datePicker.locale = Locale(identifier: "zh_TW")
            dateTimerData = date
            let dateTimeString = formatter.string(from: date)
            selectedTotaltime = dateTimerData
            self.TimeStringTatal = dateTimeString
            let components = dateTimeString.components(separatedBy: ":")
            let minute = components[1]
            
            let calendar = Calendar.current
            let hour24 = calendar.component(.hour, from: date)
            let minute24 = calendar.component(.minute, from: date)
            
            if Int(hour24) <= 12 {
                hour12 = String(hour24)
            } else {
                hour12 = String(hour24 % 12)
            }
            selectedHour = hour12
            
            if hour24 >= 12 {
                ap = "下午"
            }else {
                ap = "上午"
            }
            selectedAPm = ap
            
            minuteString = String(minute24)
            if minute < "10" {
                minuteString = "0" + minuteString
            }
            selectedMinutes = minuteString
//            print(minute24)
//        } else {
////            let xmasDate = formatter.date(from: selectedTotaltime)
////            formatter.dateFormat(xmasDate)
//            let sdate = DateFormatter.date(from: selectedTotaltime)
//            datePicker.date = sdate
//
//        }
    }
    
    //MARK: - IBAction
    
    
    @objc func edittextField(){
        
    }
    @IBAction func datePicker(_ sender: Any) {
        
    }
    @IBAction func editors (_ sender: UIButton) {
        date = datePicker.date
        if changeEdit == true {
            setformat()
            delegate?.sendMessage(setTotalTime: dateTimerData,
                                  setAPm: ap,
                                  sethour: hour12,
                                  setminutes: minuteString,
                                  settitle: setMainTitleSelect,
                                  setSelectDay: selectday ?? [],
                                  Hint: Hint )
        } else {
            setformat()
            let realm = try! Realm()
            let dogs = realm.objects(iteamTable.self)
            
            let todosInProgress = dogs.where {
                $0.uuid == selectedUuid!
            }
            let todoToUpdate = todosInProgress
            //將資料重新寫入Ｒealm中該項當中
            try! realm.write {
//                            selectedAPm = todosInProgress[0].APm
//                            selectedHour = todosInProgress[0].hours
//                            selectedMinutes = todosInProgress[0].minutes
                todoToUpdate[0].Totaltime = dateTimerData
                todoToUpdate[0].APm = selectedAPm
                todoToUpdate[0].hours = selectedHour
                todoToUpdate[0].minutes = selectedMinutes
                todoToUpdate[0].SelectDay = selectedSelectDay
                todoToUpdate[0].Title = selectedTitle
                todoToUpdate[0].Hint = selectedHint
            }
        }
        createNotification()
        tableView.reloadData()
        delegate?.reload()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func jumpToBViewSelectDay() {
        let nextVC = BSelectDayViewController()
        nextVC.delegate = self
       self.present(nextVC, animated: true, completion: nil)
    }
    
    @objc func jumpToHint() {
        let nextVC = BSelectHintViewController()
        nextVC.delegate = self
        self.present(nextVC, animated: true, completion: nil)
    }
}

//MARK: - TableViewDelegate 、 UITableViewDataSource
extension BViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BDuplicateTableViewCell.identifier, for: indexPath) as! BDuplicateTableViewCell
            cell.duplicateTitle?.text = "重複"
            if changeEdit == true {
                if selectday == [] {
                    cell.duplicateSelect?.text = "永不"
                    
                } else if selectday == nil {
                    cell.duplicateSelect?.text = "永不"
                } else if selectday == ["星期日", "星期六"] {
                    cell.duplicateSelect?.text = "週末"
                } else if selectday == ["星期一" , "星期二" , "星期三" , "星期四" , "星期五"]{
                    cell.duplicateSelect?.text = "平日"
                } else {
                    for i in selectday {
                        temp = temp + i
                    }
                    cell.duplicateSelect?.text = temp
                }
            }
            else {
//                print(selectedSelectDay)
                if selectedSelectDay != "" && selectday == nil {
                    cell.duplicateSelect?.text = selectedSelectDay

                } else if selectday != [] && selectday != nil {
                    if selectday == ["星期日", "星期六"] {
                        cell.duplicateSelect?.text = "週末"
                        selectedSelectDay = "週末"
                    } else if selectday == ["星期一" , "星期二" , "星期三" , "星期四" , "星期五"]{
                        cell.duplicateSelect?.text = "平日"
                        selectedSelectDay = "平日"
                    } else {
                        for i in selectday {
                            temp = temp + i
                        }
                        cell.duplicateSelect.text = temp
                        selectedSelectDay = temp
                    }
                } else if selectedSelectDay == "" || selectday == [] {
                    cell.duplicateSelect.text = "永不"
                }
//                print("測試\( selectedSelectDay)")
            }
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: mainTitleTableViewCell.identifier, for: indexPath) as! mainTitleTableViewCell
            
            cell.mainTitle?.text = "標籤"
            if changeEdit == true {
                if cell.mainTitleSelect.text == "" {
                    setMainTitleSelect = "鬧鐘"
                } else {
                    setMainTitleSelect = (cell.mainTitleSelect?.text)!
//                    print((cell.mainTitleSelect?.text)!)
                }
            } else {
//                print("測試\(setMainTitleSelect)")
                if setMainTitleSelect == "" {
                    cell.mainTitleSelect?.text = selectedTitle
                } else if setMainTitleSelect != "" {
                    setMainTitleSelect = (cell.mainTitleSelect?.text)!
                    selectedTitle = setMainTitleSelect
                }
            }
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BDuplicateTableViewCell.identifier, for: indexPath) as! BDuplicateTableViewCell
            cell.duplicateTitle?.text = "提示聲"
            if changeEdit == true {
                if Hint == "" {
                    cell.duplicateSelect?.text = "雷達"
                } else {
                    cell.duplicateSelect?.text = "\(Hint)"
                }
            } else {
//                print("測試\(Hint)")
                if selectedHint != "" && Hint == "" {
                    cell.duplicateSelect.text = selectedHint
                } else if Hint != "" {
                    cell.duplicateSelect.text = "\(Hint)"
                    selectedHint = Hint
                } else if selectedHint == "" && Hint == "" {
                    cell.duplicateSelect?.text = "雷達"
                }
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReminderTableViewCell.identifier, for: indexPath) as! ReminderTableViewCell
            cell.RemindeTitle?.text = "稍後提醒"
            
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            jumpToBViewSelectDay()
        }
        if indexPath.row == 2 {
            jumpToHint()
        }
    }
}

extension BViewController: sendSelectDay {
    func sendSelect(day: [String]) {
        self.selectday = day
        tableView.reloadData()
    }
}

extension BViewController: sendSelectHint {
    func sendHint (Hint: String){
        self.Hint = Hint
        tableView.reloadData()
    }
}
//MARK: - Protocol

protocol SendMessageToDelegate {
    func sendMessage(setTotalTime: Date,setAPm: String, sethour: String, setminutes: String, settitle: String, setSelectDay: [String], Hint: String)
    func reload()
}
//protocol exchangeBoolToEdit{
//    func exBoolToEdit()
//}
