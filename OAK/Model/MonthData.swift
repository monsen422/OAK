//
//  MonthData.swift
//  OAK
//
//  Created by MobileDev on 9/23/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//
class MonthData{
    var label: String
    var value: String
    var color: String
    var elective_patient: String
    var general: String
    var emergency: String
    var day_surgery: String
    var total_elective_emergency: String
    var order:Int
    var realValue: String
    var originalValue:String
    var originalColor: String
    
    init(order:Int, label: String, value: String, color:String, elective_patient:String, general:String, emergency:String, day_surgery:String, total_elective_emergency:String, real_value:String){
        self.order = order
        self.label = label
        self.value = value
        self.color = color
        self.elective_patient = elective_patient
        self.general = general
        self.emergency = emergency
        self.day_surgery = day_surgery
        self.total_elective_emergency = total_elective_emergency
        self.realValue = real_value
        self.originalColor = color
        self.originalValue = real_value
    }
}
