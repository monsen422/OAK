//
//  PieChartVC.swift
//  OAK
//
//  Created by Mac on 08/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import Charts

class PieChartVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    //@IBOutlet var pieChartView: PieChartView!
    @IBOutlet var tbl_dataTableView_outlet: UITableView!
    @IBOutlet var view_tableHeader_outlet: UIView!
    @IBOutlet var view_pieGraph_outlet: UIView!
    @IBOutlet var view_pie_inner_outlet: RozeeUIView!
    @IBOutlet weak var rangeSliderView: UIView!
    
    let pieChartView = UmairPieChartView()
    var slideRangeView = UIView()
    
    
    var dataArray:NSMutableArray = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        let months = ["Jan", "Feb", "Mar"]
        let unitsSold = [20.0, 4.0, 6.0]
        
        setChart(dataPoints: months, values: unitsSold)
 */
        
        //NotificationCenter.default.addObserver(self, selector: #selector(PieChartVC.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        self.addDummyData()
        self.PopulatePieChart_Umair()
                
        
        // Register for Xib
        tbl_dataTableView_outlet.register(UINib(nibName: "PieTableCell", bundle: nil), forCellReuseIdentifier: "pieTableCel")
        
        // Register Header Xibs
        let nib = UINib(nibName: "PieTableSectionHeader", bundle: nil)
        tbl_dataTableView_outlet.register(nib, forHeaderFooterViewReuseIdentifier: "PieTableSectionHeader")
        
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
        let nextScreen = PieChartVC_LC(nibName: "PieChartVC_LC", bundle: nil)
        self.navigationController?.pushViewController(nextScreen, animated: false)
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
    
    func rotated()
    {
        
        let orientation = UIApplication.shared.statusBarOrientation
        if (orientation == .portrait )
        {
            print("Bismillah. Portrate");
            _ = self.navigationController?.popViewController(animated: true)
        }
        if (orientation == .landscapeLeft || orientation == .landscapeRight)
        {
            print("Bismillah. LandScape");
            let nextScreen = PieChartVC(nibName: "PieChartVC_LC", bundle: nil)
            self.navigationController?.pushViewController(nextScreen, animated: true)
        }
    }
    
    /*
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            
            dataEntries.append(dataEntry1)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        self.pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        colors.append(UIColor.purple)
        colors.append(UIColor.red)
        colors.append(UIColor.orange)
        pieChartDataSet.colors = colors
        
        self.pieChartView.centerText = "200 Patients"
        self.pieChartView.chartDescription?.text = ""
        self.pieChartView.legend.enabled = false
        //self.pieChartView.
        
 
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
            pieChartDataSet.colors = colors
        }
 
 
    }
 */
    
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
        let returnValue: CGFloat = 55.0
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let returnValue = tbl_dataTableView_outlet.dequeueReusableHeaderFooterView(withIdentifier: "PieTableSectionHeader")
        return returnValue
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "goToCategory", sender: self)
    }

}
