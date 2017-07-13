//
//  HomeVC.swift
//  OAK
//
//  Created by MobileDev on 9/8/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class HomeVC: UIViewController, UIScrollViewDelegate {
    
    //MARK: VAR
    @IBOutlet weak var scrollViewParent: UIScrollView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var line3: UIImageView!
    @IBOutlet weak var btnRightIcon: UIButton!
    @IBOutlet var headerView: [UIView]!
    @IBOutlet weak var mySrollView: UIScrollView!
    @IBOutlet weak var btnFullName: UIButton!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var chartScrollView: UIScrollView!
    @IBOutlet weak var attributeScrollView: UIScrollView!
    @IBOutlet var info1View: [UIView]!
    @IBOutlet weak var monthTitle: UILabel!
    @IBOutlet weak var rowTitle: UILabel!
    @IBOutlet weak var rowPercent: UILabel!
    @IBOutlet weak var btnHeaderYear: UIButton!
    @IBOutlet weak var btnHeaderRightIcon: UIButton!
    var slideRangeView = UIView()
    @IBOutlet weak var imgViewUp: UIImageView!
    @IBOutlet weak var imgViewDown: UIImageView!
    //FIXME
    var itemScrollView: UIScrollView!
    var monthScrollView: UIScrollView!
    var chartItemScrollView: UIScrollView!
    @IBOutlet weak var lbNameTitle: UILabel!
    @IBOutlet weak var imgXPositionConstraint: NSLayoutConstraint!
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
    var tableY:CGFloat = 154 - 86
    var tableHeight:CGFloat = 400
    var posFirstBlock:Float = 64
    var posSecondBlock:Float = 242
    var columnWidth = 58
    var columnWidth_potrait = 79
    var chartLabelX = 281
    var yearBtnX = 860
    var percentInfoViewX = 64
    var headerTextX = 380
    var yearSelectionX = 846
    var apiKey:String = ""
    var avatar:String = ""
    var fullname:String = ""
    var avatarImageView:UIImageView = UIImageView()
    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView!
    let rangeSlider = RangeSlider(frame: CGRect.zero)
    var isDetail = false
    let chartLabelView = UIView()
    @IBOutlet weak var headerConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollParentConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    var senderTap: UIButton! = nil
    var yearView:UIView!
    var isFromHome = true
    @IBOutlet weak var bottomControllConstraint: NSLayoutConstraint!
    @IBOutlet weak var LeftAttributeContraint: NSLayoutConstraint!
    @IBOutlet weak var widthAttributeConstraint: NSLayoutConstraint!
    @IBOutlet weak var topParentScrollViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var contraintTopSlide: NSLayoutConstraint!
    var orientations:UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
    @IBOutlet weak var nextImage: UIImageView!
    var labelLower: UILabel!
    var labelUpper: UILabel!
    var xLower: CGFloat!
    var xUpper: CGFloat!
    
    //MARK: SELF
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if prefs.object(forKey: "API_KEY") != nil {
            
            apiKey = (prefs.object(forKey: "API_KEY") as? String)!

        }
        if prefs.object(forKey: "AVATAR") != nil {
            
            avatar = (prefs.object(forKey: "AVATAR") as? String)!

        }
        
        if prefs.object(forKey: "FULLNAME") != nil {
            
            fullname = (prefs.object(forKey: "FULLNAME") as? String)!

        }
        
        DispatchQueue.global().async {
            self.loadData(self.years[self.years.count-1])
            DispatchQueue.main.async {
                self.renderProfile()
                self.setupLayout()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.updateLower(_:)), name: NSNotification.Name("UPDATE_LOWER"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.updateUpper(_:)), name: NSNotification.Name("UPDATE_UPPER"), object: nil)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = btnRightIcon.frame
        rectShape.position = btnRightIcon.center
        rectShape.path = UIBezierPath(roundedRect: btnRightIcon.bounds, byRoundingCorners: [UIRectCorner.topLeft , UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        btnRightIcon.layer.mask = rectShape
        btnHeaderRightIcon.layer.mask = rectShape
        btnYear.setTitle(years[years.count-1], for: UIControlState())
        btnFullName.setTitle(fullname, for: UIControlState())
        
        
        updateDetailView()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        avatarImageView .sd_setImage(with: (NSURL(string: avatar) as! URL), placeholderImage: UIImage(named: ""))
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.view.layoutIfNeeded()
        
        if IS_IPAD_PRO && orientations != .portrait {
            scrollViewParent.frame.origin.x =  UIScreen.main.bounds.width/2 - 512
            
            
        }
        else {
            imgXPositionConstraint.constant = 0
        }
        
        if isDetail {
            imgXPositionConstraint.constant = scrollViewParent.frame.origin.x + 134
        }
        
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
                orientations = orientation
                self.headerConstraint.constant = 87
                self.btnYear.isHidden = true
                self.profileTrailingConstraint.priority = 110
                self.bottomLeadingConstraint.priority = 80
                self.btnRightIcon.isHidden = true
                btnHeaderYear.isHidden = false
                self.nextImage.isHidden = false
                posSecondBlock = 242
                bottomControllConstraint.constant = 8
                widthAttributeConstraint.constant = 193
                btnHeaderRightIcon.isHidden = false
                
                self.contraintTopSlide.constant = 105
                
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
                self.headerConstraint.constant = 60
                self.btnYear.isHidden = false
                self.bottomLeadingConstraint.priority = 95
                self.profileTrailingConstraint.priority = 90
                self.btnRightIcon.isHidden = false
                self.nextImage.isHidden = true
                btnHeaderYear.isHidden = true
                posSecondBlock = 264
                btnHeaderRightIcon.isHidden = true
                bottomControllConstraint.constant = 28
                widthAttributeConstraint.constant = 215
                
                self.contraintTopSlide.constant = 48
                
            }
            else {
                return
            }
        }
        
        
        
        self.renderTable(self.labels)
        
        self.renderMonth(self.months[0])
        self.updateYearView()
        
        if (self.senderTap != nil) {
            self.rowTapped(self.senderTap)
        }
        self.renderProfile()
        updateSliderFrame()
    }
    
    func setupLayout() {
        
        SCREEN_WIDTH = UIScreen.main.bounds.width
        SCREEN_HEIGHT = UIScreen.main.bounds.height
        if(orientations == .portrait) {
            self.headerConstraint.constant = 87
            self.btnYear.isHidden = true
            self.profileTrailingConstraint.priority = 110
            self.bottomLeadingConstraint.priority = 80
            self.btnRightIcon.isHidden = true
            btnHeaderYear.isHidden = false
            self.nextImage.isHidden = false
            posSecondBlock = 242
            bottomControllConstraint.constant = 8
            widthAttributeConstraint.constant = 193
            btnHeaderRightIcon.isHidden = false
            
            self.contraintTopSlide.constant = 105
            
            
        }
        else {
            
            self.headerConstraint.constant = 60
            self.btnYear.isHidden = false
            self.bottomLeadingConstraint.priority = 95
            self.profileTrailingConstraint.priority = 90
            self.btnRightIcon.isHidden = false
            self.nextImage.isHidden = true
            btnHeaderYear.isHidden = true
            posSecondBlock = 264
            btnHeaderRightIcon.isHidden = true
            bottomControllConstraint.constant = 28
            widthAttributeConstraint.constant = 215
            
            self.contraintTopSlide.constant = 48
            
            
            
        }
        updateSliderFrame()
    }
    
    //MARK: UI RENDER
    func renderProfile(){
        
        if self.view.viewWithTag(106) != nil {
            self.view.viewWithTag(106)?.removeFromSuperview()
        }
        
        let image:UIImage = UIImage(named: "photo")!
        var xPos: CGFloat = UIScreen.main.bounds.width
        
        let profileView = UIView(frame:CGRect(x: xPos,y: 87,width: CGFloat(300), height: CGFloat(self.scrollViewParent.bounds.height)))
        profileView.tag = 106
        profileView.backgroundColor = hexStringToUIColor("#AAA6A4")
        
        let photoView = UIImageView(frame: CGRect(x: profileView.frame.width/2 - 50, y: 50, width: 100, height: 100))
        photoView.image = image
        photoView.tag = 200
        photoView.layer.masksToBounds = false
        photoView.layer.cornerRadius = photoView.frame.size.width/2
        photoView.clipsToBounds = true
        avatarImageView = photoView
        
        let nameLabel = UILabel(frame: CGRect(x: profileView.frame.width/2 - 50, y: 170, width: 100, height: 20))
        nameLabel.text = fullname
        nameLabel.font = UIFont(name: FONT_DEFAULT, size: 11)
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = NSTextAlignment.center
        let line1 = UIView(frame: CGRect(x: profileView.frame.width/2 - 70, y: 210, width: 150, height: 0.3))
        line1.backgroundColor = UIColor.white
        line1.alpha = 0.5
        
        let note1Label = UILabel(frame: CGRect(x: profileView.frame.width/2 - 50, y: 230, width: 100, height: 20))
        note1Label.text = "CASES SUBMITTED"
        note1Label.font = UIFont(name: FONT_DEFAULT, size: 11)
        note1Label.textColor = UIColor.white
        note1Label.textAlignment = NSTextAlignment.center
        
        let number1Label = UILabel(frame: CGRect(x: profileView.frame.width/2 - 50, y: 250, width: 100, height: 20))
        number1Label.text = "212"
        number1Label.font = UIFont(name: FONT_DEFAULT, size: 11)
        number1Label.textColor = UIColor.white
        number1Label.textAlignment = NSTextAlignment.center
        
        let line2 = UIView(frame: CGRect(x: profileView.frame.width/2 - 70, y: 300, width: 150, height: 0.3))
        line2.backgroundColor = UIColor.white
        line2.alpha = 0.5
        
        let note2Label = UILabel(frame: CGRect(x: profileView.frame.width/2 - 50, y: 340, width: 100, height: 20))
        note2Label.text = "SUBCRIPTIONS"
        note2Label.font = UIFont(name: FONT_DEFAULT, size: 11)
        note2Label.textColor = UIColor.white
        note2Label.textAlignment = NSTextAlignment.center
        
        let number2Label = UILabel(frame: CGRect(x: profileView.frame.width/2 - 50, y: 360, width: 100, height: 20))
        number2Label.text = "3 of 30"
        number2Label.font = UIFont(name: FONT_DEFAULT, size: 11)
        number2Label.textColor = UIColor.white
        number2Label.textAlignment = NSTextAlignment.center
        
        profileView.addSubview(photoView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(line1)
        profileView.addSubview(note1Label)
        profileView.addSubview(note2Label)
        profileView.addSubview(line2)
        
        profileView.addSubview(number1Label)
        profileView.addSubview(number2Label)
        
        self.view.addSubview(profileView)
        
    }
    func renderYearSelection(){
        if yearView == nil {
            
            yearView = UIView()
            
        }
        yearView.backgroundColor = hexStringToUIColor("#AAA6A4")
        
        let posY:Int = 20
        yearView.tag = 107
        yearView.isHidden = true
        var viewH:Int = 0
        for i in 0 ... years.count-1{
            
            let label = UILabel(frame: CGRect(x: 0, y: CGFloat(posY*i), width: 100, height: 20))
            label.text = years[i]
            label.font = UIFont(name: FONT_DEFAULT, size: 11)
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeVC.yearSelected(_:)))
            label.addGestureRecognizer(tapGesture)
            
            let clayerTop: CALayer = CALayer()
            clayerTop.frame = CGRect(x: 0, y: 0, width: label.frame.size.width, height: 0.5);
            clayerTop.backgroundColor = UIColor.white.cgColor
            label.layer.addSublayer(clayerTop)
            viewH += posY*i
            yearView.addSubview(label)
        }
        self.updateYearView()
        self.view.addSubview(yearView)
    }
    
    
    func renderSlider(){
        
        for subview in self.view.subviews {
            if subview.tag == 5  {
                subview.removeFromSuperview()
            }
        }
        
        slideRangeView = UIView(frame: self.updateSliderFrame())
        slideRangeView.tag = 5
        rangeSlider.frame = CGRect(x: 12, y: 29 ,width: CGFloat(Int(510)), height: 31)
        
        slideRangeView.addSubview(rangeSlider)
        
        drawSliderValuable(Int(rangeSlider.lowerValue * 100), Int(rangeSlider.upperValue * 100))
        
        rangeSlider.addTarget(self, action: #selector(HomeVC.rangeSliderValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(slideRangeView)
        self.rangeSlider.trackHighlightTintColor = UIColor.red
        self.rangeSlider.curvaceousness = 0.0
        
    }
    func renderMonth(_ labels:[String]){
        let labelWidth:Int = orientations == .portrait ? columnWidth_potrait : columnWidth
        var viewFrame = CGRect(x: 0, y: 0, width: labelWidth, height: 30)
        
        let _subviews : Array = scrollViewParent.subviews
        for subview in _subviews{
            if( subview is UIScrollView && subview.tag == 900){
                subview.removeFromSuperview()
            }
        }
        //        var y = 15;
        //        if isDetail && orientations != .portrait && orientations != .portraitUpsideDown {
        //            y = 0
        //        }
        //        else {
        //            y = 15
        //        }
        monthScrollView = UIScrollView(frame: CGRect(x: Int(posSecondBlock),y: 15, width:Int(mySrollView.frame.width) - Int(posSecondBlock) , height: 30))
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
            viewFrame.origin.x = CGFloat(labelWidth*j)
            label.frame = viewFrame
            label.tag = 400 + j
            label.text = labels[j]
            label.textAlignment = NSTextAlignment.center
            label.textColor = GRAY_COLOR
            label.font = UIFont(name: FONT_DEFAULT, size: 11)
            
            monthLabels += [label]
            
            monthScrollView.addSubview(label)
            
        }
        monthScrollView.contentSize.width = CGFloat(labelWidth) * CGFloat(labels.count)
        scrollViewParent.addSubview(monthScrollView)
        
    }
    func renderBarChart(_ datas:[MonthData]){
        
        var xPos:Float = 0
        var yPos:Float = 0
        let defaultPos:Float = 180
        let barWidth:Float = orientations == .portrait ? 79 : 58
        var realPos :Float = 0
        let _subviews : Array = chartScrollView.subviews
        for subview in _subviews{
            if( subview is Bar || subview.tag >= 600){
                subview.removeFromSuperview()
            }
        }
        
        resetBarViews()
        barButtons = []
        barViews = []
        for j in 0 ... datas.count-1{
            let data = datas[j] as MonthData
            
            let per = Float(data.value)
            realPos = (defaultPos * per!)/100
            
            yPos = (defaultPos - realPos) + Float(56)
            
            
            let bar = Bar(frame: CGRect(x: CGFloat(xPos),y: CGFloat (yPos),width: CGFloat(barWidth-Float(0.95)), height: CGFloat(realPos)))
            bar.backgroundColor = hexStringToUIColor("#" + data.color)
            bar.tag = j
            let barTap = UITapGestureRecognizer(target: self, action: #selector(HomeVC.barTap(_:)))
            bar.addGestureRecognizer(barTap)
            barButtons += [bar]
            
            let barView = UIView(frame: CGRect(x: CGFloat(xPos),y: CGFloat(0),width: CGFloat(barWidth-Float(0.95)), height: CGFloat(240)))
            //            barView.isUserInteractionEnabled = true
            //            barView.backgroundColor = hexStringToUIColor("#F8F8F8")
            barView.alpha = 1.0
            barView.backgroundColor = UIColor.white
            barView.tag = 600 + j
            let tap = UITapGestureRecognizer(target: self, action: #selector(HomeVC.barTap(_:)))
            barView.addGestureRecognizer(tap)
            barViews += [barView]
            
            chartScrollView.addSubview(barView)
            chartScrollView.addSubview(bar)
            xPos += barWidth;
            
        }
        if(orientations == .portrait) {
            chartScrollView.delegate = self
            chartScrollView.isScrollEnabled = true
            chartScrollView.contentSize.width = CGFloat(barWidth) * CGFloat(datas.count)
        }
        else {
            chartScrollView.isScrollEnabled = false
            chartScrollView.contentSize.width = chartScrollView.frame.width
        }
        selectBarItem()
        
    }
    
    func renderChartLabels(){
        
        chartLabelView.frame = CGRect(x: CGFloat(chartLabelX),y: 30,width: CGFloat(22), height: CGFloat(260))
        
        chartLabelView.tag = 108
        let label100 = UILabel(frame:CGRect(x: 0,y: 30,width: 22, height: 15))
        label100.text = "100"
        label100.font = UIFont(name: FONT_DEFAULT, size: 11)
        label100.textColor = hexStringToUIColor("#B4B4B4")
        label100.textAlignment = NSTextAlignment.center
        
        let label50 = UILabel(frame:CGRect(x: 0,y: 240/2+10,width: 22, height: 15))
        label50.text = "50"
        label50.font = UIFont(name: FONT_DEFAULT, size: 11)
        label50.textColor = hexStringToUIColor("#B4B4B4")
        label50.textAlignment = NSTextAlignment.center
        
        let label0 = UILabel(frame:CGRect(x: 0,y: 260 - 30,width: 22, height: 15))
        label0.text = "0"
        label0.font = UIFont(name: FONT_DEFAULT, size: 11)
        label0.textColor = hexStringToUIColor("#B4B4B4")
        label0.textAlignment = NSTextAlignment.center
        
        chartLabelView.addSubview(label100)
        chartLabelView.addSubview(label50)
        chartLabelView.addSubview(label0)
        
        chartLabelView.alpha = 0
        chartLabelView.isHidden = true
        scrollViewParent.addSubview(chartLabelView)
    }
    
    func renderAttributes(_ data:MonthData){
        
        let xPos = orientations == .portrait ? 0 : 15
        let xNumbPos = orientations == .portrait ? 167 : 183
        
        widthAttributeConstraint.constant = orientations == .portrait ? 193 : 215
        
        var viewFrame = CGRect(x: xPos, y: 0, width: 130, height: 15)
        var viewNumFrame = CGRect(x: xNumbPos, y: 0, width: 25, height: 15)
        var aScrollViewContentSize:CGFloat = 0
        let theSubviews : Array = attributeScrollView.subviews
        for subview in theSubviews{
            if( subview is UILabel){
                subview.removeFromSuperview()
            }
        }
        for j in 0...attributes.count-1{
            let label = UILabel()
            viewFrame.origin.y = CGFloat(15*j)
            label.frame = viewFrame
            label.textColor = GRAY_COLOR
            label.text = attributes[j];
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: FONT_DEFAULT, size: 11)
            let labelNum = UILabel()
            viewNumFrame.origin.y = CGFloat(15*j)
            labelNum.frame = viewNumFrame
            if(attributeFields[j] == "elective_patient"){
                labelNum.text = String(data.elective_patient)
            }else if(attributeFields[j] == "general"){
                labelNum.text = String(data.general)
            }else if(attributeFields[j] == "emergency"){
                labelNum.text = String(data.emergency)
            }else if(attributeFields[j] == "day_surgery"){
                labelNum.text = String(data.day_surgery)
            }else if(attributeFields[j] == "total_elective_emergency"){
                labelNum.text = String(data.total_elective_emergency)
            }
            labelNum.textColor = hexStringToUIColor("#DB675B")
            labelNum.textAlignment = NSTextAlignment.right
            labelNum.font = UIFont(name: FONT_DEFAULT, size: 11)
            
            attributeScrollView.addSubview(label)
            attributeScrollView.addSubview(labelNum)
            
            
            aScrollViewContentSize += CGFloat(15)
            
        }
        attributeScrollView.contentSize = CGSize(width: 120, height: aScrollViewContentSize)
        monthTitle.text = String(data.label)
        rowPercent.text = String(data.value) + "%"
        
    }
    
    func renderTable(_ labels: [String]){
        let screenWidth:FloatLiteralType = FloatLiteralType(800)
        let itemHeight:Int = orientations == .portrait ? 40 : 32
        let buttonWidth:Int = orientations == .portrait ? 79 : 58
        let buttonHeight = orientations == .portrait ? 40 : 32
        var yPos:Int = 0
        let view1Width:Int = orientations == .portrait ? 220 : 248
        var view2Frame: CGRect!
        
        var view1Frame = CGRect(x: 0, y: 0, width: view1Width, height: itemHeight)
        var borderFrame = CGRect(x: 0, y: 0, width: view1Width, height: Int(0.5))
        
        if(orientations == .portrait || orientations == .portraitUpsideDown) {
            view2Frame = CGRect(x: 0, y: 0, width: Int(screenWidth-5), height: itemHeight)
        }
        else {
            view2Frame = CGRect(x: Int(posSecondBlock), y: 0, width: Int(screenWidth), height: itemHeight)
        }
        
        var scrollViewContentSize:CGFloat = 0
        var buttonFrame = CGRect(x: Int(0.5), y: 0, width: buttonWidth, height: buttonHeight)
        
        let theSubviews : Array = mySrollView.subviews
        for subview in theSubviews{
            if( subview is UIButton || subview is UIView || subview is UIImageView){
                subview.removeFromSuperview()
            }
        }
        self.rowButtons = []
        self.labelButtons = []
        self.rowViews = []
        itemScrollView = UIScrollView(frame: CGRect(x: Int(posSecondBlock), y: 0, width: Int(mySrollView.frame.width) - Int(posSecondBlock) + Int(posFirstBlock),height: itemHeight * labels.count))
        itemScrollView.indicatorStyle = .white
        itemScrollView.delegate = self
        for i in 0 ... labels.count-1{
            
            let view1 = UIButton()
            view1.setTitle(labels[i].uppercased(), for: UIControlState())
            view1.setTitleColor(hexStringToUIColor("#6D6C6C"), for: UIControlState())
            view1.titleLabel?.font = UIFont(name: FONT_DEFAULT, size: 11)
            view1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            view1.tag = i
            labelButtons += [view1]
            
            let line = UIView()
            line.backgroundColor = LIGHT_COLOR
            
            
            let view2 = UIView()
            view2.tag = i
            
            for j in 0 ... self.barDatas[i].count-1{
                let item:MonthData = self.barDatas[i][j]
                let button  = UIButton()
                buttonFrame.origin.x = CGFloat(j*buttonWidth)
                button.backgroundColor = hexStringToUIColor("#" + item.color)
                button.layer.borderWidth = 0.25
                button.layer.borderColor = UIColor.white.cgColor
                
                button.frame = buttonFrame
                button.alpha = 1
                button.tag = j
                rowButtons += [button]
                view2.addSubview(button)
                
                //                if button.tag == senderTap.tag {
                //                    button.alpha = 1
                //                }
                
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
            if(orientations == .portrait) {
                itemScrollView.addSubview(view2)
            }
            else {
                mySrollView.addSubview(view2)
            }
            mySrollView.addSubview(line)
            
            view1.addTarget(self, action: #selector(HomeVC.rowTapped(_:)), for: UIControlEvents.touchUpInside)
            
            yPos += itemHeight
            
            scrollViewContentSize += CGFloat(itemHeight)
            
            
        }
        
        mySrollView.contentSize.height =  scrollViewContentSize
        if(orientations == .portrait) {
            mySrollView.addSubview(itemScrollView)
            itemScrollView.contentSize.width = CGFloat(buttonWidth * 13)
        }
        
        //        renderSlider()
    }
    
    
    //MARK: UPDATE UI
    
    func updateDetailView() {
        
        if isDetail {
            self.topView.alpha = 1.0
            self.topView.isHidden = false
            self.topViewHeightConstraint.constant = 240
            scrollViewParent.viewWithTag(108)?.isHidden = false
            scrollViewParent.viewWithTag(108)?.alpha = 1.0
            self.imgViewUp.isHidden = false
            self.imgViewDown.isHidden = false
            self.lbNameTitle.textColor = LIGHT_GRAY_COLOR
        }
        else {
            self.topView.alpha = 0
            self.topView.isHidden = true
            self.topViewHeightConstraint.constant = 1
            scrollViewParent.viewWithTag(108)?.isHidden = true
            scrollViewParent.viewWithTag(108)?.alpha = 0
            self.imgViewUp.isHidden = true
            self.imgViewDown.isHidden = true
            self.lbNameTitle.textColor = GRAY_COLOR
            
        }
        
        updateSliderFrame()
    }
    
    func updateMonthPosition() {
        
        if isDetail {
            monthScrollView.frame = CGRect(x: Int(posSecondBlock),y: 35, width:Int(mySrollView.frame.width) - Int(posSecondBlock) , height: 30)
        }
        else {
            monthScrollView.frame = CGRect(x: Int(posSecondBlock),y: 15, width:Int(mySrollView.frame.width) - Int(posSecondBlock) , height: 30)
            
        }
    }
    
    func roundTo(value: Double,places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (value * divisor).rounded() / divisor
    }
    
    func updateSliderFrame() -> CGRect {
        
        var margin: CGFloat = orientations == .portrait ? 152 : 346
        
        //Update landscape and portrait
        var yPos:CGFloat = orientations == .portrait ? 883 : 673
        
        //case ipad pro
        if IS_IPAD_PRO {
            margin = UIScreen.main.bounds.width/2 - 255
            
            yPos = orientations == .portrait ? UIScreen.main.bounds.height - 156 : UIScreen.main.bounds.height - 97
        }
        
        
        slideRangeView.frame = CGRect(x: margin, y: yPos ,width: 541, height: 45)
        
        return slideRangeView.frame
    }

    func updateLower(_ noti: Notification) {
        
        
        let value = noti.userInfo?["value"] as! Double
//        
//        let value_ = self .roundTo(value: value, places: 2)  // x becomes 0.1235 under Swift 2
//        
//        var space: CGFloat = 0
//        
//       
//
//        if value_ < 0.25 {
//            
//            space = self.rangeSlider.frame.origin.x - CGFloat(value_ * 12) * 2
//        }else if value_ < 0.5 {
//            
//            space = self.rangeSlider.frame.origin.x - CGFloat(value_ * 12) - 6
//
//        }else if value_ < 0.75 {
//        
//            space = self.rangeSlider.frame.origin.x - CGFloat(value_ * 20) - 6
//
//        }else {
//            
//            space = self.rangeSlider.frame.origin.x - CGFloat(value_ * 23) - 6
//
//        }
        
        labelLower.frame.origin.x = (rangeSlider.lowerThumbLayer.frame.origin.x + 12)
//        print("\(CGFloat(value_ * 6))" + "\(self.rangeSlider.frame.origin.x) :" + "\(value_) :" + "\(labelLower.frame.origin.x)")
        labelLower.text = "\(Int(round(rangeSlider.lowerThumbLayer.frame.origin.x + 6)/510*100))"
        
    }
    
    func updateUpper(_ noti: Notification) {
        let value = noti.userInfo?["value"] as! Double
        let value_ = self .roundTo(value: value, places: 2)  // x becomes 0.1235 under Swift 2
        
//        var space: CGFloat = 0
//        
//        if value_ == 1 {
//            
//            space = self.rangeSlider.frame.origin.x - 20
//        }
//        else if value_ > 0.9 {
//            
//            space = self.rangeSlider.frame.origin.x - CGFloat(value_ * 6) - 6
//        }
//        else if value_ > 0.75 {
//            
//            space = self.rangeSlider.frame.origin.x - CGFloat(value_ * 3) - 6
//        }else if value_ > 0.6 {
//            
//            space = self.rangeSlider.frame.origin.x - CGFloat(value_ * 2)
//            
//        }
//        else if value_ > 0.5 {
//            
//            space = self.rangeSlider.frame.origin.x + CGFloat(value_ * 2) + 1
//            
//        }
//        else if value_ > 0.4 {
//            
//            space = self.rangeSlider.frame.origin.x + CGFloat(value_ * 2) + 3
//            
//        }else if value_ > 0.3 {
//            
//            space = self.rangeSlider.frame.origin.x + CGFloat(value_ * 2) + 8
//            
//        }
//        else if value_ > 0.25 {
//            
//            space = self.rangeSlider.frame.origin.x + CGFloat(value_ * 2) + 8
//            
//        }
//        else if value_ > 0.15 {
//            
//            space = self.rangeSlider.frame.origin.x + CGFloat(value_ * 2) + 10
//            
//        }else if value_ > 0.10 {
//            
//            space = self.rangeSlider.frame.origin.x + CGFloat(value_ * 2) + 14
//            
//        }else {
//            
//            space = self.rangeSlider.frame.origin.x + CGFloat(value_ * 2) + 15
//            
//        }
        
        labelUpper.frame.origin.x = rangeSlider.upperThumbLayer.frame.origin.x + 12
        print("\(self.rangeSlider.frame.origin.x) :" + "\(value_) :" + "\(labelLower.frame.origin.x)")
        
        labelUpper.text = "\(Int(round(rangeSlider.upperThumbLayer.frame.origin.x + 6)/510*100))"
        
    }
    
    func updateYearView() {
        var viewFrame: CGRect
        if(orientations == .landscapeLeft || orientations == .landscapeRight) {
            viewFrame = CGRect(x: CGFloat(UIScreen.main.bounds.width - 20 - 100 - 32), y: 125, width: 100, height: CGFloat(20*years.count))
        }
        else {
            viewFrame = CGRect(x: CGFloat(UIScreen.main.bounds.width/2 - 50), y: 174, width: 100, height: CGFloat(20*years.count))
        }
        yearView.frame  = viewFrame
    }

    
    func reset(){
        self.months = [[String]]()
        self.barDatas = [[MonthData]]()
        self.rowDataSelected = [MonthData]()
        self.barDataSelected = MonthData(order: -1, label: "", value: "", color: "", elective_patient: "", general: "", emergency: "", day_surgery: "", total_elective_emergency: "", real_value: "")
        self.labels = []
        self.currentSelectedRow = -1
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
            
//            print("RESULT" + "%@",responseObject as Any)
            
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
        //print(data)
        var swiftDict : Dictionary<String,AnyObject?> = Dictionary<String,AnyObject!>()
        var colors = [[UIColor]]()
        for (key,_) in data {
            
            let stringKey = key as! String
            if let keyValue = data.value(forKey: stringKey){
                swiftDict[stringKey] = keyValue as AnyObject??
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
        self.rowDataSelected = self.barDatas[0]
        renderTable(labels)
        renderBarChart(self.barDatas[0])
        renderMonth(self.months[0])
        renderYearSelection();
        renderSlider()
        self.rangeSlider.reset()
        self.rangeSlider.isHidden = false
        
    }
    
    func filter(){
        let lower = Int(self.rangeSlider.lowerValue*100)
        let upper = Int(self.rangeSlider.upperValue*100)
        
        //
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
        self.renderTable(self.labels)
        self.renderBarChart(self.rowDataSelected)
        self.resetTable()
        
    }

    
    //MARK: TAPED ACTION
    
    
    
    func rowTapped(_ sender:UIButton!){
        isDetail = true
        
        
        if(isDetail){
            
            var number = 0
            if orientations.isLandscape {
                
                number = 6
            }else {
                
                number = 6
            }
            
            if(sender.tag > number && tableY != 369 && mySrollView.contentOffset.y < 100){
                mySrollView.scrollRectToVisible(CGRect(x: 0, y: CGFloat(30*Int(sender.tag)), width: 1, height: 1), animated: true)
                mySrollView.setContentOffset(CGPoint(x: 0, y: 30*Int(sender.tag)), animated: true)
            }
            
            if sender.tag > number{
                
                mySrollView.setContentOffset(CGPoint(x: 0, y: 22*Int(sender.tag)), animated: false)
                
            }
            
            
            if sender.tag > self.labels.count - number {
                
                
                if isFromHome {
                    
                    mySrollView.setContentOffset(CGPoint(x: 0, y: (self.labels.count - number + 7)*Int(sender.tag)), animated: false)
                    
                }else {
                    
                    mySrollView.setContentOffset(CGPoint(x: 0, y: mySrollView.contentSize.height - mySrollView.bounds.size.height), animated: false)
                    
                }
                
                
                
            }
            
            
            btnBack.setTitle("Back", for: UIControlState())
        }
        
        
        tableY = 369 - 86
        tableHeight = 300
        
        for (_, button) in labelButtons.enumerated() {
            button.alpha = 0.3
            button.setTitleColor(hexStringToUIColor("#6D6C6C"), for: UIControlState())
        }
        
        
        for (_, button) in rowButtons.enumerated() {
            button.alpha = 0.3
        }
        
        let rowView: UIView = rowViews[sender.tag]
        for view in rowView.subviews as [UIView]{
            if let btn = view as? UIButton {
                btn.alpha = 1
            }
        }
        //        showHideViews(false)
        rowTitle.text = self.labels[Int(sender.tag)].uppercased()
        rowTitle.textColor = GRAY_COLOR
        self.currentSelectedRow = Int(sender.tag)
        self.rowDataSelected = self.barDatas[Int(sender.tag)]
        
        renderBarChart(self.rowDataSelected)
        
        
        renderAttributes(self.getDefaultData())
        //        renderSlider()
        
        
        updateDetailView()
        updateMonthPosition()
        sender.alpha = 1;
        isFromHome = false
        senderTap = sender
    }
    
    func selectBarItem(){
        //        if(self.barDataSelected.order != -1){
        //            barViews[self.barDataSelected.order - 1].alpha = 0.7
        //            monthLabels[self.barDataSelected.order - 1].textColor = GRAY_COLOR
        //        }
    }
    func barTap(_ sender: UITapGestureRecognizer){
        var tag = sender.view!.tag
        if (tag >= 600) {
            tag = sender.view!.tag - 600
        }
        let data:MonthData = self.rowDataSelected[tag] as MonthData
        
        
        resetMonthLabels()
        self.barDataSelected = data
        self.resetBarViews()
        barViews[tag].backgroundColor = hexStringToUIColor("#F8F8F8").withAlphaComponent(0.7)
        monthLabels[tag].textColor = GRAY_COLOR
        
        renderAttributes(data)
        
    }
    
    func yearSelected(_ sender: UITapGestureRecognizer){
        
        
        let label = sender.view! as! UILabel
        
        btnYear.setTitle(label.text!, for: UIControlState())
        btnHeaderYear.setTitle(label.text!, for: UIControlState())
        let yearView = self.view.viewWithTag(107)! as UIView
        UIView.animate(withDuration: 0.2, animations: {
            yearView.isHidden = true
        })
        
        DispatchQueue.main.async {
            
            //            if(self.checkOverView()){
            
            self.btnBack.setTitle("Log Out", for: UIControlState())
            self.isDetail = false
            
            self .backMainScreen()
            self.updateDetailView()
            self.updateMonthPosition()
            //            }
            self.loadData(label.text!)
        }
        
        
        
    }

    @IBAction func profileTapped(_ sender: UIButton) {
        let profileView = (self.view.viewWithTag(106))! as UIView
        var xPos: CGFloat
        var viewFrame: CGRect

            xPos = UIScreen.main.bounds.width
            viewFrame = CGRect(x: xPos, y: 87, width: profileView.frame.width, height: profileView.frame.height)
            
            if(profileView.frame.origin.x == xPos){
                viewFrame.origin.x = UIScreen.main.bounds.width - 300
            }
            else {
                viewFrame.origin.x = UIScreen.main.bounds.width
            }

        UIView.animate(withDuration: 0.3, animations: {
            
            profileView.frame = viewFrame
        })
        
        
        
    }
    @IBAction func yearTapped(_ sender: UIButton) {
        
        let yearView = self.view.viewWithTag(107)! as UIView
        UIView.animate(withDuration: 0.2, animations: {
            yearView.isHidden = !yearView.isHidden
            if yearView.isHidden == false {
                
                self.scrollViewParent .setContentOffset(CGPoint.init(x: self.scrollViewParent.contentSize.width - self.scrollViewParent.bounds.size.width, y: 0), animated: true)

            }
        })
    }
    @IBAction func backTapped(_ sender: UIButton) {
        isDetail = false
        self .backAction()
        
    }
    
    @IBAction func mapViewAction(_ sender: Any) {
        
        let des = STORYBOARD_MAIN.instantiateViewController(withIdentifier: "MapVC")
        self.present(des, animated: false, completion: nil)
    }
    
    
    func backAction() {
        
        self.barDataSelected = MonthData(order: -1, label: "", value: "", color: "", elective_patient: "", general: "", emergency: "", day_surgery: "", total_elective_emergency: "", real_value: "")

        if(!self.isDetail && self.topView.isHidden){
            let refreshAlert = UIAlertController(title: "Log Out", message: "Are you sure to log out?", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }else{
            
                btnBack.setTitle("Log Out", for: UIControlState())
                self.resetBarViews()
                self.resetMonthLabels()
                self.renderAttributes(self.getDefaultData())
                backMainScreen()
        }
        
        updateDetailView()
        updateMonthPosition()
    }
    
    //MARK: PROPERTIES ACTION
    func checkIsMainScreen() ->Bool {
        if(self.topView.isHidden != true){
            return true
        }
        return false
    }
    func checkOverView() ->Bool {
        for (_, button) in barViews.enumerated() {
            if(button.alpha != 0.0){
               return false
            }
        }
        return true
    }
    func backMainScreen(){
        tableY = 154 - 86
        tableHeight = 400
        for (_, button) in rowButtons.enumerated() {
            button.alpha = 1
        }
        for (_, button) in labelButtons.enumerated() {
            button.alpha = 1
        }
        senderTap = nil
        isFromHome = true
        
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
    func showHideViews(_ bool:Bool){
        
        self.view.viewWithTag(100)?.isHidden = bool
        self.view.viewWithTag(101)?.isHidden = bool
        self.view.viewWithTag(102)?.isHidden = bool
        scrollViewParent.viewWithTag(108)?.isHidden = bool

    }
    
    
    
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        filter()
    }
    
    
    
    
    
    
    func resetBarViews(){
        if(barViews.count != 0){
            for i in 0...barViews.count-1{
                barViews[i].backgroundColor = UIColor.white
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
    
    
    
    func setSelectedRow(){
        
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
        
        let defaultData:MonthData = MonthData(order:0, label: averageLabel, value: String(averageValue), color:currentOverviewData.color, elective_patient:String(averageElectivePatient), general:String(averageGeneral), emergency:String(averageEmergency), day_surgery:String(averageDaySurgery), total_elective_emergency:String(averageTotalElectiveEmergency), real_value:String(averageValue))
        
        return defaultData
        
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

    func drawSliderValuable(_ lower: Int,_ upper: Int) {
       
//        rangeSlider.layer.cornerRadius = 5.5
//        rangeSlider.clipsToBounds = true
        let lowerXpos: CGFloat = CGFloat(self.rangeSlider.frame.origin.x) + CGFloat(lower) / 100 * 510
        let upperXpos: CGFloat = CGFloat(self.rangeSlider.frame.origin.x) + CGFloat(upper) / 100 * 510
        
        //reset old label
        for subview in slideRangeView.subviews {
            if subview.tag == 1 || subview.tag == 2 || subview.tag == 3 || subview.tag == 4 {
                subview.removeFromSuperview()
            }
        }
        
        labelLower = UILabel()
        labelLower.frame = CGRect(x: lowerXpos - 4, y: 15 ,width: 12 , height: 14)
        labelLower.text = "\(lower)"
        labelLower.textColor = LIGHT_GRAY_COLOR
        labelLower.font = UIFont(name: FONT_DEFAULT, size: 10)
        labelLower.textAlignment = .center
        labelLower.tag = 1
        slideRangeView.addSubview(labelLower)
        
        labelUpper = UILabel()
        labelUpper.frame = CGRect(x: upperXpos - 10, y: 15 ,width: 12 , height: 14)
        labelUpper.text = "\(upper)"
        labelUpper.font = UIFont(name: FONT_DEFAULT, size: 10)
        labelUpper.textColor = LIGHT_GRAY_COLOR
        labelUpper.textAlignment = .center
        labelUpper.tag = 2
        slideRangeView.addSubview(labelUpper)
        
        //label
        let label0 = UILabel()
        label0.frame = CGRect(x: 0, y: 38 ,width: 12 , height: 14)
        label0.text = "\(0)"
        label0.font = UIFont(name: FONT_DEFAULT, size: 10)
        label0.textColor = LIGHT_GRAY_COLOR
        label0.textAlignment = .right
        label0.tag = 3
        slideRangeView.addSubview(label0)
        
        let label100 = UILabel()
        label100.font = UIFont(name: FONT_DEFAULT, size: 10)
        label100.frame = CGRect(x: 522, y: 38 ,width: 18 , height: 14)
        label100.text = "\(100)"
        label100.textColor = LIGHT_GRAY_COLOR
        label100.textAlignment = .left
        label100.tag = 4
        slideRangeView.addSubview(label100)
        xLower = labelLower.frame.origin.x
        xUpper = labelUpper.frame.origin.x
    }
    
  
    //MARK: ScrollView delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == monthScrollView {
            itemScrollView.contentOffset.x = scrollView.contentOffset.x
            chartScrollView.contentOffset.x = scrollView.contentOffset.x
            print(itemScrollView.contentOffset.x)
        }
        if scrollView == itemScrollView {
            monthScrollView.contentOffset.x = scrollView.contentOffset.x
            chartScrollView.contentOffset.x = scrollView.contentOffset.x
        }
        
        if scrollView == chartScrollView {
            monthScrollView.contentOffset.x = scrollView.contentOffset.x
            itemScrollView.contentOffset.x = scrollView.contentOffset.x
        }
        
        if scrollView.contentOffset.x < 260 {
            self.nextImage.image = UIImage(named: "next_arrow.png")
        }
        else {
            self.nextImage.image = UIImage(named: "prev_arrow.png")
        }
        if scrollView.contentOffset.y == scrollView.contentSize.height {
            
            self.imgViewDown.isHidden = true
            
        }
        if scrollView.contentOffset.y == 0 {
            
            self.imgViewUp.isHidden = true
            
        }
      
    }

}
