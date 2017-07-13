//
//  LineChartViewUmair.swift
//  OAK
//
//  Created by Mac on 19/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class LineChartViewUmair: UIView {
    
    var mainView = UIView()
    
    let indentation:CGFloat = 40.0
    var x_axis_Values:[String] = [String]()
    var x_axis_Points:[CGFloat] = [CGFloat]()
    var xValues = [String]();
    
    
    var y_Axis_Value:[String] = [String]()
    var y_Axis_points:[CGFloat] = [CGFloat]() //
    var y_Axis_points_final:[CGFloat] = [CGFloat]()
    var lineFrame:CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 200))
    
    var yHeading:String = ""
    var xHeading:String = ""
    
    
    var yValues = [String]();
    var yJumpsMax: CGFloat = 0
    var yJumpsMin: CGFloat = 0
    var yJump: CGFloat = 0
    
    
    var xJumps: CGFloat = 0

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        /*
        let aPath2 = UIBezierPath()
        aPath2.move(to: CGPoint(x:self.frame.size.width/2, y:0))
        aPath2.addLine(to: CGPoint(x:self.frame.size.width/2, y:self.frame.size.height))
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        aPath2.close()
        //If you want to stroke it with a red color
        UIColor.brown.set()
        aPath2.stroke()
        //If you want to fill it as well
        aPath2.fill()
        
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x:0, y:0))
        aPath.addLine(to: CGPoint(x:self.frame.size.width, y:self.frame.size.height))
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        aPath.close()
        //If you want to stroke it with a red color
        UIColor.red.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
 */
        
//        self.lineFrame = frame
//        self.updateMySelf()
        
    }
    
    
    public func updateMySelf() -> Void
    {
        //self.backgroundColor = UIColor.green
        
        
        mainView.frame = CGRect(origin: CGPoint(x: indentation, y: indentation), size: CGSize(width: lineFrame.size.width-(indentation * 1.5), height: lineFrame.size.height-(indentation * 2)))
        mainView.backgroundColor = UIColor.white
        
        self.addSubview(mainView)
        
        // Drawing the Y-Axis
        let y_axis_view = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: mainView.frame.size.height)))
        y_axis_view.backgroundColor = UIColor.white//UIColor.white//UIColor(hexString: "989898")
        mainView.addSubview(y_axis_view)
        
        // Setting Maximum and Minumum Value sof Y-Axis and Adding y-Labels
        self.setValueOFYJumps()
        self.yPoints()
        self.AddTheYLabels();
        self.addStripsAlongAxis()
        
        // Drawing the X-Axis
        let x_axis_view = UIView(frame: CGRect(origin: CGPoint(x: 0, y: mainView.frame.size.height), size: CGSize(width: mainView.frame.size.width, height: 1)))
        x_axis_view.backgroundColor = UIColor(hexString: "989898")
        mainView.addSubview(x_axis_view)
        
        
        // Settingg of X-Axis
        self.xPoints()
        self.AddTheXLabels()
        
        // Calculating Points of y_Axis
        self.calculateY_points_Final()
        
        // Populating simple Dots in View
        self.PopulatePointsInGraphView()

        // Adding OverLayView for color
        DataManager.dataManagerSharedInstance.x_axis_Points = x_axis_Points
        DataManager.dataManagerSharedInstance.y_Axis_points_final = y_Axis_points_final
        let overLayView = OverLayViewUmair(frame: self.mainView.bounds)
        overLayView.backgroundColor = UIColor.clear
        mainView.addSubview(overLayView)
        
    }
    
    func PopulatePointsInGraphView() -> Void
    {
        print("The yValue Array is :: \(yValues)")
        print("The xValue Array is :: \(xValues)")
        let valueX =  ((lineFrame.size.width - (indentation*2))/CGFloat(xValues.count))/2 // Half od the value
        DataManager.dataManagerSharedInstance.valueX = valueX
        var i=0
        while (i<yValues.count)
        {
            let dotview = RozeeUIView()
            dotview.frame = CGRect(origin: CGPoint(x: ((x_axis_Points[i] - valueX) - 5.0), y: (y_Axis_points_final[i]) - 5.0), size: CGSize(width: 10, height: 10))
            dotview.cornerRadius = 5
            dotview.backgroundColor = UIColor(hexString: DataManager.dataManagerSharedInstance.dotColorString)
            mainView.addSubview(dotview)
            
            i+=1
        }
    }
    
    func calculateY_points_Final() ->Void
    {
        
        let MaxValue = (yJump*CGFloat(4))
        let lineHeight = lineFrame.size.height
        var i=0
        while (i<yValues.count)
        {
            var theCurrentPoint :CGFloat = 0.0
            if let n = NumberFormatter().number(from: yValues[i]) {
                theCurrentPoint = CGFloat(n)
            }
            
            var relativePoint = (lineHeight * theCurrentPoint)/MaxValue
            relativePoint = lineHeight - relativePoint + yJump
            y_Axis_points_final.append(relativePoint)
            i+=1
        }
        
        print("Bismillah, The y-Value Final Points :: \(y_Axis_points_final)")
    }
    
    func addStripsAlongAxis() -> Void
    {
        
        var i=1
        let value =  (lineFrame.size.height - (indentation*2))/4
        while(i<=y_Axis_points.count)
        {
            let uiview = UIView()
            uiview.frame = CGRect(origin: CGPoint(x: 0, y: y_Axis_points[i-1]), size: CGSize(width: mainView.frame.size.width, height: value))
            if((i%2) == 0)
            {
                uiview.backgroundColor = UIColor(hexString: "fbfbfb")
            }
            else
            {
                uiview.backgroundColor = UIColor.white
            }
            
            mainView.addSubview(uiview)
            
            i+=1
        }
    }
    
    func xPoints() -> Void {
        
        var i=0
        let value =  (lineFrame.size.width - (indentation*2))/CGFloat(xValues.count)
        while(i<xValues.count)
        {
            let currentPoint = (value * CGFloat(i+1))//(lineFrame.size.height - (indentation*2)) - (CGFloat(i) * value)
            x_axis_Points.append(currentPoint)
            
            i+=1
        }
        
        print("Bismilah, The x-axis-points Array :: \(x_axis_Points)")
    }
    
    func yPoints() -> Void {
        
        var i=0
        let value =  (lineFrame.size.height - (indentation*2))/4
        while(i<4)
        {
            let currentPoint = (lineFrame.size.height - (indentation*2)) - (CGFloat(i) * value)
            y_Axis_points.append(currentPoint)
            
            i+=1
        }
        
        print("Bismilah, The y-axis-points Array :: \(y_Axis_points)")
    }
    
    func AddTheXLabels()->Void
    {
        var i=1
        while(i<=x_axis_Points.count)
        {
            let label = UILabel()
            label.frame = CGRect(origin: CGPoint(x: x_axis_Points[i-1] - 20, y:mainView.frame.size.height + (indentation + 5) ), size: CGSize(width: 40, height: 20))
            label.textAlignment = NSTextAlignment.center
            label.backgroundColor = UIColor.white
            label.textColor = UIColor(hexString: "414E53")
            label.font = label.font.withSize(14)
            label.text = xValues[i-1]//"\(Int(yJump*CGFloat(i)))"
            self.addSubview(label)
            
            i+=1
        }
    }
    
    func AddTheYLabels()->Void
    {
        var i=1
        while(i<=y_Axis_points.count)
        {
            let label = UILabel()
            label.frame = CGRect(origin: CGPoint(x: indentation/3, y: y_Axis_points[i-1]), size: CGSize(width: 20, height: 20))
            label.textAlignment = NSTextAlignment.left
            label.backgroundColor = UIColor.white
            label.textColor = UIColor(hexString: "414E53")
            label.font = label.font.withSize(14)
            label.text = "\(Int(yJump*CGFloat(i)))"
            self.addSubview(label)
            
            i+=1
        }
    }
    
    func setValueOFYJumps() -> Void
    {
        if let n = NumberFormatter().number(from: yValues[0]) {
            yJumpsMin = CGFloat(n)
        }
        
        var i=0
        while(i < yValues.count)
        {
            var currentValueOfY:CGFloat = 0.0
            let currentValue = yValues[i]
            if let n = NumberFormatter().number(from: currentValue) {
                currentValueOfY = CGFloat(n)
            }
            
            if(yJumpsMax < currentValueOfY)
            {
                yJumpsMax = currentValueOfY
            }
            
            if(yJumpsMin > currentValueOfY)
            {
                yJumpsMin = currentValueOfY
            }
            
            i += 1
        }
        
        yJump = yJumpsMax/4 //(yJumpsMax - yJumpsMin)/4
        
        print("Bismillah, The minumum Value is :: \(yJumpsMin)")
        print("Bismillah, The maximum Value is :: \(yJumpsMax)")
    }

}
