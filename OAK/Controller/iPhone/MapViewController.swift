//
//  MapViewController.swift
//  OAK
//
//  Created by TVT25 on 1/21/17.
//  Copyright © 2017 Pham Minh Vu (Jason). All rights reserved.
//

import UIKit
import FSInteractiveMap

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: UIView!
    var shapeClick: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        callAPI()
        
    }
    
    func setupVar() {
        //setup map
        let map = FSInteractiveMapView()
        map.frame = mapView.bounds
        var mapData = [String: Int]()
        mapData["asia"] = 12
        mapData["australia"] = 2
        mapData["north_america"] = 5
        mapData["south_america"] = 14
        mapData["africa"] = 5
        mapData["europe"] = 20
        
        map.loadMap("world-continents-low", withData: mapData, colorAxis: [UIColor.lightGray, UIColor.darkGray])
        map.clickHandler = { (identifier, layer) in
            if((self.shapeClick) != nil) {
                self.shapeClick.zPosition = 0;
                self.shapeClick.shadowOpacity = 0;
            }
            self.shapeClick = layer
            layer!.zPosition = 10;
            layer!.shadowOpacity = 0.5;
            layer!.shadowColor = UIColor.black.cgColor
            layer!.shadowRadius = 5;
            layer!.shadowOffset = CGSize(width: 0, height: 0)
        }
        
        mapView.addSubview(map)
        mapView.setNeedsDisplay()
    }
    
    func setupUI() {
        
    }
    
    func callAPI() {
        
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

}
