//
//  JSONModelMonthData.h
//  OAK
//
//  Created by TVT25 on 11/10/16.
//  Copyright © 2016 Pham Minh Vu (Jason). All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONModelMonthData : JSONModel
@property (strong, nonatomic) NSString <Optional> *label;
@property (strong, nonatomic) NSNumber <Optional> *value;
@property (strong, nonatomic) NSString <Optional> *color;
@property (strong, nonatomic) NSString <Optional> *elective_patient;
@property (strong, nonatomic) NSString <Optional> *general;
@property (strong, nonatomic) NSString <Optional> *emergency;
@property (strong, nonatomic) NSString <Optional> *day_surgery;


@property (strong, nonatomic) NSString <Optional> *total_elective_emergency;
@property (strong, nonatomic) NSNumber <Optional> *order;
@property (strong, nonatomic) NSNumber <Optional> *realValue;
@property (strong, nonatomic) NSNumber <Optional> *originalValue;
@property (strong, nonatomic) NSString <Optional> *originalColor;

@end
