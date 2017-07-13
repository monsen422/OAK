//
//  HomeVC~iphone.swift
//  OAK
//
//  Created by TVT on 12/11/16.
//  Copyright © 2016 Pham Minh Vu (Jason). All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage


class HomeVC_iphone: UIViewController, UIScrollViewDelegate , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var view_monthLabelDetail: UIView!
    @IBOutlet var tbl_monthBarsTable: UITableView!
    
    @IBOutlet var lbl_overallPercentage: UILabel!
    @IBOutlet var lbl_electiveCount: UILabel!
    @IBOutlet var lbl_generalCount: UILabel!
    @IBOutlet var lbl_electiveEmergencyCount: UILabel!

//    var monthScrollView: UIScrollView!
    var itemScrollView: UIScrollView!
    var chartViewScroll:  UIScrollView!
    var activityIndicator : UIActivityIndicatorView!
    var overlayView : UIView!
    var apiKey:String = ""
    var avatar:String = ""
    var fullname:String = ""
    var rowButtons = [UIButton]()
    var labelButtons = [UIButton]()
    var rowViews = [UIView]()
    var barButtons = [Bar]()
    var barViews = [UIView]()
    var monthLabels = [UILabel]()
    var attributes = ["Elective Patient", "General", "Emergency" ,"Day Surgery", "Total Elective Emergency"]
    var attributeFields = ["elective_patient", "general", "emergency" ,"day_surgery", "total_elective_emergency"]
    var months = [[String]]()
    var years:[String] = []
    var barDatas = [[MonthData]]()
    var rowDataSelected = [MonthData]()
    var barDataSelected = MonthData(order: -1, label: "", value: "", color: "", elective_patient: "", general: "", emergency: "", day_surgery: "", total_elective_emergency: "", real_value: "")
    var currentSelectedRow = -1
    var labels:[String] = []
    var itemWidth = 52
    var itemHeight = 46
    var posSecondBlock: Int = 151
    var senderTap: BoXButton! = nil
    var isDetail = false
    var tableY:CGFloat = 154 - 86
    var yearView = UIView()
    var slideRangeView = UIView()
    var labelLower: UILabel!
    var labelUpper: UILabel!
    var xLower: CGFloat!
    var xUpper: CGFloat!
    var orientations:UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
    @IBOutlet var headerView: [UIView]!
    
    
    @IBOutlet weak var monthScrollView: UIScrollView!
    
    @IBOutlet weak var mySrollView: UIScrollView!
    @IBOutlet weak var scrollViewParent: UIScrollView!
    @IBOutlet weak var attributeView: UIView!
    @IBOutlet weak var constraintAttributeView: NSLayoutConstraint!
    @IBOutlet weak var lbAttributeName: UILabel!
    @IBOutlet weak var lbPercent: UILabel!
    @IBOutlet weak var lbPercentcharacter: UILabel!
    @IBOutlet weak var monthScrollLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var monthTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var myScrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var lbElectivePartients: UILabel!
    @IBOutlet weak var lbGeneral: UILabel!
    @IBOutlet weak var lbEmergency: UILabel!
    @IBOutlet weak var rangeSliderView: UIView!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbDetailTitle: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    
    let rangeSlider = RangeSlider(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register for Xib
        self.tbl_monthBarsTable.register(UINib(nibName: "MonthDetailCell", bundle: nil), forCellReuseIdentifier: "MonthDetailCell")

        // Do any additional setup after loading the view.
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        overlayView.addSubview(activityIndicator)
        
        let prefs:UserDefaults = UserDefaults.standard
        let yearData = prefs.object(forKey: "YEARS") as? Data
        if let yearData = yearData {
            let yearArray = NSKeyedUnarchiver.unarchiveObject(with: yearData) as? [String]
            
            if let yearArray = yearArray {
                years = yearArray
            }
        }
        
        self.setupLayout()
        if self.years.count > 0 {
            self.loadData(self.years[0])
            btnYear.setTitle(self.years[0], for: UIControlState())


        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLower(_:)), name: NSNotification.Name("UPDATE_LOWER"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUpper(_:)), name: NSNotification.Name("UPDATE_UPPER"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.filterUmair(noti:)), name: NSNotification.Name("AwsomeSliderMoved"), object: nil)
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.scrollViewTapped(_:)))
        //self.mySrollView.addGestureRecognizer(tapGesture)
        
        DataManager.dataManagerSharedInstance.controllerTabNumber = 5
        
    }
    
    func scrollViewTapped(_ sender: UITapGestureRecognizer) {
        print("------------------------------- Bismillah ----------------------------------")
    }
    
    func rotated()
    {
        
        adjustViewsForOrientation(orientation: UIApplication.shared.statusBarOrientation)
    }
    
    func adjustViewsForOrientation(orientation: UIInterfaceOrientation) {
        
        
        //        attributeScrollView.frame = CGRect(x: CGFloat(posFirstBlock), y: attributeScrollView.frame.origin.y, width: 235, height: 80)
        
        if (orientation == .portrait )
        {
            if(orientation != orientations) {
                
                //Do Rotation stuff here
//                orientations = orientation
//                self.headerConstraint.constant = 87
//                self.btnYear.isHidden = true
//                self.profileTrailingConstraint.priority = 110
//                self.bottomLeadingConstraint.priority = 80
//                self.btnRightIcon.isHidden = true
//                btnHeaderYear.isHidden = false
//                self.nextImage.isHidden = false
//                posSecondBlock = 242
//                bottomControllConstraint.constant = 8
//                widthAttributeConstraint.constant = 193
//                btnHeaderRightIcon.isHidden = false
//                
//                self.contraintTopSlide.constant = 105
                
            }
            else {
                return
            }
        }
        if (orientation == .landscapeLeft || orientation == .landscapeRight)
        {
            if(orientation != orientations) {
                //Do Rotation stuff here
                //Render Header
                orientations = orientation
                //Render Header
//                self.headerConstraint.constant = 60
//                self.btnYear.isHidden = false
//                self.bottomLeadingConstraint.priority = 95
//                self.profileTrailingConstraint.priority = 90
//                self.btnRightIcon.isHidden = false
//                self.nextImage.isHidden = true
//                btnHeaderYear.isHidden = true
//                posSecondBlock = 264
//                btnHeaderRightIcon.isHidden = true
//                bottomControllConstraint.constant = 28
//                widthAttributeConstraint.constant = 215
//                
//                self.contraintTopSlide.constant = 48
                
            }
            else {
                return
            }
        }
        
        
        
        self.renderTable(self.labels)
        
        self.renderMonth(self.months[0])
//        self.updateYearView()
        
        if (self.senderTap != nil) {
            self.rowTapped(self.senderTap)
        }
//        self.renderProfile()
//        updateSliderFrame()
    }
    
    func updateLower(_ noti: Notification) {
        
        
        let value = noti.userInfo?["value"] as! Double
        
        let value_ = self .roundTo(value: value, places: 5)  // x becomes 0.1235 under Swift 2
        
        labelLower.frame.origin.x = (rangeSlider.lowerThumbLayer.frame.origin.x + 12)
        print("\(value_) :" + "\(labelLower.frame.origin.x)")
        labelLower.text = "\(Int(round(rangeSlider.lowerThumbLayer.frame.origin.x + 6)/300*100))"
        
    }
    
    func updateUpper(_ noti: Notification) {
        let value = noti.userInfo?["value"] as! Double
        let value_ = self .roundTo(value: value, places: 2)  // x becomes 0.1235 under Swift 2
        
        labelUpper.frame.origin.x = (rangeSlider.upperThumbLayer.frame.origin.x + 12)
        print("\(self.rangeSlider.frame.origin.x) :" + "\(value_) :" + "\(labelLower.frame.origin.x)")
        
        labelUpper.text = "\(Int(round(rangeSlider.upperThumbLayer.frame.origin.x + 6)/300*100))"
        
    }
    
    func roundTo(value: Double,places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (value * divisor).rounded() / divisor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: INDICATOR
    func showLoading(){
        self.overlayView.center = self.view.center
        self.view.addSubview(self.overlayView)
        self.activityIndicator.startAnimating()
        
    }
    func hideLoading(){
        self.activityIndicator.stopAnimating()
        self.overlayView.removeFromSuperview()
    }
    func showMessage(_ msg:String){
        let alert = UIAlertController(title: "Sorry!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in  }
        alert.addAction(action)
        self.present(alert, animated: true){}
    }

    
    func loadData(_ year:String){
        self.showLoading()
        self.reset()
        
        let params = ["year":year] as Dictionary<String, String>
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        manager.post(API_LIST_ITEMS, parameters: params, progress: { (Progress) in
            
            
        }, success: { (task, responseObject) in
            
            if responseObject != nil {
                
                let json: NSDictionary = responseObject as! NSDictionary
                //success
                let success = json["success"] as? Bool
                if(success == false){
                    let msg =  json["msg"] as? String
                    
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.showMessage(msg!)
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.successHandler(json);
                    }
                }
                
            }else {
                
                //Error
                
                self.hideLoading()
                self.showMessage("Network error!")
            }
            
            
            
        }) { (operation, error) in
            
            //Error
            self.hideLoading()
            self.showMessage("Network error!")
            
        }
        
    }
    
    //MARK: CALL API
    func successHandler(_ data:NSDictionary){
        print(data)
        var swiftDict : Dictionary<String,AnyObject?> = Dictionary<String,AnyObject!>()
        var colors = [[UIColor]]()
        for (key,_) in data {
            
            let stringKey = key as! String
            if let keyValue = data.value(forKey: stringKey){
                swiftDict[stringKey] = keyValue as AnyObject??
                DataManager.dataManagerSharedInstance.swiftDictMonths[stringKey] = keyValue as AnyObject??
            }
        }
        
        
        let items = swiftDict["items"]! as! Dictionary<String,AnyObject?>
        
        self.labels  = items.keys.sorted()
        for i in 0...self.labels.count-1{
            
            let dataMonth = items[self.labels[i]] as! Array<Dictionary<String,AnyObject?>>
            
            var colorTemp:[String] = []
            var month:[String] = []
            var barData:[MonthData] = []
            for data_ in dataMonth{
                
                let data = data_ as NSDictionary
                
                let modelData: JSONModelData = try!JSONModelData(dictionary: data_)
                
                
                let order = data["order"] as? Int
                
                let label = data["label"] as? String
                
                let value = "\(modelData.value.description)"
                
                
                let color = data["color"] as? String
                let elective_patient = data["elective_patient"] as? String
                let general = data["general"] as? String
                let emergency = data["emergency"] as? String
                let day_surgery = data["day_surgery"] as? String
                let total_elective_emergency = data["total_elective_emergency"] as? String
                let real_value = data["real_value"] as? String
                
                
                let dataItem:MonthData = MonthData(order: order!, label:label!, value: value, color: color!, elective_patient: elective_patient!, general: general!, emergency: emergency!, day_surgery: day_surgery!, total_elective_emergency: total_elective_emergency!, real_value: real_value!)
                month.append(dataItem.label)
                colorTemp.append(dataItem.color)
                barData.append(dataItem)
            }
            var color:[UIColor] = []
            for j in 0 ... colorTemp.count-1{
                let hex = hexStringToUIColor("#" + colorTemp[j])
                color.append(hex)
            }
            colors.append(color)
            
            self.months.append(month)
            self.barDatas.append(barData)
            
        }
        
        print("The label Array is :: \(labels)")
        renderTable(labels)
        renderMonth(self.months[0])
        renderSlider() // 0900
        renderYearSelection()
        self.addingBlurView()
    }
    
    func reset(){
        self.months = [[String]]()
        self.barDatas = [[MonthData]]()
        self.rowDataSelected = [MonthData]()
        self.barDataSelected = MonthData(order: -1, label: "", value: "", color: "", elective_patient: "", general: "", emergency: "", day_surgery: "", total_elective_emergency: "", real_value: "")
        self.labels = []
        self.currentSelectedRow = -1
    }

    
    func setupLayout() {
        
        if isDetail {
            attributeView.isHidden = false
            constraintAttributeView.constant = 110
        }
        else {
            attributeView.isHidden = true
            constraintAttributeView.constant = 0
        }
        
    }
    
    
    //MARK: RENDER LAYOUT
    func renderMonth(_ labels:[String]) {

        var viewFrame = CGRect(x: 0, y: 0, width: itemWidth, height: 30)
        let _subviews : Array = scrollViewParent.subviews
        for subview in _subviews{
            if( subview is UIScrollView && subview.tag == 900){
                subview.removeFromSuperview()
            }
        }
        monthScrollLeadingConstraint.constant = CGFloat(posSecondBlock)
        
        monthScrollView.tag = 900
        monthScrollView.delegate = self
        monthScrollView.indicatorStyle = .white
        let theSubviews : Array = monthScrollView.subviews
        for subview in theSubviews{
            if( subview is UILabel && subview.tag >= 400){
                subview.removeFromSuperview()
            }
        }
        
        resetMonthLabels()
        monthLabels = []
        
        for j in 0...labels.count-1{
            let label = UILabel()
            viewFrame.origin.x = CGFloat(itemWidth*j)
            label.frame = viewFrame
            label.tag = 400 + j
            label.text = labels[j].components(separatedBy: " ").first?.uppercased()
            label.textAlignment = NSTextAlignment.center
            label.textColor = GRAY_COLOR
            label.font = UIFont(name: FONT_DEFAULT, size: 14)
            monthLabels += [label]
            
            label.isUserInteractionEnabled = true
            let tapGestureMonth = UITapGestureRecognizer(target: self, action: #selector(self.monthLabelTapped(_:)))
            label.addGestureRecognizer(tapGestureMonth)
            
            monthScrollView.addSubview(label)
            // Above is the months labesl
        }
        monthScrollView.contentSize.width = CGFloat(itemWidth) * CGFloat(labels.count)

        
    }
    
    func monthLabelTapped(_ sender: UITapGestureRecognizer) {
        
        let label = sender.view! as! UILabel
        let tagOfLable = label.tag-400
        print("------------------- Bismillah, Month Label Tapped, its tag is \(tagOfLable) ----------------------------------")
        
        DataManager.dataManagerSharedInstance.tagOfMonth = tagOfLable
        
        
        let items = DataManager.dataManagerSharedInstance.swiftDictMonths["items"]! as! Dictionary<String,AnyObject?>
        let labels = items.keys.sorted()
        let dataMonth = items[labels[tagOfLable]] as! Array<Dictionary<String,AnyObject?>>
        
        let currentData = dataMonth[DataManager.dataManagerSharedInstance.tagOfMonth]
        let real_value =  currentData["label"] as? String
        self.lbTitle.text = real_value
        
        isDetail = true
        updateBackButton(isDetail)
        self.tbl_monthBarsTable.reloadData()
        self.view_monthLabelDetail.isHidden = false
    }
    
    func renderTable(_ labels: [String]){
        var yPos:Int = 0
        let view1Width:Int = 140
        var view2Frame: CGRect!
        let view2Width = Int(mySrollView.frame.width) - Int(posSecondBlock) - 10
        var view1Frame = CGRect(x: 0, y: yPos, width: view1Width, height: itemHeight)
        var borderFrame = CGRect(x: 0, y: 0, width: view1Width, height: Int(0.5))
        
        view2Frame = CGRect(x: 0, y: 0, width: view2Width, height: itemHeight)
        
        var scrollViewContentSize:CGFloat = 0
        var buttonFrame = CGRect(x: Int(0.5), y: 0, width: itemWidth, height: itemHeight)
        
        let theSubviews : Array = mySrollView.subviews

        for subview in theSubviews{
            subview.removeFromSuperview()

        }
        self.rowButtons = []
        self.labelButtons = []
        self.rowViews = []
        itemScrollView = UIScrollView(frame: CGRect(x: Int(posSecondBlock),y: yPos, width:view2Width , height: itemHeight * labels.count))
        itemScrollView.indicatorStyle = .white
        itemScrollView.delegate = self
        
        for i in 0 ... labels.count - 1 {
            
            let view1 = UIButton()
            view1.setTitle(labels[i], for: UIControlState())
            view1.setTitleColor(hexStringToUIColor("#414E53"), for: UIControlState())
            view1.titleLabel?.font = UIFont(name: FONT_DEFAULT, size: 14)
            view1.titleLabel?.numberOfLines = 0
            view1.titleLabel?.lineBreakMode = .byWordWrapping
            view1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            view1.tag = i
            labelButtons += [view1]
            
            let line = UIView()
            line.backgroundColor = LIGHT_COLOR
           
            let view2 = UIView()
            view2.tag = i
            
            for j in 0 ... self.barDatas[i].count-1{
                let item:MonthData = self.barDatas[i][j]
                let button  = BoXButton()
                buttonFrame.origin.x = CGFloat(j*itemWidth)
                button.backgroundColor = hexStringToUIColor("#" + item.color)
                button.layer.borderWidth = 0.25
                button.layer.borderColor = UIColor.white.cgColor
                
                button.frame = buttonFrame
                button.alpha = 1
                button.tag = i
                button.yearTag = j
                button.addTarget(self, action: #selector(HomeVC_iphone.boxButtonPressed(_:)), for: .touchUpInside)
                //button.addTarget(self, action: #selector(HomeVC_iphone.rowTapped(_:)), for: .touchUpInside)
                rowButtons += [button]
                view2.addSubview(button) // 0900
            }
            
            view1Frame.origin.y = CGFloat(yPos)
            view2Frame.origin.y = CGFloat(yPos)
            borderFrame.origin.y = CGFloat(yPos + itemHeight-1)
            
            view1.frame = view1Frame
            view2.frame = view2Frame
            line.frame = borderFrame
            line.alpha = 0.3
            let clayerBottom: CALayer = CALayer()
            clayerBottom.frame = CGRect(x: 0, y: line.frame.size.height, width: line.frame.size.width, height: 0.5);
            clayerBottom.backgroundColor = hexStringToUIColor("#979797").cgColor
            line.layer.addSublayer(clayerBottom)
            
            rowViews += [view2]
            mySrollView.addSubview(view1)
            itemScrollView.addSubview(view2)
            mySrollView.addSubview(line)
            
            view1.addTarget(self, action: #selector(HomeVC.rowTapped(_:)), for: UIControlEvents.touchUpInside)
            
            yPos += itemHeight
            scrollViewContentSize += CGFloat(itemHeight)
        }
        
        mySrollView.contentSize.height =  scrollViewContentSize
        itemScrollView.contentSize.width = CGFloat(itemWidth) * 12
        mySrollView.addSubview(itemScrollView)
        
    }
    
    func boxButtonPressed(_ sender:BoXButton!)
    {
        print("---------    Allah is Great  ------------")
        
        isDetail = true
        
        let yearView = self.view.viewWithTag(107)! as UIView
        UIView.animate(withDuration: 0.2, animations: {
            yearView.isHidden = true
        })
        
        
        let year = btnYear.titleLabel!.text!.components(separatedBy: "-").last
        self.lbDetailTitle.text = "JAN - DEC /\(year!)"
        
        self.currentSelectedRow = Int(sender.tag)
        self.rowDataSelected = self.barDatas[Int(sender.tag)]
        renderBarChart(self.rowDataSelected)
        renderAttribute(self.getDefaultData(), sender.tag)
        sender.alpha = 1;
        
        senderTap = sender
        updateMonthPosition()
        updateBackButton(isDetail)
        
        self.lbTitle.text = labels[sender.tag].uppercased()
        
        self.barTappedUmair(tag: sender.yearTag)
        
    }
    
    func addingBlurView() {
        //Adding blur view
//        self.removeBlurView()
        
        let yPos = 54
        
        let horiView = UIView(frame: CGRect(x: Int(mySrollView.frame.width) - 30, y: yPos , width: 20, height: Int(mySrollView.frame.size.height) - 20))
        horiView.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        let nextImg = UIImageView(frame: CGRect(x: CGFloat(6.5), y: CGFloat((horiView.frame.size.height) - 20)/2 - 5.5, width: 7, height: 11))
        nextImg.image = UIImage(named: "next_arrow_white")
        horiView.tag = 10001
        horiView.addSubview(nextImg)
        scrollViewParent.addSubview(horiView)
        
        let verView = UIView(frame: CGRect(x: Int(posSecondBlock), y: Int(mySrollView.frame.origin.y) + Int(mySrollView.frame.size.height)-20 , width: Int(itemScrollView.frame.size.width), height: 20))
        verView.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        let downImg = UIImageView(frame: CGRect(x: CGFloat(verView.frame.size.width/2 - 5.5), y: 6.5, width: 11, height: 7))
        verView.tag = 10002
        downImg.image = UIImage(named: "down_arrow_white")
        verView.addSubview(downImg)
        scrollViewParent.addSubview(verView)

    }
    
 
    
    func updateBlurView() {
        
        if isDetail {
            for subview in scrollViewParent.subviews {
                if subview.tag == 10001 || subview.tag == 10002 {
//                    subview.removeFromSuperview()
                    subview.alpha = 0
                }
            }
        }
        else {
//            addingBlurView()
            for subview in scrollViewParent.subviews {
                if subview.tag == 10001 || subview.tag == 10002 {
                    //                    subview.removeFromSuperview()
                    subview.alpha = 1
                }
            }
        }
        
    }

    func renderBarChart(_ datas:[MonthData]){
        
        if chartViewScroll == nil {
            chartViewScroll = UIScrollView(frame: CGRect(x: 32, y: Int(monthScrollView.frame.origin.y) , width: Int(mySrollView.frame.width)-64, height: 240))
        }

        var xPos:Float = 0
        var yPos:Float = 0
        let defaultPos:Float = 208

        var realPos :Float = 0
        let _subviews : Array = mySrollView.subviews
        for subview in _subviews{
            subview.removeFromSuperview()
            
        }
        
        let _subviews__ : Array = chartViewScroll.subviews
        for subview in _subviews__{
            subview.removeFromSuperview()
            
        }
        
        resetBarViews()
        barButtons = []
        barViews = []
        
        var endIndex = 0
        if(datas.count > 1)
        {
            endIndex = datas.count-1
            
            for j in 0 ... endIndex{
                let data = datas[j] as MonthData
                
                let per = Float(data.value)
                realPos = (defaultPos * per!)/100
                
                yPos = (defaultPos - realPos)
                
                
                let bar = Bar(frame: CGRect(x: CGFloat(xPos),y: CGFloat (yPos + 32),width: CGFloat(Float(itemWidth) - 0.95), height: CGFloat(realPos)))
                bar.backgroundColor = hexStringToUIColor("#" + data.color)
                bar.tag = j
                let barTap = UITapGestureRecognizer(target: self, action: #selector(self.barTap(_:)))
                bar.addGestureRecognizer(barTap)
                barButtons += [bar]
                
                let barView = UIView(frame: CGRect(x: CGFloat(xPos),y: CGFloat(0),width: CGFloat(Float(itemWidth) - 0.95), height: CGFloat(240)))
                barView.alpha = 1.0
                barView.backgroundColor = UIColor.white
                barView.tag = 600 + j
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.barTap(_:)))
                barView.addGestureRecognizer(tap)
                barViews += [barView]
                
                chartViewScroll.addSubview(barView)
                chartViewScroll.addSubview(bar)
                xPos += Float(itemWidth);
                
            }
            
        }
        
            chartViewScroll.delegate = self
            chartViewScroll.isScrollEnabled = true
            chartViewScroll.contentSize.width = CGFloat(itemWidth) * CGFloat(datas.count)
            mySrollView.addSubview(chartViewScroll)
            mySrollView.contentSize.height = 240
        
    }
    
    func renderAttribute(_ data: MonthData,_ tag: Int) {
        if isDetail {
            attributeView.isHidden = false
            constraintAttributeView.constant = 110
            self.lbPercent.text = String(data.value)
            self.lbGeneral.text = data.general
            self.lbEmergency.text = data.emergency
            self.lbElectivePartients.text = data.elective_patient
            let year = tag < 6 ? btnYear.titleLabel!.text!.components(separatedBy: "-").first : btnYear.titleLabel!.text!.components(separatedBy: " - ").last
            self.lbDetailTitle.text = "\(data.label.uppercased())"
        }
        
    }
    
    func renderYearSelection(){
        
        if yearView == nil {
            
            yearView = UIView()
            
        }
        yearView.backgroundColor = UIColor.white
        yearView.frame = CGRect(x: CGFloat(UIScreen.main.bounds.width/2 - 50), y: btnYear.frame.origin.y + btnYear.frame.size.height + 64, width: 120, height: CGFloat(30*years.count))
        let posY:Int = 30
        yearView.tag = 107
        yearView.isHidden = true
        var viewH:Int = 0
        for i in 0 ... years.count-1{
            
            let label = UILabel(frame: CGRect(x: 0, y: CGFloat(posY*i), width: 120, height: 30))
            label.text = years[i]
            label.font = UIFont(name: FONT_DEFAULT, size: 14)
            label.textColor = hexStringToUIColor("#586166")
            label.textAlignment = NSTextAlignment.center
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.yearSelected(_:)))
            label.addGestureRecognizer(tapGesture)
            
            let clayerTop: CALayer = CALayer()
            clayerTop.frame = CGRect(x: 0, y: 0, width: label.frame.size.width, height: 0.5);
            clayerTop.backgroundColor = hexStringToUIColor("#586166").cgColor
            label.layer.addSublayer(clayerTop)
            viewH += posY*i
            yearView.addSubview(label)
        }
        
        self.view.addSubview(yearView)
    }
    func yearSelected(_ sender: UITapGestureRecognizer){
        
        
        let label = sender.view! as! UILabel
        
        btnYear.setTitle(label.text!, for: UIControlState())
        let yearView = self.view.viewWithTag(107)! as UIView
        UIView.animate(withDuration: 0.2, animations: {
            yearView.isHidden = false
        })
        
        DispatchQueue.main.async {
            
            self.isDetail = false
            self.loadData(label.text!)
        }
        
        
        
    }
    
    func renderSlider(){
        
        for subview in self.view.subviews {
            if subview.tag == 5  {
                subview.removeFromSuperview()
            }
        }

        slideRangeView.frame = CGRect(x: 0, y: 0 ,width: 331, height: 45)
        slideRangeView.tag = 5
        rangeSlider.frame = CGRect(x: 12, y: 29 ,width: CGFloat(Int(300)), height: 31)

        
        slideRangeView.addSubview(rangeSlider)
        
        drawSliderValuable(Int(rangeSlider.lowerValue * 100), Int(rangeSlider.upperValue * 100))
        
        rangeSlider.addTarget(self, action: #selector(self.rangeSliderValueChanged(_:)), for: .valueChanged)
        
        /*
        rangeSlider.layer.cornerRadius = 30//rangeSlider.frame.size.height/2
        rangeSlider.clipsToBounds = true
        rangeSlider.backgroundColor = UIColor.black
        
        slideRangeView.backgroundColor = UIColor.blue
 */
        
        self.rangeSliderView.addSubview(slideRangeView)
        self.rangeSlider.trackHighlightTintColor = UIColor.red
        self.rangeSlider.curvaceousness = 0.0

        
    }
    
    func drawSliderValuable(_ lower: Int,_ upper: Int) {
        
        let lowerXpos: CGFloat = CGFloat(self.rangeSlider.frame.origin.x + 6) + CGFloat(lower) / 100 * 300
        let upperXpos: CGFloat = CGFloat(self.rangeSlider.frame.origin.x + 6) + CGFloat(upper) / 100 * 300
        
        //reset old label
        for subview in slideRangeView.subviews {
            if subview.tag == 1 || subview.tag == 2 || subview.tag == 3 || subview.tag == 4 {
                subview.removeFromSuperview()
            }
        }
        
        labelLower = UILabel()
        labelLower.frame = CGRect(x: lowerXpos - 6 - 4, y: 15 ,width: 12 , height: 14)
        labelLower.text = "\(lower)"
        labelLower.textColor = GRAY_COLOR
        labelLower.font = UIFont(name: FONT_DEFAULT, size: 10)
        labelLower.textAlignment = .center
        labelLower.tag = 1
        slideRangeView.addSubview(labelLower)
        
        labelUpper = UILabel()
        labelUpper.frame = CGRect(x: upperXpos - 10, y: 15 ,width: 12 , height: 14)
        labelUpper.text = "\(upper)"
        labelUpper.font = UIFont(name: FONT_DEFAULT, size: 10)
        labelUpper.textColor = GRAY_COLOR
        labelUpper.textAlignment = .center
        labelUpper.tag = 2
        slideRangeView.addSubview(labelUpper)
        
//        //label
//        let label0 = UILabel()
//        label0.frame = CGRect(x: 0, y: 38 ,width: 18 , height: 14)
//        label0.text = "\(0)"
//        label0.font = UIFont(name: FONT_DEFAULT, size: 10)
//        label0.textColor = LIGHT_GRAY_COLOR
//        label0.textAlignment = .center
//        label0.tag = 3
//        slideRangeView.addSubview(label0)
//        
//        let label100 = UILabel()
//        label100.font = UIFont(name: FONT_DEFAULT, size: 10)
//        label100.frame = CGRect(x: 292, y: 38 ,width: 18 , height: 14)
//        label100.text = "\(100)"
//        label100.textColor = LIGHT_GRAY_COLOR
//        label100.textAlignment = .left
//        label100.tag = 4
//        slideRangeView.addSubview(label100)
        xLower = labelLower.frame.origin.x
        xUpper = labelUpper.frame.origin.x
    }
    
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        filter()
    }

    func filter(){
        let lower = Int((self.rangeSlider.lowerValue)*100)
        let upper = Int(self.rangeSlider.upperValue*100)
    
        for i in 0...self.barDatas.count-1{
            for j in 0...self.barDatas[i].count-1{
                let item:MonthData  = self.barDatas[i][j] as MonthData
                if(Int(Float(item.realValue)!) <= lower){
                    item.color = "CF5647"
                }else if(Int(Float(item.realValue)!) >= upper){
                    item.color = "44AB91"
                }else{
                    item.color = item.originalColor
                }
            }
        }
        if !isDetail {
            self.resetTable()
            self.renderTable(self.labels)
            
        }
        else {
            self.renderBarChart(self.rowDataSelected)
        }
        
        
    }
    
    func filterUmair(noti: Notification)
    {
        
        if(self.barDatas.count > 0)
        {
            
            let userInfor = noti.userInfo as! [String:String]
            
            let lower = Int(userInfor["min"]!)
            let upper = Int(userInfor["max"]!)
            
            
            
            for i in 0...self.barDatas.count-1{
                for j in 0...self.barDatas[i].count-1{
                    let item:MonthData  = self.barDatas[i][j] as MonthData
                    if(Int(Float(item.realValue)!) <= lower!){
                        item.color = "CF5647"
                    }else if(Int(Float(item.realValue)!) >= upper!){
                        item.color = "44AB91"
                    }else{
                        item.color = item.originalColor
                    }
                }
            }
            
            
            if !isDetail {
                self.resetTable()
                self.renderTable(self.labels)
                
            }
            else {
                self.renderBarChart(self.rowDataSelected)
            }
        }
        
        self.tbl_monthBarsTable.reloadData()
        
    }
    
    
    //MARK: Call API
    
    //MARK: BUTTON ACTION
    
    
    @IBAction func backAction(_ sender: Any) {
        
        if isDetail {
            
            self.lbTitle.text = "FLINDERS MEDICAL CENTRE - Theatre Utilisation"
            isDetail = !isDetail
            self.setupLayout()
            updateMonthPosition()
            self.renderTable(self.labels)
            
            // For Months Click
            self.view_monthLabelDetail.isHidden = true
        }
        else {
            
        }
        updateBackButton(isDetail)
        
    }
    
    
    @IBAction func yearTappedAction(_ sender: Any) {
        let yearView = self.view.viewWithTag(107)! as UIView
        UIView.animate(withDuration: 0.2, animations: {
            yearView.isHidden = !yearView.isHidden
            if yearView.isHidden == false {
                
                self.scrollViewParent .setContentOffset(CGPoint.init(x: self.scrollViewParent.contentSize.width - self.scrollViewParent.bounds.size.width, y: 0), animated: true)
                
            }
        })

    }
    func rowTapped(_ sender:BoXButton!){
        isDetail = true
        
        let yearView = self.view.viewWithTag(107)! as UIView
        UIView.animate(withDuration: 0.2, animations: {
            yearView.isHidden = true
        })
        
        
        let year = btnYear.titleLabel!.text!.components(separatedBy: "-").last
        self.lbDetailTitle.text = "JAN - DEC /\(year!)"
        
        self.currentSelectedRow = Int(sender.tag)
        self.rowDataSelected = self.barDatas[Int(sender.tag)]
        renderBarChart(self.rowDataSelected)
        renderAttribute(self.getDefaultData(), sender.tag)
        sender.alpha = 1;
        
        senderTap = sender
        updateMonthPosition()
        updateBackButton(isDetail)
       
        self.lbTitle.text = labels[sender.tag].uppercased()
        
        //self.barTappedUmair(tag: sender.yearTag)
        
    }
    
    func barTappedUmair(tag:Int) -> Void
    {
        var tag = tag
        
        if (tag >= 600) {
            tag = tag - 600
        }
        let data:MonthData = self.rowDataSelected[tag] as MonthData
        
        resetBar(tag)
        resetBarViews()
        resetMonthLabels()
        self.barDataSelected = data
        barViews[tag].backgroundColor = hexStringToUIColor("#F8F8F8").withAlphaComponent(0.7)
        monthLabels[tag].textColor = GRAY_COLOR
        self.lbPercent.textColor = hexStringToUIColor("#\(data.color)")
        self.lbPercentcharacter.textColor = hexStringToUIColor("#\(data.color)")
        renderAttribute(data, tag)
    }
    
    func updateBackButton(_ detail: Bool) {
        if detail {
            btnBack.setImage(UIImage(named: "Back.png"), for: .normal)
            btnYear.alpha = 0
            lbDetailTitle.alpha = 1
        }
        else {
            btnBack.setImage(UIImage(named: "menu_icon.png"), for: .normal)
            btnBack.setTitle("", for: .normal)
            btnYear.alpha = 1
            lbDetailTitle.alpha = 0
            
        }
        updateBlurView()
    }
    
    func barTap(_ sender: UITapGestureRecognizer){
        var tag = sender.view!.tag
        
        if (tag >= 600) {
            tag = sender.view!.tag - 600
        }
        let data:MonthData = self.rowDataSelected[tag] as MonthData
        
        resetBar(tag)
        resetBarViews()
        resetMonthLabels()
        self.barDataSelected = data
        barViews[tag].backgroundColor = hexStringToUIColor("#F8F8F8").withAlphaComponent(0.7)
        monthLabels[tag].textColor = GRAY_COLOR
        self.lbPercent.textColor = hexStringToUIColor("#\(data.color)")
        self.lbPercentcharacter.textColor = hexStringToUIColor("#\(data.color)")
        renderAttribute(data, tag)
        
    }
    
    func getDefaultData() ->MonthData{
        
        let currentOverviewData = self.rowDataSelected[0]
        
        var averageValue = 0
        var totalValue = 0
        
        var averageElectivePatient = 0
        var totalElectivePatient = 0
        
        var averageGeneral = 0
        var totalGeneral = 0
        
        var averageEmergency = 0
        var totalEmergency = 0
        
        var averageDaySurgery = 0
        var totalDaySurgery = 0
        
        var averageTotalElectiveEmergency = 0
        var totalTotalElectiveEmergency = 0
        let averageLabel = self.rowDataSelected[0].label + " - " + self.rowDataSelected[self.rowDataSelected.count-1].label
        for i in 0...self.rowDataSelected.count-1{
            
            let item = self.rowDataSelected[i] as MonthData
            totalValue += Int(Float(item.realValue)!)
            
            totalElectivePatient += Int(item.elective_patient)!
            totalGeneral += Int(item.general)!
            
            totalEmergency += Int(item.emergency)!
            
            totalDaySurgery += Int(item.day_surgery)!
            
            totalTotalElectiveEmergency += Int(item.total_elective_emergency)!
            
        }
        averageValue = totalValue/self.rowDataSelected.count
        averageElectivePatient = totalElectivePatient/self.rowDataSelected.count
        averageGeneral = totalGeneral/self.rowDataSelected.count
        averageEmergency = totalEmergency/self.rowDataSelected.count
        averageDaySurgery = totalDaySurgery/self.rowDataSelected.count
        averageTotalElectiveEmergency = totalTotalElectiveEmergency/self.rowDataSelected.count
        
        self.lbPercent.textColor = hexStringToUIColor("#\(self.setHexColor(averageValue))")
        self.lbPercentcharacter.textColor = hexStringToUIColor("#\(self.setHexColor(averageValue))")
        
        let defaultData:MonthData = MonthData(order:0, label: averageLabel, value: String(averageValue), color:currentOverviewData.color, elective_patient:String(averageElectivePatient), general:String(averageGeneral), emergency:String(averageEmergency), day_surgery:String(averageDaySurgery), total_elective_emergency:String(averageTotalElectiveEmergency), real_value:String(averageValue))
        
        return defaultData
        
    }

    
    //MARK: RESET
    func resetBarViews(){
        if(barViews.count != 0){
            for i in 0...barViews.count-1{
                barViews[i].backgroundColor = UIColor.white
            }
        }
    }
    
    func resetBar(_ tag: Int) {
        if(barButtons.count != 0){
            for i in 0...barButtons.count-1{
                if tag != i {
                    barButtons[i].backgroundColor = hexStringToUIColor("#" + (self.rowDataSelected[i] ).color).withAlphaComponent(0.3)
                }
                else {
                    barButtons[i].backgroundColor = hexStringToUIColor("#" + (self.rowDataSelected[i] ).color).withAlphaComponent(1.0)

                }
            }
        }
    }
    
    func resetMonthLabels(){
        if(monthLabels.count != 0){
            for i in 0...monthLabels.count-1{
                monthLabels[i].textColor = LIGHT_GRAY_COLOR
            }
        }
    }
    
    
    func resetTable(){
        if(self.rowDataSelected.count != 0 && self.currentSelectedRow != -1){
            for (_, button) in labelButtons.enumerated() {
                button.alpha = 0.3
                button.setTitleColor(hexStringToUIColor("#6D6C6C"), for: UIControlState())
            }
            for (_, button) in rowButtons.enumerated() {
                button.alpha = 0.3
            }
            self.labelButtons[self.currentSelectedRow].alpha = 1
            let rowView: UIView = rowViews[self.currentSelectedRow]
            for view in rowView.subviews as [UIView]{
                if let btn = view as? UIButton{
                    btn.alpha = 1
                }
            }
        }
    }

    
    //MARK: UPDATE VIEW
    func updateMonthPosition() {
        if isDetail {
            monthScrollLeadingConstraint.constant = 32
            monthTrailingConstraint.constant = 32
            myScrollViewTopConstraint.constant = -(monthScrollView.frame.size.height + 15)
        }
        else {
            monthScrollLeadingConstraint.constant = CGFloat(posSecondBlock)
            monthTrailingConstraint.constant = 10
            myScrollViewTopConstraint.constant = 8
        }
    }
    
    //MARK: ScrollView delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == monthScrollView {
            itemScrollView.contentOffset.x = scrollView.contentOffset.x
        }
        if scrollView == itemScrollView {
            monthScrollView.contentOffset.x = scrollView.contentOffset.x
        }
        
        
        if chartViewScroll != nil && scrollView == chartViewScroll {
            monthScrollView.contentOffset.x = scrollView.contentOffset.x
        }
        
        
        if isDetail == false {
            
            print(scrollView.contentOffset.x)
            
            if scrollView.contentOffset.x > 350 {
                for subview in scrollViewParent.subviews {
                    if subview.tag == 10001  {
                        //                    subview.removeFromSuperview()
                        // 0900 
                        subview.alpha = 0
                    }
                    
                }
            }
            else {
                for subview in scrollViewParent.subviews {
                    if subview.tag == 10001  {
                        //                    subview.removeFromSuperview()
                        subview.alpha = 1
                    }
                    
                }
            }
            print(scrollView.contentOffset.y)
            if  scrollView.contentOffset.y > 650 {
                
                for subview in scrollViewParent.subviews {
                    if subview.tag == 10002  {
                        
                        // 0900 
                        subview.alpha = 0
                    }
                }
            }
            else {
                for subview in scrollViewParent.subviews {
                    if subview.tag == 10002  {
                        //                    subview.removeFromSuperview()
                        subview.alpha = 1
                    }
                    
                }
            }

        }
        
       
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print(itemScrollView.contentOffset.y)

    }

    func setHexColor(_ value: Int) -> String{
        switch value {
        case 0...10:
            return "CF5647"
        case 11...20:
            return "D36C48"
        case 21...30:
            return "DA844B"
        case 31...40:
            return "DF9E4E"
        case 41...50:
            return "E6B84F"
        case 51...60:
            return "D6C257"
        case 61...70:
            return "B1BA64"
        case 71...80:
            return "8BB672"
        case 81...90:
            return "66B182"
        case 91...100:
            return "44AB91"
        default:
            return "000000"
        }
    }
    
    //MARK: UITableView Delegates
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let returnValue = self.labels.count
        return returnValue
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonthDetailCell", for: indexPath) as! MonthDetailCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.view_barViewMonths.setNeedsDisplay()
        cell.lbl_catName.text = labels[indexPath.row]
        cell.view_barViewMonths.arrayIndex = indexPath.row
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let returnValue:CGFloat = 52.0
        return returnValue
    }
    

}
