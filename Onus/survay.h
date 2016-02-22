//
//  survay.h
//  Onus
//
//  Created by User on 2016-02-13.
//  Copyright © 2016 Mahdi ELARBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface survay : NSObject
@property (strong, nonatomic) NSString *pk;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *company;

-(id)initWithJson:(NSDictionary*)json;

@end
