//
//  CollectionViewCell.m
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code

      [UIView setAnimationsEnabled:NO];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.im = [[UIImageView alloc]init];
        self.im.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        self.Label = [[UILabel alloc]initWithFrame:CGRectMake(5, self.im.frame.origin.y+self.im.frame.size.height, self.frame.size.width-10, 25)];
        self.Label.textAlignment = NSTextAlignmentCenter;
        self.Label.textColor = [UIColor blackColor];
        [self.Label setFont:[UIFont systemFontOfSize:12]];
        self.Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.Label.numberOfLines = 0;
        
        
        [self.viewForBaselineLayout addSubview:self.im];
        [self.viewForBaselineLayout addSubview:self.Label];
        
        self.viewForBaselineLayout.layer.masksToBounds = YES;
       // self.viewForBaselineLayout.layer.cornerRadius = 8.0f;
    }
    return self;
}

@end
