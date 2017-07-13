//
//  Singleton.swift
//  NaseebNetworksInc
//
//  Created by Mac on 30/11/2016.
//  Copyright © 2016 Mac. All rights reserved.
//

class FrameWorkStarter
{
    var rozeeColorDictionary = [Int: String]()
    
    public static let startRozeeFrameWork = FrameWorkStarter()
    private init()
    {
        
    }
    
    public func setColorsOfApplication(applicationColors:[Int: String]) ->Void
    {
        rozeeColorDictionary = applicationColors
    }
}
