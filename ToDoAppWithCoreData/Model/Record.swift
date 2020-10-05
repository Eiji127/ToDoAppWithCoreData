//
//  Record.swift
//  ToDoAppWithCoreData
//
//  Created by 白数叡司 on 2020/10/03.
//  Copyright © 2020 AEG. All rights reserved.
//

import Foundation

class Record {
    
    var title = String()
    var detail = String()
    var beginDate = Date()
    var beginTime = Date()
    var endDate = Date()
    var endTime = Date()
    
    
    init(title: String, detail: String, beginDate: Date, beginTime: Date, endDate: Date, endTime: Date) {
        
        self.title = title
        self.detail = detail
        self.beginDate = beginDate
        self.beginTime = beginTime
        self.endDate = endDate
        self.endTime = endTime
        
    }
    
}
