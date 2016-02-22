//
//  StoryCoverViewController.m
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import "StoryCoverViewController.h"
#import "SecondContentViewController.h"
#import "WebServiceApiManager.h"
#import "SDWebImageManager.h"
#import "image-color.h"
#import "company.h"


@interface StoryCoverViewController ()<UIScrollViewDelegate>
{
     WebServiceApiManager *WsApi;
   
    NSTimer *timer;
    UILabel *myCounterLabel;
}


@end

@implementation StoryCoverViewController

NSTimer *timerr;
UIView *black;
UIVisualEffect *effect;
UIVisualEffectView *visualEffectView;
UIImageView * _im_notBlur;
 UIScrollView *_scroll;


int minutes, seconds;
int secondsLeft;

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    secondsLeft = 900;
    [self countdownTimer];
    
    
    
     [self setNeedsStatusBarAppearanceUpdate];
    
    WsApi= [WebServiceApiManager getInstance];
    
    self.view.window.alpha=1;
    
    
    //------------------- set cover image ----------------------------
    _im_notBlur =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    _im_notBlur.image=[UIImage imageNamed:@"blur_BG.png"];
    [self.view addSubview:_im_notBlur];
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.7];
    
    //_im_notBlur.image = [UIImage imageWithColor:color];
    
    [_im_notBlur setClipsToBounds:YES];
    
   
  //----------------------------------------------------------------------------
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(targetMethodl:) userInfo:nil repeats:NO];
    
    
    black=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    black.backgroundColor=[UIColor blackColor];
    
    
    //Create and add the Activity Indicator to splashView
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2+20);
    activityIndicator.transform = CGAffineTransformMakeScale(1.75, 1.75);
    activityIndicator.hidesWhenStopped = NO;
    [black addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    
   
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
     button.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-40.0f, 50.0, 40.0);
    [self.view addSubview:button];
    
    
    
    
    
    
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    visualEffectView.frame = CGRectMake(0, -10, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+10);
    visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    visualEffectView.alpha=0.f;
    [_im_notBlur addSubview:visualEffectView];
    
    
    _im_notBlur.hidden=false;
    
    black.tag=99;
    
    [self.view addSubview:black];
    
    
    //------------------------- Back ------------------------------
    UIImageView *back =[[UIImageView alloc] initWithFrame:CGRectMake(15,30,15,25)];
    back.image=[UIImage imageNamed:@"back.png"];
    [self.view addSubview:back];
    
    UILabel *back_Label =[[UILabel alloc] initWithFrame:CGRectMake(back.frame.origin.x+back.frame.size.width+ 15,30,100,25)];
    back_Label.text=@"Cancel";
    back_Label.textColor=[UIColor whiteColor];
    [self.view addSubview:back_Label];
    
    //------------------------- Done ------------------------------

    UILabel *done_Label =[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70,30,50,25)];
    done_Label.text=@"Done";
    done_Label.textColor=[UIColor whiteColor];
    [self.view addSubview:done_Label];
    //-------------------------- Separation ------------------------
    
   UIView  *separation1=[[UIView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 1)];
    separation1.backgroundColor=[UIColor blackColor];
    separation1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:separation1];
    
    
    
    UIView  *separation2=[[UIView alloc]initWithFrame:CGRectMake(0, 110, [UIScreen mainScreen].bounds.size.width, 1)];
    separation2.backgroundColor=[UIColor blackColor];
    separation2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:separation2];
    
    //-------------- Menu ------------------------
    UILabel *nb_question =[[UILabel alloc] initWithFrame:CGRectMake(10,73,[UIScreen mainScreen].bounds.size.width/3,25)];
    nb_question.text=@"10 questions";
    nb_question.textColor=[UIColor whiteColor];
    [self.view addSubview:nb_question];
    NSLog(@"test      %d",WsApi.index_page);
    company *aStory = [WsApi.API_SurvayList objectAtIndex:WsApi.index_page];
    

    
    UILabel *price =[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width/3-20,73,[UIScreen mainScreen].bounds.size.width/3,25)];
    price.text=[NSString stringWithFormat:@"%@ $",aStory.price];
    price.textAlignment=NSTextAlignmentRight;
    price.textColor=[UIColor whiteColor];
    [self.view addSubview:price];
    
  
    myCounterLabel =[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3,73,[UIScreen mainScreen].bounds.size.width/3,25)];
    myCounterLabel.text=@"15:00";
    myCounterLabel.textAlignment=NSTextAlignmentCenter;
    myCounterLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:myCounterLabel];
    
    
    UIButton *button_done = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button_done addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [button_done setTitle:@"" forState:UIControlStateNormal];
    button_done.frame = CGRectMake([UIScreen mainScreen].bounds.size.height-50.0f, 20.0f, 50.0, 50.0);
    [self.view addSubview:button_done];
}

- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ) {
        secondsLeft -- ;

        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        myCounterLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    } else {
        secondsLeft = 900;
    }
}

-(void)countdownTimer {
    
    secondsLeft = minutes = seconds = 0;
    if([timer isValid]) {
    }
      timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];

}

-(void)targetMethodl:(id)sender{
    
    [timerr invalidate];
    timerr = nil;
    
    
    

    SecondContentViewController *viewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondContentViewController"];

    
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _scroll.delegate=self;
    
    [self addChildViewController:viewController2];
    [_scroll addSubview:viewController2.view];
    [viewController2 didMoveToParentViewController:self];
    
    
    
    
    _scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _scroll.pagingEnabled = YES;
    
    [self.view addSubview:_scroll];
    
    for (UIView *subView in self.view.subviews)
    {
        if (subView.tag == 99)
        {
            [subView removeFromSuperview];
        }
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 20, 200.0, 40.0);
    [self.view addSubview:button];
    
    
    
    UIButton *back_button_bas = [UIButton buttonWithType:UIButtonTypeCustom];
    [back_button_bas addTarget:self action:@selector(back_bas:) forControlEvents:UIControlEventTouchUpInside];
    [back_button_bas setTitle:@"" forState:UIControlStateNormal];
    back_button_bas.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, 50, 50);
    [self.view addSubview:back_button_bas];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float width = scrollView.contentSize.width-self.view.bounds.size.width;
    
    float alpha = (scrollView.contentOffset.x/width)*1.7f;
    
    
 
  //  NSInteger page = (scrollView.contentOffset.x + (0.5f * scrollView.frame.size.width)) ;
  //  NSLog(@"****   %f",alpha);
  //  NSLog(@"page   %ld",(long)page);
    
    if((scrollView.contentOffset.x + (0.5f * scrollView.frame.size.width))>562){alpha = 0.85f;}
    
    visualEffectView.alpha = alpha;
    
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

-(void) back_bas:(UIButton*)sender
{
    
    [_scroll  setContentOffset:CGPointMake(0,0) animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
