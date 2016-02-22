//
//  company.m
//  Onus
//
//  Created by User on 2016-02-13.
//  Copyright © 2016 Mahdi ELARBI. All rights reserved.
//

#import "company.h"

@implementation company


-(id)initWithJson:(NSDictionary*)json{
    
    if (self = [super init]) {
        
        self.pk = [json objectForKey:@"id"];
        self.nom = [json objectForKey:@"nom"];
        self.price = [json objectForKey:@"price"];
        self.image = [json objectForKey:@"image"];
        self.question = [json objectForKey:@"question"];
            }
    return self;
}

@end
