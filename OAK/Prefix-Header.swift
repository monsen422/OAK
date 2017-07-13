//
//  Prefix-Header.swift
//  Restaurant
//
//  Created by TVT25 on 8/3/16.
//  Copyright © 2016 TVT25. All rights reserved.
//

import UIKit
import CoreData



func hexStringToUIColor (_ hex:String) -> UIColor {
    
    var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    
    if (cString.hasPrefix("#")) {
        cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
//********************************************************************************************//
//********************************************************************************************//


//MARK: UMAIR

typealias jsonStandard = [String : AnyObject]

///---------------------------------------------------------------------------------------
/// STRIPE KEY
///---------------------------------------------------------------------------------------
//MARK: - STRIPE KEY

let stripePublishKey = "pk_test_iww7ObVHrhFuOR4ZcDokQegK"
let stripeSecretKey = "sk_test_KSjVhrx1kIJ6xxpHaUEgmSui"




///---------------------------------------------------------------------------------------
/// SERVER
///---------------------------------------------------------------------------------------
//MARK: - SERVER
let API_LOGIN = "http://oasurgical-api.jsoft.com.au/api/user/login"
let API_LIST_ITEMS = "http://oasurgical-api.jsoft.com.au/api/item/list"



//let SERVER = "" //PRODUCTION
let paypalPrivatePolicy = "https://www.paypal.com/webapps/mpp/ua/privacy-full"
let paypalAgreementURL = "https://www.paypal.com/webapps/mpp/ua/useragreement-full"
let paypalClientID = "AUrjpms8q95JfZFPZVNiHJ1ayBQ7M-Vrdb5qzoV99ZBFWm3pTzbBzZoEpB4aGMxuQYQd4dm61drjCXXB"
let linkUrlListed = "https://thelistedapp.com/"



///---------------------------------------------------------------------------------------
/// USERDEFAULT KEYWORD
///---------------------------------------------------------------------------------------
//MARK: - USERDEFAULT KEYWORD
let CUR_USER = "USER"
let USER_LOGIN = "USER_LOGIN"
let USER_PASSWORD = "USER_PASSWORD"
let LOGIN_MODE = "LOGIN_MODE"



///---------------------------------------------------------------------------------------
/// NOTIFICATION KEYWORD
///---------------------------------------------------------------------------------------
//MARK: - NOTIFICATION KEYWORD

let UPDATE_LIST_RESULT = "UPDATE_LIST_RESULT"

///---------------------------------------------------------------------------------------
/// COLOR
///---------------------------------------------------------------------------------------
//MARK: - COLOR

let YELLOW_COLOR = hexStringToUIColor("f2a436")
let NAVI_COLOR = hexStringToUIColor("236594")
let BACKGROUND_COLOR = hexStringToUIColor("eeeeee")
let BORDER_COLOR = hexStringToUIColor("6291c7")
let PLACE_HOLDER_COLOR = hexStringToUIColor("7fa5d1")
let GRAY_COLOR = hexStringToUIColor("414E53")
let LIGHT_GRAY_COLOR = hexStringToUIColor("AAB1B0")
let LIGHT_COLOR = hexStringToUIColor("D5D9D9")



///---------------------------------------------------------------------------------------
/// SUBMIT APPLE STORE
///---------------------------------------------------------------------------------------
//MARK: - SUBMIT APPLE STORE

let APPLE_ID = "1078130185"
let URL_APPSTORE = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1078130185&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
let GOOGLE_CLIENT_ID = "262073836011-v5rbmvclh9tskf3goji15di74fqna6ml.apps.googleusercontent.com"
let FIR_DATABASE_CHAT = "https://lukin4-f272f.firebaseio.com/"

//********************************************************************************************//
//********************************************************************************************//

/// NOT CHANGE

//********************************************************************************************//
//********************************************************************************************//


///---------------------------------------------------------------------------------------
/// APPLICATION
///---------------------------------------------------------------------------------------
//MARK: - APPLICATION

let SHARE_APPLICATION_DELEGATE = UIApplication.shared.delegate as! AppDelegate
let STORYBOARD_MAIN = UIStoryboard(name: "Main", bundle: nil)
let STORYBOARD_MAIN_IPHONE = UIStoryboard(name: "Main_iphone", bundle: nil)
#if (arch(i386) || arch(x86_64)) && os(iOS)
let IS_SIMULATOR = true
#else
let IS_SIMULATOR = false
#endif


///---------------------------------------------------------------------------------------
/// PATH
///---------------------------------------------------------------------------------------

//MARK: - PATH

let PATH_OF_APP_HOME = NSHomeDirectory()
let PATH_OF_TEMP = NSTemporaryDirectory()

///---------------------------------------------------------------------------------------
/// SCREEN FRAME
///---------------------------------------------------------------------------------------
//MARK: - SCREEN FRAME

var SCREEN_WIDTH = UIScreen.main.bounds.size.width
var SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)
let SIZEHEIGHT_NAVI = 64
let SIZEHEIGHT_TABBAR = 49


let IS_IPAD: Bool = (UIDevice.current.userInterfaceIdiom == .pad)
let IS_IPHONE: Bool = (UIDevice.current.userInterfaceIdiom == .phone)
let IS_RETINA: Bool = (UIScreen.main.scale >= 2.0)

let IS_IPHONE_4S: Bool = (IS_IPHONE&&(SCREEN_MAX_LENGTH < 568.0))
let IS_IPHONE_5: Bool = (IS_IPHONE&&(SCREEN_MAX_LENGTH == 568.0))
let IS_IPHONE_6: Bool = (IS_IPHONE&&(SCREEN_MAX_LENGTH == 667.0))
let IS_IPHONE_6P: Bool = (IS_IPHONE&&(SCREEN_MAX_LENGTH == 736.0))
let IS_IPAD_PRO: Bool = (IS_IPAD && ((UIScreen.main.bounds.width > 1024) || (UIScreen.main.bounds.height > 1024)))


///---------------------------------------------------------------------------------------
/// SERVICE MOTHOD
///---------------------------------------------------------------------------------------
//MARK: - SERVICE MOTHOD

let POST_METHOD = "POST"
let GET_METHOD = "GET"
let PUT_METHOD = "PUT"


///---------------------------------------------------------------------------------------
/// FONTS
///---------------------------------------------------------------------------------------
//MARK: - FONTS

let FONT_DEFAULT            =  "Avenir Next"
let FONT_BOLD               =  "HelveticaNeue-Bold"
let FONT_BOLD_ITALIC        =  "HelveticaNeue-BoldItalic"
let FONT_ITALIC             =  "HelveticaNeue-Italic"
let FONT_LIGHT              =  "HelveticaNeue-Light"
let FONT_LIGHT_ITALIC       =  "HelveticaNeue-LightItalic"
let FONT_MEDIUM             =  "HelveticaNeue-Medium"
let FONT_MEDIUM_ITALIC      =  "HelveticaNeue-MediumItalic"
let FONT_REGULAR            =  "HelveticaNeue"
let FONT_THIN               =  "HelveticaNeue-Thin"
let FONT_THIN_ITALIC        =  "HelveticaNeue-ThinItalic"
let FONT_ULTRA_LIGHT        =  "HelveticaNeue-UltraLight"
let FONT_ULTRA_LIGHT_ITALIC =  "HelveticaNeue-UltraLightItalic"
let FONT_COND_BLACK         =  "HelveticaNeue-CondensedBlack"
let FONT_COND_BOLD          =  "HelveticaNeue-CondensedBold"


///---------------------------------------------------------------------------------------
/// REX KEYWORD
///---------------------------------------------------------------------------------------
//MARK: - REX KEYWORD


let REGEX_ZIPCODE_LIMIT     = "^.{5,10}$"
let REGEX_ZIPCODE           = "^([0-9]{5})(?:[-\\s]*([0-9]{4}))?$"
let REGEX_PASSWORD_LIMIT    = "^.{6,20}$"
let REGEX_PASSWORD          = "[A-Za-z0-9]{6,20}"
let REGEX_USER_NAME_LIMIT   = "^.{3,15}$"
let REGEX_USER_NAME         = "[a-z0-9_]{3,15}"
let REGEX_EMAIL             = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let REGEX_PHONE_US          = "((\\(\\d{3}\\) ?)|(\\d{3}-))?\\d{3}-\\d{4}"
let REGEX_NUMBER            = "^\\d+$"
let REGEX_NUMBER_COMMA      = "^\\d{1,3}([,]\\d{3})*$"
let REGEX_ALPHABET          = "^[a-zA-Z]+$"
let REGEX_ALPHA_NUMERIC     = "^[a-zA-Z0-9]+$"
let REGEX_CREDIT_CARD_LIMIT = "^.{10,23}$"//12-19
let REGEX_CVV_LIMIT         = "^.{3,4}$"
let REGEX_NULL              = "^\\s*$"



//********************************************************************************************//
//********************************************************************************************//
//********************************************************************************************//
//********************************************************************************************//
//********************************************************************************************//
//********************************************************************************************//
//********************************************************************************************//

//#define MsgEmail         @"Plase Enter Valid Email."
//#define MsgEmailEmpty    @"Plase Enter Email."
//#define MsgPasswordEmpty    @"Plase Enter Password."

///---------------------------------------------------------------------------------------
/// MESSAGE KEYWORD
///---------------------------------------------------------------------------------------
//MARK: - MESSAGE KEYWORD

let MsgEmail = "Please Enter Valid Email."
let MsgEmailEmpty = "Please Enter Email."
let MsgPasswordEmpty = "Please Enter Password."
let MsgValidEmail = "Email is invalid"
let MsgValidZipCode = "Zipcode is invalid"
let MsgValidPhone = "Phone number must be in proper format (eg. (###) ###-####)"
let MsgValidPassword = "Password characters limit should be come between 6 - 20"
let kMale = "Male"
let kFemale = "Female"
let kDefaultDateFormat = "yyyy-MM-dd"
let MsgLogin = "Login failed."
let kSuccessPayment = "kSuccessPayment"
let kPayInfoSuccess = "kPayInfoSuccess"
let kInquiryAddingSuccess = "kInquiryAddingSuccess"
let kDetailShowInfomation = "Request to show information."
let kDetailShowRelationship = "Request to show relationship."
let kRelationShip = "RELATIONSHIP"
let kOnlineDating = "ONLINE DATING"
let kWebandAppUsage = "DATING WEBSITE AND APP USAGE"
let kStatistic = "STATISTIC"
let kReceiveNewMessage = "kReceiveNewMessage"
let kMsgDeleteMessage = "Are you sure want to deleted this message?"


class Prefix_Header: UIViewController {
    
}
