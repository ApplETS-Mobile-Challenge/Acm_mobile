//
//  STextField.h
//  Swig
//
//  Created by macbook air on 27/05/2015.
//  Copyright (c) 2015 w-dig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STextField : UITextField

@property (nonatomic, strong) UIColor *placeHolderColor;
@property (nonatomic, strong) UIFont *placeHolderFont;
@property NSTextAlignment placeHolderTextAlignment;
@property CGFloat placeHolderPadding;

@end
