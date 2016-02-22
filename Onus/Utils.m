//
//  Utils.m
//  Swig
//
//  Created by macbook air on 07/06/2015.
//  Copyright (c) 2015 w-dig. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(CGFloat)pixelToPoints:(CGFloat)px {
    CGFloat pointsPerInch = 72.0;
    CGFloat scale = 1; // We dont't use [[UIScreen mainScreen] scale] as we don't want the native pixel, we want pixels for UIFont - it does the retina scaling for us
    float pixelPerInch; // aka dpi
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        pixelPerInch = 132 * scale;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        pixelPerInch = 163 * scale;
    } else {
        pixelPerInch = 160 * scale;
    }
    CGFloat result = px * pointsPerInch / pixelPerInch;
    return result;
}

+(NSString*) suffixNumber:(NSNumber*)number
{
    if (!number)
        return @"";
    
    long long num = [number longLongValue];
    
    int s = ( (num < 0) ? -1 : (num > 0) ? 1 : 0 );
    NSString* sign = (s == -1 ? @"-" : @"" );
    
    num = llabs(num);
    
    if (num < 1000)
        return [NSString stringWithFormat:@"%@%lld",sign,num];
    
    int exp = (int) (log(num) / log(1000));
    
    NSArray* units = @[@"K",@"M",@"G",@"T",@"P",@"E"];
    
    return [NSString stringWithFormat:@"%@%.1f%@",sign, (num / pow(1000, exp)), [units objectAtIndex:(exp-1)]];
}

+(NSAttributedString*)createUndernlinedText:(NSString*)text font:(UIFont*)font color:(UIColor*)color{

    NSDictionary *attrDict = @{NSFontAttributeName : font ,NSForegroundColorAttributeName : color};
    NSMutableAttributedString *title =[[NSMutableAttributedString alloc] initWithString:text attributes: attrDict];
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,[text length])];
    return title;
}

+ (int)lineCountForLabel:(UILabel *)label {
    
    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:NSLineBreakByWordWrapping];
    
    return ceil(size.height / label.font.lineHeight);
}

+(UIColor*)randomColor{

    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

+(CGPoint)calculateViewCenter:(UIView*)view{

    return CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
}

@end
