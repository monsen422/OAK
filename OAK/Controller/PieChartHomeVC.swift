//
//  PieChartHomeVC.swift
//  OAK
//
//  Created by Mac on 12/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class PieChartHomeVC: UIViewController {
    
    
    @IBOutlet var view1_below: UIView!
    @IBOutlet var view1_above: UIView!
    @IBOutlet var seperater1: UIView!
    
    @IBOutlet var view2_below: UIView!
    @IBOutlet var view2_above: UIView!
    @IBOutlet var seperater2: UIView!
    
    @IBOutlet var view3_below: UIView!
    @IBOutlet var view3_above: UIView!
    @IBOutlet var seperater3: UIView!
    
    @IBOutlet var view4_below: UIView!
    @IBOutlet var view4_above: UIView!
    @IBOutlet var seperater4: UIView!
    
    @IBOutlet var view5_below: UIView!
    @IBOutlet var view5_above: UIView!
    @IBOutlet var seperater5: UIView!
    
    @IBOutlet var lbl_sector1_outlet: UILabel!
    @IBOutlet var lbl_sector2_outlet: UILabel!
    @IBOutlet var lbl_sector3_outlet: UILabel!
    @IBOutlet var lbl_sector4_outlet: UILabel!
    @IBOutlet var lbl_sector5_outlet: UILabel!
    @IBOutlet var lbl_sector6_outlet: UILabel!
    
    
    
    @IBOutlet var view_crossView_outlet: UIView!
    @IBOutlet var crossLeftView_outlet: UIView!
    @IBOutlet var crossRightView_outlet: UIView!
    
    @IBOutlet var view_middleInfor: UIView!
    
    
    let segmentArray1 = [
        Segment(color: UIColor.red, name:"", value: 100.0, highlight:false),
        Segment(color: UIColor.brown, name: "", value: 90.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 80.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 70.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 60.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 50.0, highlight:false),
        ]
    
    let segmentArray2 = [
        Segment(color: UIColor.red, name:"", value: 70.0, highlight:false),
        Segment(color: UIColor.brown, name: "", value: 60.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 70.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 50.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 90.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 20.0, highlight:false),
        ]
    
    
    let segmentArray3 = [
        Segment(color: UIColor.red, name:"", value: 100.0, highlight:false),
        Segment(color: UIColor.brown, name: "", value: 90.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 80.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 70.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 60.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 50.0, highlight:false),
        ]
    
    let segmentArray4 = [
        Segment(color: UIColor.red, name:"", value: 100.0, highlight:false),
        Segment(color: UIColor.brown, name: "", value: 90.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 80.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 70.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 60.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 50.0, highlight:false),
        ]
    
    let segmentArray5 = [
        Segment(color: UIColor.red, name:"", value: 70.0, highlight:false),
        Segment(color: UIColor.brown, name: "", value: 60.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 70.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 50.0, highlight:false),
        Segment(color: UIColor.purple, name: "", value: 90.0, highlight:false),
        Segment(color: UIColor.orange, name: "", value: 20.0, highlight:false),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.LoadComplexPieChart), userInfo: nil, repeats: false);
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
    
    // MARK: Umair Functions
    
    public func MoveToNextControllerOnRotationChange()
    {
        let nextScreen = PieChartHomeVC_LC(nibName: "PieChartHomeVC_LC", bundle: nil)
        self.navigationController?.pushViewController(nextScreen, animated: false)
    }
    
    func LoadComplexPieChart()
    {
        self.PopulatePieChart_Umair(parentView: view1_below)
        self.PopulatePieChart_Umair_Above(parentView: view1_above, segmentArray: segmentArray1)
        self.ShowSeperator(seperaterView: seperater1, belowView: view1_below)
        
        self.PopulatePieChart_Umair(parentView: view2_below)
        self.PopulatePieChart_Umair_Above(parentView: view2_above, segmentArray: segmentArray2)
        self.ShowSeperator(seperaterView: seperater2, belowView: view2_below)
        
        self.PopulatePieChart_Umair(parentView: view3_below)
        self.PopulatePieChart_Umair_Above(parentView: view3_above, segmentArray: segmentArray3)
        self.ShowSeperator(seperaterView: seperater3, belowView: view3_below)
        
        self.PopulatePieChart_Umair(parentView: view4_below)
        self.PopulatePieChart_Umair_Above(parentView: view4_above, segmentArray: segmentArray4)
        self.ShowSeperator(seperaterView: seperater4, belowView: view4_below)
        
        self.PopulatePieChart_Umair(parentView: view5_below)
        self.PopulatePieChart_Umair_Above(parentView: view5_above, segmentArray: segmentArray5)
        self.ShowSeperator(seperaterView: seperater5, belowView: view5_below)
        
        self.AdjustMiddleView(lastSeperater: seperater5)
        //self.AdjustCrossView(lastSeperater: view1_below)
        
        self.AdjustLabels()
    }
    
    func AdjustLabels() -> Void
    {
        lbl_sector1_outlet.isHidden = false
        lbl_sector1_outlet.transform = CGAffineTransform(rotationAngle: CGFloat((40) / 180.0 * M_PI))
        
        lbl_sector2_outlet.isHidden = false
        lbl_sector2_outlet.transform = CGAffineTransform(rotationAngle: CGFloat((90) / 180.0 * M_PI))
        
        lbl_sector3_outlet.isHidden = false
        lbl_sector3_outlet.transform = CGAffineTransform(rotationAngle: CGFloat((140) / 180.0 * M_PI))
        
        lbl_sector4_outlet.isHidden = false
        lbl_sector4_outlet.transform = CGAffineTransform(rotationAngle: CGFloat((-35) / 180.0 * M_PI))
        
        lbl_sector5_outlet.isHidden = false
        lbl_sector5_outlet.transform = CGAffineTransform(rotationAngle: CGFloat((-90) / 180.0 * M_PI))
        
        lbl_sector6_outlet.isHidden = false
        lbl_sector6_outlet.transform = CGAffineTransform(rotationAngle: CGFloat((-140) / 180.0 * M_PI))
    }
    
    func PopulatePieChart_Umair(parentView:UIView) -> Void {
        
        let piChartView = PieChartSixPieceView()
        piChartView.frame = CGRect(x: 0, y: 0, width: parentView.frame.size.width, height: parentView.frame.size.height)
        
        piChartView.segments = [
            Segment(color: UIColor.red, name:"", value: 16.6, highlight:false),
            Segment(color: UIColor.brown, name: "", value: 16.6, highlight:false),
            Segment(color: UIColor.purple, name: "", value: 16.6, highlight:false),
            Segment(color: UIColor.orange, name: "", value: 16.6, highlight:false),
            Segment(color: UIColor.purple, name: "", value: 16.6, highlight:false),
            Segment(color: UIColor.orange, name: "", value: 16.6, highlight:false),
        ]
        
        piChartView.segmentLabelFont = UIFont.systemFont(ofSize: 17)
        piChartView.showSegmentValueInLabel = false
        piChartView.isBaseColorView = true
        
        parentView.addSubview(piChartView)
        
    }
    
    func PopulatePieChart_Umair_Above(parentView:UIView , segmentArray:[Segment]) -> Void {
        
        let piChartView1 = PieChartSixPieceView()
        piChartView1.frame = CGRect(x: 0, y: 0, width: parentView.frame.size.width, height: parentView.frame.size.height)
        
        piChartView1.segments = segmentArray
        
        piChartView1.segmentLabelFont = UIFont.systemFont(ofSize: 17)
        piChartView1.showSegmentValueInLabel = false
        piChartView1.isBaseColorView = false
        
        parentView.addSubview(piChartView1)
    }
    
    func ShowSeperator(seperaterView:UIView , belowView:UIView) -> Void
    {
        let fraction:CGFloat = 5.0
        let radius = min(seperaterView.frame.width, seperaterView.frame.height) - fraction
        var frameOfFirstView = seperaterView.frame
        frameOfFirstView.size.width = radius
        frameOfFirstView.size.height = radius
        frameOfFirstView.origin.x = 0
        frameOfFirstView.origin.y = 0
        seperaterView.frame = frameOfFirstView
        seperaterView.center = belowView.center
        seperaterView.layer.cornerRadius = seperaterView.frame.size.height/2
        seperaterView.layer.masksToBounds = true
        seperaterView.isHidden = false
    }
    
    func AdjustMiddleView(lastSeperater:UIView)
    {
        let fraction:CGFloat = 5.0
        let radius = min(lastSeperater.frame.width, lastSeperater.frame.height) - fraction
        var frameOfFirstView = lastSeperater.frame
        frameOfFirstView.size.width = radius
        frameOfFirstView.size.height = radius
        frameOfFirstView.origin.x = 0
        frameOfFirstView.origin.y = 0
        view_middleInfor.frame = frameOfFirstView
        view_middleInfor.center = lastSeperater.center
        view_middleInfor.layer.cornerRadius = view_middleInfor.frame.size.height/2
        view_middleInfor.layer.masksToBounds = true
        view_middleInfor.isHidden = false
        
        view_middleInfor.isHidden = false
    }
    
    func AdjustCrossView(lastSeperater:UIView)
    {
        
        let fraction:CGFloat = 5.0
        let radius = min(lastSeperater.frame.width, lastSeperater.frame.height) - fraction
        var frameOfFirstView = lastSeperater.frame
        frameOfFirstView.size.width = radius
        frameOfFirstView.size.height = radius
        frameOfFirstView.origin.x = 0
        frameOfFirstView.origin.y = 0
        view_crossView_outlet.frame = frameOfFirstView
        view_crossView_outlet.center = lastSeperater.center
        view_crossView_outlet.layer.cornerRadius = view_crossView_outlet.frame.size.height/2
        view_crossView_outlet.layer.masksToBounds = true
        view_crossView_outlet.isHidden = false
        
        crossLeftView_outlet.transform = CGAffineTransform(rotationAngle: CGFloat((-60) / 180.0 * M_PI))
        crossRightView_outlet.transform = CGAffineTransform(rotationAngle: CGFloat((60) / 180.0 * M_PI))
        view_crossView_outlet.isHidden = false
        
        
    }

}
