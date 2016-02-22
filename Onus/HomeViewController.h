//
//  HomeViewController.h
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) id dataObject;

@property (strong, nonatomic) NSArray *pageContent;

@end
