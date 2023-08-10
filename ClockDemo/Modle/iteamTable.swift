//
//  iteamTable.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/7/26.
//


import RealmSwift
import Foundation
class iteamTable: Object {
    @Persisted(primaryKey: true) var uuid: ObjectId
    @Persisted var Totaltime: Date!
    @Persisted var APm: String = ""
    @Persisted var hours: String = ""
    @Persisted var minutes: String = ""
    @Persisted var Title: String = ""
    @Persisted var SelectDay: String = ""
    @Persisted var Hint: String = ""
    




    convenience init(Totaltime: Date,APm: String ,hours: String, minutes: String, Title: String, SelectDay: String, Hint: String) {
        self.init()
        self.Totaltime = Totaltime
        self.APm = APm
        self.hours = hours
        self.minutes = minutes
        self.Title = Title
        self.SelectDay = SelectDay
        self.Hint = Hint

        
   }
}

struct IteamTable{
    var Totaltime: Date
    
    var APm: String
    
    var hours: String
    
    var minutes: String
    
    var Title: String
    
    var SelectDay: String
        
    var uuid: ObjectId
    
    
}
