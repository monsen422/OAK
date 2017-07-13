//
//  LineChartVC.swift
//  OAK
//
//  Created by Mac on 08/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class LineChartVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var dataDictionary:jsonStandard = jsonStandard()
     //= LineChartViewUmair()
    
    var yValues = ["12" , "20" , "15" , "25" , "15"];
    var xValues = ["Mon" , "Tue" , "Wed" , "Thu" , "Fri"];
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var lineChartView_outlet: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadDummyData()
        
        // Register for Xib
        myTableView.register(UINib(nibName: "LineChartCell", bundle: nil), forCellReuseIdentifier: "LineChartCell")
        
        // Register Header Xibs
        let nib = UINib(nibName: "LineHeader", bundle: nil)
        
        myTableView.register(nib, forHeaderFooterViewReuseIdentifier: "LineHeader")
        
        //self.setLineChartView()
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.setLineChartView), userInfo: nil, repeats: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UmairFunctions
    
    func setLineChartView()
    {
        //lineChartView = LineChartViewUmair(frame: self.lineChartView_outlet.bounds)
        DataManager.dataManagerSharedInstance.lineChartView = LineChartViewUmair()
        DataManager.dataManagerSharedInstance.lineChartView?.lineFrame = self.lineChartView_outlet.bounds
        DataManager.dataManagerSharedInstance.lineChartView?.yValues = yValues
        DataManager.dataManagerSharedInstance.lineChartView?.xValues = xValues
        DataManager.dataManagerSharedInstance.dotColorString = "da844b"
        DataManager.dataManagerSharedInstance.fillColorString = "f9f0eb"
        DataManager.dataManagerSharedInstance.lineChartView?.updateMySelf()
        
        //lineChartView.setNeedsDisplay()
        self.lineChartView_outlet.addSubview(DataManager.dataManagerSharedInstance.lineChartView!)
    }
    
    public func MoveToNextControllerOnRotationChange()
    {
        let nextScreen = LineChartVC_LC(nibName: "LineChartVC_LC", bundle: nil)
        self.navigationController?.pushViewController(nextScreen, animated: false)
    }
    
    func loadDummyData() ->Void
    {
        var generalArray = [LineObject]();
        generalArray.append(LineObject(idd:"1" , name:"Dr. Avocado"))
        generalArray.append(LineObject(idd:"1" , name:"Dr. Alfa"))
        generalArray.append(LineObject(idd:"1" , name:"Dr. Molamv"))
        
        var electiveArray = [LineObject]();
        electiveArray.append(LineObject(idd:"1" , name:"First Elective"))
        
        var electiveEmgArray = [LineObject]();
        electiveEmgArray.append(LineObject(idd:"1" , name:"E. Emg"))
        
        dataDictionary["Elective Patients"] = electiveArray as AnyObject?
        dataDictionary["General"] = generalArray as AnyObject?
        dataDictionary["Emergiency"] = electiveEmgArray as AnyObject?
        
        //print("Bismillah, The Data is :: \(dataDictionary)")
        
    }
    
    //MARK: UITableView Delegates
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        let theKeysCount = Array(dataDictionary.keys)//dataDictionary.keys.count
        return theKeysCount.count
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let returnValue = 0
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineChartCell", for: indexPath) as! LineChartCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let returnValue:CGFloat = 41.0
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let returnValue: CGFloat = 40.0
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let returnValue = myTableView.dequeueReusableHeaderFooterView(withIdentifier: "LineHeader") as!LineHeader
        
        let allKeys = Array(dataDictionary.keys)
        let currentKey = allKeys[section]
        
        returnValue.lbl_name.text = currentKey
        
        return returnValue
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "goToCategory", sender: self)
    }
    


}
