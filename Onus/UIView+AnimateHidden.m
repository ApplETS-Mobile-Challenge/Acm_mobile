//
//  UIView+AnimateHidden.m
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import "UIView+AnimateHidden.h"

@implementation UIView (AnimateHidden)

-(void)setHiddenAnimated:(BOOL)hide duration:(NSTimeInterval)duration {
    if(self.hidden == hide)
        return;
    if(hide)
        self.alpha = 1;
    else {
        self.alpha = 0;
        self.hidden = NO;
    }
    [UIView animateWithDuration:duration animations:^{
        if (hide)
            self.alpha = 0;
        else
            self.alpha = 1;
    } completion:^(BOOL finished) {
        if(finished)
            self.hidden = hide;
    }];
}

@end
