//
//  CollectionViewCell.h
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *im;
@property (retain, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indic;


@end
