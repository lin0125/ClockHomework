//
//  BSelectHintViewController.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/8/3.
//

import UIKit

class BSelectHintViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var hintTitle = ["雷達（預設值）", "上升", "山坡", "公告", "水晶", "宇宙", "波浪", "信號", "急板", "指標", "星座", "倒影","海邊","閃爍"]
    var selectRow: Int = 0
    var returnHint: String = ""
    var delegate: sendSelectHint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "BSelectHintTableViewCell", bundle: nil), forCellReuseIdentifier: BSelectHintTableViewCell.identifier)

        
        delegate!.sendHint(Hint: "")
        // Do any additional setup after loading the view.
    }
    @IBAction func HintReturnButton(_ sender: Any) {
        if selectRow == 0 {
            returnHint = "雷達"
        } else {
            returnHint = hintTitle[selectRow]
        }
        delegate!.sendHint(Hint: returnHint)
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

extension BSelectHintViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hintTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BSelectHintTableViewCell.identifier, for: indexPath) as! BSelectHintTableViewCell
        cell.HintTitle.text = hintTitle[indexPath.row]
        if selectRow == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow = indexPath.row
        
        tableView.reloadData()
    }
}


    protocol sendSelectHint{
        func sendHint(Hint: String)
    }
