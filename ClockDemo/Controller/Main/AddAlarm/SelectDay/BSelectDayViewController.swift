//
//  BSelectDayViewController.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/8/1.
//

import UIKit

class BSelectDayViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var returnButton: UIButton!
    var day = ["星期日" , "星期一" , "星期二" , "星期三" , "星期四" , "星期五" , "星期六"]
    var slectDay:[String] = []
    var delegate: sendSelectDay?
    var selectRow = [false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BSelectDayTableViewCell", bundle: nil), forCellReuseIdentifier: BSelectDayTableViewCell.identifier)

        
        
            
        

        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        for x in 0...selectRow.count - 1{
            if  selectRow[x] == true {
                slectDay.append(day[x])
            }
        }
        print(slectDay)
        delegate!.sendSelect(day: slectDay)
        slectDay = []
        self.dismiss(animated: true, completion: nil)
    }
    
        
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BSelectDayViewController: UITableViewDelegate, UITableViewDataSource{
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BSelectDayTableViewCell.identifier, for: indexPath) as! BSelectDayTableViewCell
        cell.showDay.text = day[indexPath.row]
        
        if selectRow[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow[indexPath.row] = !selectRow[indexPath.row]
        
        tableView.reloadData()
    }
}

protocol sendSelectDay {
    func sendSelect(day: [String] )
}
