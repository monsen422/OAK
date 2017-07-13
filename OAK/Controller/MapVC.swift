//
//  MapVC.swift
//  OAK
//
//  Created by TVT25 on 1/21/17.
//  Copyright © 2017 Pham Minh Vu (Jason). All rights reserved.
//

import UIKit
import FSInteractiveMap

class MapVC: UIViewController {

    
    var shapeClick: CAShapeLayer!
    var orientations:UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
    let rangeSlider = RangeSlider(frame: CGRect.zero)
    var rangeSliderView = UIView()
    
    
    //MARK: OUTLET CONSTRAINT
    @IBOutlet weak var controlViewCenterVerticalConstraint: NSLayoutConstraint!
    
    //MARK: OUTLET VIEW
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var mapView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        callAPI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func setupVar() {
        //setup map
//        let map = FSInteractiveMapView()
////        map.frame = mapView.bounds
//        var mapData = [String: Int]()
//        mapData["asia"] = 12
//        mapData["australia"] = 2
//        mapData["north_america"] = 5
//        mapData["south_america"] = 14
//        mapData["africa"] = 5
//        mapData["europe"] = 20
//        
//        map.loadMap("world-continents-low", withData: mapData, colorAxis: [UIColor.lightGray,UIColor.lightGray])
//        map.clickHandler = { (identifier, layer) in
//            if((self.shapeClick) != nil) {
//                self.shapeClick.zPosition = 0;
//                self.shapeClick.shadowOpacity = 0;
//            }
//            self.shapeClick = layer
//            layer!.zPosition = 10;
//            layer!.shadowOpacity = 0.5;
//            layer!.shadowColor = UIColor.black.cgColor
//            layer!.shadowRadius = 5;
//            layer!.shadowOffset = CGSize(width: 0, height: 0)
//        }
//        
//        mapView.addSubview(map)
//        mapView.setNeedsDisplay()
    }
    
    func setupUI() {
        
        if (orientations == .portrait) {
            self.controlViewCenterVerticalConstraint.priority = 260
        }
        else {
            self.controlViewCenterVerticalConstraint.priority = 240
        }
        renderSlider()
    }
    
    func callAPI() {
        
    }

    @IBAction func heatAction(_ sender: Any) {
        
        let des = STORYBOARD_MAIN.instantiateViewController(withIdentifier: "HomeVC")
        self.present(des, animated: false, completion: nil)
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
                self.controlViewCenterVerticalConstraint.priority = 260
                
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
                self.controlViewCenterVerticalConstraint.priority = 240
                
            }
            else {
                return
            }
        }
        
    }
    
    //MARK: SLIDER
    func renderSlider(){
        
        for subview in self.sliderView.subviews {
            if subview.tag == 5  {
                subview.removeFromSuperview()
            }
        }
        
        rangeSliderView = UIView(frame: self.sliderView.bounds)
        rangeSliderView.tag = 5
        
        rangeSlider.frame = CGRect(x: rangeSliderView.frame.size.width/2 - 100, y: 10 ,width: CGFloat(Int(510)), height: 31)
        
        rangeSliderView.addSubview(rangeSlider)
        
        drawSliderValuable(Int(rangeSlider.lowerValue * 100), Int(rangeSlider.upperValue * 100))
        
        rangeSlider.addTarget(self, action: #selector(self.rangeSliderValueChanged(_:)), for: .valueChanged)
        
        
        self.rangeSlider.trackHighlightTintColor = UIColor.red
        self.rangeSlider.curvaceousness = 0.0
        self.sliderView.addSubview(rangeSliderView)
        
    }
    
    func drawSliderValuable(_ lower: Int,_ upper: Int) {
        
        //        rangeSlider.layer.cornerRadius = 5.5
        //        rangeSlider.clipsToBounds = true
        let lowerXpos: CGFloat = CGFloat(self.rangeSlider.frame.origin.x) + CGFloat(lower) / 100 * 510
        let upperXpos: CGFloat = CGFloat(self.rangeSlider.frame.origin.x) + CGFloat(upper) / 100 * 510
        
        //reset old label
        
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
        
        
        rangeSliderView.frame = CGRect(x: margin, y: yPos ,width: 541, height: 45)
        
        return rangeSliderView.frame
    }
    
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
//        filter()
    }

    //MARK: BUTTON ACTION
    
    @IBAction func africaAction(_ sender: Any) {
        mapView.image = UIImage(named: "africa_selected.png")
    }
    
    @IBAction func asiaAction(_ sender: Any) {
        mapView.image = UIImage(named: "asia_selected.png")
    }
    
    @IBAction func oceanAction(_ sender: Any) {
        mapView.image = UIImage(named: "ocean_selected.png")
    }
    
    @IBAction func europeAction(_ sender: Any) {
        mapView.image = UIImage(named: "europe_selected.png")
    }
    
    @IBAction func northAmericaAction(_ sender: Any) {
        
        mapView.image = UIImage(named: "north_america_selected.png")
    }
    
    @IBAction func southAmericaAction(_ sender: Any) {
        mapView.image = UIImage(named: "south_america_selected.png")
    }
    
    
    
}
