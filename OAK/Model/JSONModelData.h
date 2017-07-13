//
//  JSONModelData.h
//  OAK
//
//  Created by TVT25 on 11/13/16.
//  Copyright © 2016 Pham Minh Vu (Jason). All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONModelData : JSONModel
@property (strong, nonatomic)NSString <Optional> *color;
@property (strong, nonatomic)NSNumber <Optional> *day_surgery;
@property (strong, nonatomic)NSNumber <Optional> *elective_patient;
@property (strong, nonatomic)NSNumber <Optional> *emergency;
@property (strong, nonatomic)NSNumber <Optional> *general;
@property (strong, nonatomic)NSString <Optional> *label;
@property (strong, nonatomic)NSNumber <Optional> *order;
@property (strong, nonatomic)NSNumber <Optional> *real_value;
@property (strong, nonatomic)NSNumber <Optional> *total_elective_emergency;
@property (strong, nonatomic)NSNumber <Optional> *value;



@end
