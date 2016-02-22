//
//  STextField.m
//  Swig
//
//  Created by macbook air on 27/05/2015.
//  Copyright (c) 2015 w-dig. All rights reserved.
//

#import "STextField.h"


@implementation STextField

-(instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        self.placeHolderColor = [UIColor whiteColor];
        self.placeHolderFont =[UIFont fontWithName:@"Helvetica" size:14];
        self.placeHolderTextAlignment = NSTextAlignmentCenter;
        self.placeHolderPadding = 10;
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    //draw place holder.

    CGRect placeholderRect = CGRectMake(self.placeHolderPadding, (rect.size.height- self.placeHolderFont.pointSize)/2, rect.size.width - 2*self.placeHolderPadding, rect.size.height);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = self.placeHolderTextAlignment;
    
    [[self placeholder] drawInRect:placeholderRect withAttributes:@{NSForegroundColorAttributeName : self.placeHolderColor ,NSFontAttributeName:self.placeHolderFont, NSParagraphStyleAttributeName: paragraphStyle}];
    
    
    
}

@end
