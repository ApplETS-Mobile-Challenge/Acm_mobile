//
//  question.h
//  Onus
//
//  Created by User on 2016-02-13.
//  Copyright © 2016 Mahdi ELARBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface question : NSObject


@property (strong, nonatomic) NSString *pk;
@property (strong, nonatomic) NSString *libelé;




-(id)initWithJson:(NSDictionary*)json;


@end
