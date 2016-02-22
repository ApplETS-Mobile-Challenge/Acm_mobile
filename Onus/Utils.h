//
//  Utils.h
//  Swig
//
//  Created by macbook air on 07/06/2015.
//  Copyright (c) 2015 w-dig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color;
+(CGFloat)pixelToPoints:(CGFloat)px;
+(NSString*) suffixNumber:(NSNumber*)number;
+(NSAttributedString*)createUndernlinedText:(NSString*)text font:(UIFont*)font color:(UIColor*)color;
+ (int)lineCountForLabel:(UILabel *)label;
+(UIColor*)randomColor;
+(CGPoint)calculateViewCenter:(UIView*)view;

@end
