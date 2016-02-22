//
//  ViewController.m
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import "LoginViewController.h"
#import "STextField.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingScrollView.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Utils.h"
#import "Constants.h"
#import "HomeViewController.h"
#import "WebServiceApiManager.h"
#import "AppDelegate.h"
#import "ABCIntroView.h"

#define kFormMargin 28

@interface LoginViewController ()<FBSDKLoginButtonDelegate,ABCIntroViewDelegate,UIViewControllerTransitioningDelegate, UICollectionViewDelegateFlowLayout>

@property ABCIntroView *introView;

@end



@implementation LoginViewController


AppDelegate *appDelegateh;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
    
    UIImageView *blurBG = [[UIImageView alloc] initWithFrame:self.view.bounds];
    blurBG.contentMode = UIViewContentModeScaleAspectFill;
    blurBG.image = [UIImage imageNamed:@"blur_BG.png"];
    [self.view addSubview:blurBG];
    [self createLoginFrom];
    
    
    
 //   if(appDelegateh.firstConnect==0)
    {
        appDelegateh.firstConnect=1;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"intro_screen_viewed"])
        {NSLog(@"mmnnmmnnmmnn");
            self.introView = [[ABCIntroView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            self.introView.delegate = self;
            self.introView.backgroundColor = [UIColor greenColor];
            self.introView.tag=878;
          //  UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
            [[[[[UIApplication sharedApplication] delegate] window] rootViewController].view addSubview:self.introView];
        }
    }


}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    //self.navigationController.navigationBarHidden = YES;
}

-(void)createLoginFrom{

    TPKeyboardAvoidingScrollView *container = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44-20)];
    
    // LOGO
    
    UIImageView *logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 70, 70)];
    logoIV.contentMode = UIViewContentModeScaleAspectFit;
    logoIV.image = [UIImage imageNamed:@"ic.png"];
    
    CGPoint center = logoIV.center;
    center.x = self.view.center.x;
    logoIV.center = center;
    
    [container addSubview:logoIV];
    
    // USERNAME
    
    STextField *usernameTF = [[STextField alloc] initWithFrame:CGRectMake(0, logoIV.frame.origin.y + logoIV.frame.size.height + 20, container.frame.size.width - 2 * kFormMargin, 44)];
    usernameTF.font = [UIFont fontWithName:@"Helvetica" size:14];
    usernameTF.backgroundColor = Rgb2UIColor(255, 255, 255, 0.1f);
    
    center = usernameTF.center;
    center.x = self.view.center.x;
    usernameTF.center = center;
    
    usernameTF.layer.borderWidth = .5f;
    usernameTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    usernameTF.layer.cornerRadius = 22.0f;
    
    usernameTF.placeholder = @"Username";
    
    [container addSubview:usernameTF];
    
    // PASSWORD
    
    STextField *passwordTF = [[STextField alloc] initWithFrame:CGRectMake(0, usernameTF.frame.origin.y + usernameTF.frame.size.height + 10, container.frame.size.width -2 * kFormMargin, 44)];
    passwordTF.font = [UIFont fontWithName:@"Helvetica" size:14];
    passwordTF.backgroundColor = Rgb2UIColor(255, 255, 255, 0.1f);
    
    center = passwordTF.center;
    center.x = self.view.center.x;
    passwordTF.center = center;
    
    passwordTF.layer.borderWidth = .5f;
    passwordTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    passwordTF.layer.cornerRadius = 22.0f;
    
    passwordTF.placeholder = @"Password";
    
    [container addSubview:passwordTF];
    
    // LOGIN
   
    UIButton *loginBT = [[UIButton alloc] initWithFrame:CGRectMake(0, passwordTF.frame.origin.y + passwordTF.frame.size.height + 10, container.frame.size.width- 2 * kFormMargin, 44)];
    loginBT.titleLabel.font = ralewayExtraLight16;
    [loginBT setTitleColor:Rgb2UIColor(74, 74, 74, 1) forState:UIControlStateNormal];
    loginBT.layer.cornerRadius = 22.0f;
    loginBT.backgroundColor = [UIColor whiteColor];
    [loginBT setTitle:@"Sign In" forState:UIControlStateNormal];
    
    center = loginBT.center;
    center.x = self.view.center.x;
    loginBT.center = center;
    
    [loginBT addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [container addSubview:loginBT];
    
 
    // FORGOT PASSWORD
    
    UIButton *forgotPasswordBT = [[UIButton alloc] initWithFrame:CGRectMake(0, loginBT.frame.origin.y + loginBT.frame.size.height + 5, container.frame.size.width- 2 * kFormMargin, 30)];
    forgotPasswordBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    forgotPasswordBT.titleLabel.font = ralewayExtraLight16;
    [forgotPasswordBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgotPasswordBT setAttributedTitle:[Utils createUndernlinedText:@"Forget Password?" font:[UIFont fontWithName:@"Helvetica" size:14] color:[UIColor whiteColor]] forState:UIControlStateNormal];
    center = forgotPasswordBT.center;
    center.x = self.view.center.x;
    forgotPasswordBT.center = center;
    
    [container addSubview:forgotPasswordBT];
    
    // Facebook Login
 
    UIButton *loginFbBT = [[UIButton alloc] initWithFrame:CGRectMake(0, forgotPasswordBT.frame.origin.y + forgotPasswordBT.frame.size.height + 20, container.frame.size.width- 2 * kFormMargin, 44)];
    loginFbBT.titleLabel.font = ralewayExtraLight16;
    loginFbBT.backgroundColor = Rgb2UIColor(35, 102, 181, 1);
    loginFbBT.layer.cornerRadius = 22.0f;
    [loginFbBT setTitle:@"Facebook" forState:UIControlStateNormal];
    [loginFbBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    center = loginFbBT.center;
    center.x = self.view.center.x;
    loginFbBT.center = center;
    
    [container addSubview:loginFbBT];
    
    
    // Twitter login
    
    UIButton *loginTwitterBT = [[UIButton alloc] initWithFrame:CGRectMake(0, loginFbBT.frame.origin.y + loginFbBT.frame.size.height + 10, container.frame.size.width- 2 * kFormMargin, 44)];
    loginTwitterBT.titleLabel.font = ralewayExtraLight16;
    [loginTwitterBT setTitle:@"Twitter" forState:UIControlStateNormal];
    [loginTwitterBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginTwitterBT.layer.cornerRadius = 22.0f;
    loginTwitterBT.backgroundColor = Rgb2UIColor(53, 152, 220, 1);
    
    center = loginTwitterBT.center;
    center.x = self.view.center.x;
    loginTwitterBT.center = center;
    
    [loginTwitterBT addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [container addSubview:loginTwitterBT];
    
    // Google Login
    
    UIButton *loginGoogleBT = [[UIButton alloc] initWithFrame:CGRectMake(0, loginTwitterBT.frame.origin.y + loginTwitterBT.frame.size.height + 10, container.frame.size.width- 2 * kFormMargin, 44)];
    loginGoogleBT.titleLabel.font = ralewayExtraLight16;
    loginGoogleBT.titleLabel.font = ralewayExtraLight16;
    [loginGoogleBT setTitle:@"Google+" forState:UIControlStateNormal];
    [loginGoogleBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginGoogleBT.layer.cornerRadius = 22.0f;
    loginGoogleBT.backgroundColor = Rgb2UIColor(208, 2, 27, 1);
    
    center = loginGoogleBT.center;
    center.x = self.view.center.x;
    loginGoogleBT.center = center;
    
    [loginGoogleBT addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [container addSubview:loginGoogleBT];
    
    // SIGN UP
    
    UIButton *signUpBT = [[UIButton alloc] initWithFrame:CGRectMake(0, loginGoogleBT.frame.origin.y + loginGoogleBT.frame.size.height + 10, container.frame.size.width- 2 * kFormMargin, 44)];
    signUpBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    signUpBT.titleLabel.font = ralewayExtraLight16;
    [signUpBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signUpBT setAttributedTitle:[Utils createUndernlinedText:@"you don't have an accout yet?" font:[UIFont fontWithName:@"Helvetica" size:14] color:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    center = signUpBT.center;
    center.x = self.view.center.x;
    signUpBT.center = center;
    
    [container addSubview:signUpBT];
    
    
    [self.view addSubview:container];
}

-(void)login:(id)sender{

    WebServiceApiManager *WsApi= [WebServiceApiManager getInstance];
    WsApi.index_page=1;
    
    [[WebServiceApiManager getInstance] getAllStories:^(NSDictionary *jMarathons) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //Your main thread code goes in here
            // NSLog(@"Im on the main thread");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dataRecived" object:self];
            
            [[WebServiceApiManager getInstance] getAllCategories:^(NSDictionary *jMarathons) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //Your main thread code goes in here
                    //  NSLog(@"Im on the main thread");
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataRecived" object:self];
                    
                });
            }];

            
        });
    }];
    
  
    
    
    
    
    
    
    HomeViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    
    
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

#pragma mark Facebook login button delegate
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{

    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
         }
     }];
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
