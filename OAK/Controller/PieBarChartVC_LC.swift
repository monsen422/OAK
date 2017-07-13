//
//  PieBarChartVC_LC.swift
//  OAK
//
//  Created by Mac on 15/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class PieBarChartVC_LC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var view_pieGraph_outlet: UIView!
    @IBOutlet var tbl_dataTableView_outlet: UITableView!
    
    let pieChartView = UmairPieChartView()
    
    var arrayReference = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.PopulatePieChart_Umair()
        
        if(DataManager.dataManagerSharedInstance.isMonthSelected)
        {
            arrayReference = DataManager.dataManagerSharedInstance.dataArray
        }
        else
        {
            arrayReference = DataManager.dataManagerSharedInstance.quaterArray
        }
        
        // Register for Xib
        tbl_dataTableView_outlet.register(UINib(nibName: "PieBarViewCell1", bundle: nil), forCellReuseIdentifier: "pieBarViewCell1")
        
        // Register Header Xibs
        let nib = UINib(nibName: "PieBarSectionHeader", bundle: nil)
        tbl_dataTableView_outlet.register(nib, forHeaderFooterViewReuseIdentifier: "PieBarSectionHeader")
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
            Segment(color: UIColor(hexString: "A85639")!, name:"", value: 65.56, highlight:false),
            Segment(color: UIColor(hexString: "D5974B")!, name: "", value: 42, highlight:true),
            Segment(color: UIColor(hexString: "CFA647")!, name: "", value: 45, highlight:false),
            Segment(color: UIColor(hexString: "C8A045")!, name: "", value: 38, highlight:false)
        ]
        
        pieChartView.segmentLabelFont = UIFont.systemFont(ofSize: 7)
        pieChartView.showSegmentValueInLabel = false
        
        self.view_pieGraph_outlet.addSubview(pieChartView)
        //self.view_pieGraph_outlet.bringSubview(toFront: self.view_pie_inner_outlet)
        
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
        let returnValue = arrayReference.count
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pieBarViewCell1", for: indexPath) as! PieBarViewCell1
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        let currentData = arrayReference.object(at: indexPath.row) as! jsonStandard
        cell.lbl_name_outlet.text = currentData["name"] as! String?
        cell.view_barView_outlet.tag = indexPath.row
        cell.view_barView_outlet.setNeedsDisplay()
        var percentage = currentData["count"] as! String?
        percentage = percentage!+"%"
        cell.lbl_count_outlet.text = percentage
        
        cell.view_barView_outlet.isHidden = true
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let returnValue:CGFloat = 36.0
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let returnValue: CGFloat = 0.1
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let returnValue = tbl_dataTableView_outlet.dequeueReusableHeaderFooterView(withIdentifier: "PieBarSectionHeader")
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "goToCategory", sender: self)
    }

}
