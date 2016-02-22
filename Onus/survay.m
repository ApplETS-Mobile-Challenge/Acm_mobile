//
//  survay.m
//  Onus
//
//  Created by User on 2016-02-13.
//  Copyright © 2016 Mahdi ELARBI. All rights reserved.
//

#import "survay.h"

@implementation survay




-(id)initWithJson:(NSDictionary*)json{
    
    if (self = [super init]) {
        
        self.pk = [json objectForKey:@"id"];
        self.title = [json objectForKey:@"title"];
        self.company = [json objectForKey:@"company"];
        }
    return self;
}



@end
