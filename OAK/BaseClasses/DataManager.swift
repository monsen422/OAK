//
//  Singleton.swift
//  NaseebNetworksInc
//
//  Created by Mac on 30/11/2016.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class DataManager
{
    ////////////
    
    var controllerTabNumber:Int = -1
    var swiftDictMonths : Dictionary<String,AnyObject?> = Dictionary<String,AnyObject!>()
    var tagOfMonth:Int = 0
    
    ///////////
    
    var lineChartView:LineChartViewUmair?
    var x_axis_Points:[CGFloat] = [CGFloat]()
    var y_Axis_points_final:[CGFloat] = [CGFloat]()
    var valueX:CGFloat = 0.0
    
    var dotColorString:String = ""
    var fillColorString:String = ""
    
    var dataArray:NSMutableArray = []
    var quaterArray:NSMutableArray = []
    var isMonthSelected = true
    
    //MARK: BottomSliderValues
    let colorsArray:[String] = ["cf5647","d36c48","da844b","df9e4e","e6b84f","d6c257","b1ba64","8bb672","66b182","44ab91"]
    var minValueSLider:CGFloat = 10.0
    var maxValueSLider:CGFloat = 90.0
    
    public static let dataManagerSharedInstance = DataManager()
    private init()
    {
        self.addDummyData()
    }
    
    func addDummyData() -> Void {
        
        dataArray = NSMutableArray();
        
        var element1 = jsonStandard()
        element1["name"] = "Jan" as AnyObject?
        element1["count"] = "15" as AnyObject?
        
        var element2 = jsonStandard()
        element2["name"] = "Feb" as AnyObject?
        element2["count"] = "5" as AnyObject?
        
        
        var element3 = jsonStandard()
        element3["name"] = "Mar" as AnyObject?
        element3["count"] = "10" as AnyObject?
        
        var element4 = jsonStandard()
        element4["name"] = "Apr" as AnyObject?
        element4["count"] = "10" as AnyObject?
        
        var element5 = jsonStandard()
        element5["name"] = "May" as AnyObject?
        element5["count"] = "5" as AnyObject?
        
        var element6 = jsonStandard()
        element6["name"] = "May" as AnyObject?
        element6["count"] = "5" as AnyObject?
        
        var element7 = jsonStandard()
        element7["name"] = "Jun" as AnyObject?
        element7["count"] = "10" as AnyObject?
        
        var element8 = jsonStandard()
        element8["name"] = "Jul" as AnyObject?
        element8["count"] = "5" as AnyObject?
        
        var element9 = jsonStandard()
        element9["name"] = "Aug" as AnyObject?
        element9["count"] = "5" as AnyObject?
        
        var element10 = jsonStandard()
        element10["name"] = "Sep" as AnyObject?
        element10["count"] = "10" as AnyObject?
        
        var element11 = jsonStandard()
        element11["name"] = "Nov" as AnyObject?
        element11["count"] = "10" as AnyObject?
        
        var element12 = jsonStandard()
        element12["name"] = "Dec" as AnyObject?
        element12["count"] = "10" as AnyObject?
        
        dataArray.add(element1);
        dataArray.add(element2);
        dataArray.add(element3);
        dataArray.add(element4);
        dataArray.add(element5);
        dataArray.add(element6);
        dataArray.add(element7);
        dataArray.add(element8);
        dataArray.add(element9);
        dataArray.add(element10);
        dataArray.add(element11);
        dataArray.add(element12);
        
        //print("The Dummy Data Array is :: \(dataArray)")
        self.GenerateQuaterArray()
    }
    
    func GenerateQuaterArray()
    {
        quaterArray = NSMutableArray();
        
        var counter = 0
        var percentageTotal = 0
        while(counter < 3)
        {
            let currentElement = dataArray[counter] as! jsonStandard
            let percentCount = Int(currentElement["count"] as! String)
            percentageTotal = percentageTotal + percentCount!
            counter = counter+1
        }
        
        var element1 = jsonStandard()
        element1["name"] = "Jan-Mar" as AnyObject?
        element1["count"] = String(percentageTotal) as AnyObject?
        quaterArray.add(element1)
        
        percentageTotal = 0
        while(counter < 6)
        {
            let currentElement = dataArray[counter] as! jsonStandard
            let percentCount = Int(currentElement["count"] as! String)
            percentageTotal = percentageTotal + percentCount!
            counter = counter+1
        }
        
        var element2 = jsonStandard()
        element2["name"] = "Apr-Jun" as AnyObject?
        element2["count"] = String(percentageTotal) as AnyObject?
        quaterArray.add(element2)
        
        percentageTotal = 0
        while(counter < 9)
        {
            let currentElement = dataArray[counter] as! jsonStandard
            let percentCount = Int(currentElement["count"] as! String)
            percentageTotal = percentageTotal + percentCount!
            counter = counter+1
        }
        
        var element3 = jsonStandard()
        element3["name"] = "Jul-Sep" as AnyObject?
        element3["count"] = String(percentageTotal) as AnyObject?
        quaterArray.add(element3)
        
        
        percentageTotal = 0
        while(counter < 12)
        {
            let currentElement = dataArray[counter] as! jsonStandard
            let percentCount = Int(currentElement["count"] as! String)
            percentageTotal = percentageTotal + percentCount!
            counter = counter+1
        }
        
        var element4 = jsonStandard()
        element4["name"] = "Oct-Dec" as AnyObject?
        element4["count"] = String(percentageTotal) as AnyObject?
        quaterArray.add(element4)
        
        print("The Quater Array is :: \(quaterArray)")
        
    }
    
}
