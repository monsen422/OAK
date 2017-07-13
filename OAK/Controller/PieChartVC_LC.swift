//
//  PieChartVC.swift
//  OAK
//
//  Created by Mac on 08/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import Charts

class PieChartVC_LC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tbl_dataTableView_outlet: UITableView!
    @IBOutlet var view_pieGraph_outlet: UIView!
    @IBOutlet var view_pie_inner_outlet: RozeeUIView!
    @IBOutlet var view_tbl_header_outlet: UIView!
    
    let pieChartView = UmairPieChartView()
    
    
    var dataArray:NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register for Xib
        tbl_dataTableView_outlet.register(UINib(nibName: "PieTableCell", bundle: nil), forCellReuseIdentifier: "pieTableCel")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.addDummyData()
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.PopulatePieChart_Umair), userInfo: nil, repeats: false);
        //self.PopulatePieChart_Umair()
        
        self.tbl_dataTableView_outlet.tableHeaderView = self.view_tbl_header_outlet
        self.tbl_dataTableView_outlet.reloadData()
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
    
    //MARK: Umair Functions
    
    public func MoveToNextControllerOnRotationChange()
    {
        //let nextScreen = PieChartVC(nibName: "PieChartVC_LC", bundle: nil)
        //self.navigationController?.pushViewController(nextScreen, animated: true)
        _ = self.navigationController?.popViewController(animated: false)
    }
    
    func PopulatePieChart_Umair() -> Void {
        
        pieChartView.frame = CGRect(x: 0, y: 0, width: self.view_pieGraph_outlet.frame.size.width, height: self.view_pieGraph_outlet.frame.size.height)
        //D5974B
        pieChartView.segments = [
            Segment(color: UIColor(hexString: "A85639")!, name:"57.56%", value: 57.56, highlight:false),
            Segment(color: UIColor(hexString: "D5974B")!, name: "42%", value: 42, highlight:true),
            Segment(color: UIColor(hexString: "CFA647")!, name: "45%", value: 45, highlight:false),
            Segment(color: UIColor(hexString: "C8A045")!, name: "38%", value: 38, highlight:false)
        ]
        
        pieChartView.segmentLabelFont = UIFont.systemFont(ofSize: 7)
        pieChartView.showSegmentValueInLabel = false
        
        self.view_pieGraph_outlet.addSubview(pieChartView)
        self.view_pieGraph_outlet.bringSubview(toFront: self.view_pie_inner_outlet)
        
    }
    
    func addDummyData() -> Void {
        
        dataArray = NSMutableArray();
        
        var element1 = jsonStandard()
        element1["name"] = "Expired - NotDated" as AnyObject?
        element1["count"] = "5" as AnyObject?
        
        var element2 = jsonStandard()
        element2["name"] = "Expired - Dated" as AnyObject?
        element2["count"] = "12" as AnyObject?
        
        
        var element3 = jsonStandard()
        element3["name"] = "Dated After Expired" as AnyObject?
        element3["count"] = "6" as AnyObject?
        
        var element4 = jsonStandard()
        element4["name"] = "Need Dates Within 6 Months" as AnyObject?
        element4["count"] = "3" as AnyObject?
        
        var element5 = jsonStandard()
        element5["name"] = "Dated WithIn Expiry" as AnyObject?
        element5["count"] = "1" as AnyObject?
        
        dataArray.add(element1);
        dataArray.add(element2);
        dataArray.add(element3);
        dataArray.add(element4);
        dataArray.add(element5);
        dataArray.add(element3);
        
        //print("The Dummy Data Array is :: \(dataArray)")
        
    }
    
    //MARK: UITableView Delegates
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let returnValue = dataArray.count
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pieTableCel", for: indexPath) as! PieTableCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let currentData = self.dataArray.object(at: indexPath.row) as! jsonStandard
        cell.lbl_name_outlet.text = currentData["name"] as! String?;
        cell.lbl_count_outlet.text = currentData["count"] as! String?;
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let returnValue:CGFloat = 38.0
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let returnValue: CGFloat = 0.1
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let returnValue = tbl_dataTableView_outlet.dequeueReusableHeaderFooterView(withIdentifier: "PieTableSectionHeader")
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "goToCategory", sender: self)
    }

}
