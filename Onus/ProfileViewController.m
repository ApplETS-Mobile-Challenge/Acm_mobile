//
//  ProfileViewController.m
//  challenge
//
//  Created by User on 2016-02-13.
//  Copyright © 2016 Mahdi ELARBI. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImage+Rotation.h"
#import "Constants.h"
#import "SendToCompanyViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *blurBG = [[UIImageView alloc] initWithFrame:self.view.bounds];
    blurBG.contentMode = UIViewContentModeScaleAspectFill;
    blurBG.image = [UIImage imageNamed:@"blur_BG.png"];
    [self.view addSubview:blurBG];
    
    
    UIImageView *im_profile = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 100, 200, 200)];
    im_profile.image = [UIImage imageNamed:@"person-profile-circle.png"];
   // im_profile.image = [im_profile.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  //  [im_profile setTintColor:[UIColor colorWithRed:24.0f/255.0f green:85.0f/255.0f blue:43.0f/255.0f alpha:1.0]];
/*
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 25*1024;//was 250x1024
    
    NSData *imageData = UIImageJPEGRepresentation(im_profile.image, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(im_profile.image, compression);
    }
    */

   // im_profile.image = [UIImage imageWithData:imageData];

    
    [self.view addSubview:im_profile];
    
    
    UILabel *argent = [[UILabel alloc]initWithFrame:CGRectMake (0, im_profile.frame.origin.x+im_profile.frame.size.height+30+50, [UIScreen mainScreen].bounds.size.width, 31)];
    argent.numberOfLines = 1;
    argent.font=[UIFont fontWithName:@"Helvetica" size:30];
    argent.backgroundColor = [UIColor clearColor];
    argent.textColor = [UIColor whiteColor];
    argent.textAlignment = NSTextAlignmentCenter;
    argent.text=@"10 $";
    [self.view addSubview:argent];
    

    UIImageView *back =[[UIImageView alloc] initWithFrame:CGRectMake(15,30,15,25)];
    back.image=[UIImage imageNamed:@"back.png"];
    [self.view addSubview:back];
    
    UILabel *back_Label =[[UILabel alloc] initWithFrame:CGRectMake(back.frame.origin.x+back.frame.size.width+ 15,30,100,25)];
    back_Label.text=@"Cancel";
    back_Label.textColor=[UIColor whiteColor];
    [self.view addSubview:back_Label];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 15.0f, 50.0, 40.0);
    [self.view addSubview:button];
    
    
    
    UIButton *loginFbBT = [[UIButton alloc] initWithFrame:CGRectMake(0, argent.frame.origin.y + argent.frame.size.height + 20+50, [UIScreen mainScreen].bounds.size.width- 2 * 28, 44)];
    loginFbBT.titleLabel.font = ralewayExtraLight16;
    loginFbBT.backgroundColor = Rgb2UIColor(35, 102, 181, 1);
    loginFbBT.layer.cornerRadius = 22.0f;
    [loginFbBT setTitle:@"Donate" forState:UIControlStateNormal];
    [loginFbBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginFbBT addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    
    CGPoint center = loginFbBT.center;
    center.x = self.view.center.x;
    loginFbBT.center = center;
    
    [self.view addSubview:loginFbBT];

}



-(void)go:(id)sender{
    
  
    
    SendToCompanyViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"SendToCompanyViewController"];
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate=self;
    transition.fillMode = kCAFillModeBoth;
    [transition setRemovedOnCompletion:YES];
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    [self presentModalViewController:newView animated:NO];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    CATransition *transitionll = [CATransition animation];
    transitionll.duration = 0.5;
    transitionll.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transitionll.type = kCATransitionPush;
    transitionll.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transitionll forKey:nil];
    [self dismissModalViewControllerAnimated:NO];
}





@end
