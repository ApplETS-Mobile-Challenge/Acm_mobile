//
//  question.m
//  Onus
//
//  Created by User on 2016-02-13.
//  Copyright © 2016 Mahdi ELARBI. All rights reserved.
//

#import "question.h"

@implementation question


-(id)initWithJson:(NSDictionary*)json{
    
    if (self = [super init]) {
        
        self.pk = [json objectForKey:@"id"];
        self.libelé = [json objectForKey:@"libelle"];
   
    }
    return self;
}



@end
