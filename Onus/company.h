//
//  company.h
//  Onus
//
//  Created by User on 2016-02-13.
//  Copyright © 2016 Mahdi ELARBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface company : NSObject


@property (strong, nonatomic) NSString *pk;
@property (strong, nonatomic) NSString *nom;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSMutableArray *question;


-(id)initWithJson:(NSDictionary*)json;


@end
