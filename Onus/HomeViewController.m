//
//  HomeViewController.m
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import "HomeViewController.h"
#import "AAPullToRefresh.h"
#import "WebServiceApiManager.h"
#import "CollectionViewCell.h"
#import "image-color.h"
#import "SDWebImageManager.h"
#import "ChildViewController.h"
#import "categorie.h"
#import "story.h"
#import "ProfileViewController.h"

// Default values
#define kDefaultNumberOfSpinnerMarkers 12
#define kDefaultSpread 17.0
#define kDefaultColor ([UIColor whiteColor])
#define kDefaultThickness 4.0
#define kDefaultLength 15.0
#define kDefaultSpeed 1.0

// HUD defaults
#define kDefaultHUDSide 90.0
#define kDefaultHUDColor ([UIColor colorWithWhite:0.0 alpha:0.5])

#define kMarkerAnimationKey @"MarkerAnimationKey"

@interface HomeViewController ()<UIScrollViewDelegate>
{


    UISwipeGestureRecognizer *Swipe;
    UIView *viewWhite;
    CAReplicatorLayer * spinnerReplicator;
    UIView *Viewbig;
    UIScrollView *_ScrollView;
    AAPullToRefresh *tv;
    UILabel *titleLabel_update;
    UIImageView *titleLabel;
    NSTimer *timer;
    int timeles,putit;
    WebServiceApiManager *WsApi;
    UIView *CurlView;
    CGPoint startPosition;
}
@end


@implementation HomeViewController
@synthesize pageContent, pageViewController;

UIView *AnimationPullView;
CGRect screenFramec;
int tapped_status,type,curl_test;
CGPoint startlocation;



- (IBAction)profile_gauche:(id)sender {
    
    ProfileViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.delegate=self;
    transition.fillMode = kCAFillModeBoth;
    [transition setRemovedOnCompletion:YES];
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    [self presentModalViewController:newView animated:NO];
    
    
}


- (IBAction)profile_droite:(id)sender {
  
    ProfileViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
   //  [UIView setAnimationsEnabled:YES];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
   // self.view.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:36.0f/255.0f blue:84.0f/255.0f alpha:1.0];
    UIImageView *blurBG = [[UIImageView alloc] initWithFrame:self.view.bounds];
    blurBG.contentMode = UIViewContentModeScaleAspectFill;
    blurBG.image = [UIImage imageNamed:@"blur_BG.png"];
    [self.view addSubview:blurBG];
    
    
    
    WsApi= [WebServiceApiManager getInstance];
    screenFramec = [UIScreen mainScreen].applicationFrame;
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    pageViewController.dataSource = self;
    pageViewController.delegate = self;
    
    
    
    
    //------------------------- animation Pull to refresh----------------------
    AnimationPullView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0,self.view.bounds.size.height)];
    AnimationPullView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.1];
    AnimationPullView.clipsToBounds=YES;
    self.view.clipsToBounds=YES;
    [self.view addSubview:AnimationPullView];
    //-------------------------------------------------------------------------

    
    titleLabel = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-15, 25, 40, 25)];
    titleLabel.image=[UIImage imageNamed:@"ic.png"];
    [self.view addSubview:titleLabel];
    
  /*  UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 15, 50, 50)];
    logo.image = [UIImage imageNamed:@"logo.png"];
    [self.view addSubview:logo];*/
    
    
    
    titleLabel_update = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 25, 200, 30)];
    titleLabel_update.numberOfLines = 1;
    titleLabel_update.font=[UIFont fontWithName:@"Helvetica" size:14];
    titleLabel_update.backgroundColor = [UIColor clearColor];
    titleLabel_update.textColor = [UIColor whiteColor];
    titleLabel_update.textAlignment = NSTextAlignmentCenter;
    titleLabel_update.text=@"Updating...";
    [self.view addSubview:titleLabel_update];
    
    
    UILabel *search = [[UILabel alloc]initWithFrame:CGRectMake (self.view.bounds.size.width-42, 23, 32, 32)];
    search.numberOfLines = 1;
    search.font=[UIFont fontWithName:@"Helvetica" size:16];
    search.backgroundColor = [UIColor clearColor];
    search.textColor = [UIColor whiteColor];
    search.textAlignment = NSTextAlignmentCenter;
    search.text=@"10 $";
    
  //  search.backgroundColor = [UIColor clearColor];
 //   search.layer.borderWidth = 0.5f;
//    search.layer.borderColor = [UIColor whiteColor].CGColor;
  //  search.layer.cornerRadius = 15.0f;
    
    
    [self.view addSubview:search];
    
    UIImageView *menu = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 30, 30)];
    menu.image = [UIImage imageNamed:@"person.png"];
    menu.image = [menu.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [menu setTintColor:[UIColor whiteColor]];
    [self.view addSubview:menu];


    
    
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    Viewbig = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [_ScrollView  setContentOffset:CGPointMake(0,0) animated:YES];
    [tv.scrollView setContentOffset:CGPointMake(tv.scrollView.contentInset.left, tv.scrollView.contentInset.top) animated:YES];
    
    
    _ScrollView.contentSize=CGSizeMake(screenFramec.size.width,Viewbig.frame.size.height+1);
    
  //  [_ScrollView setScrollEnabled:NO];
    _ScrollView.delaysContentTouches = YES;
    _ScrollView.delegate=self;
  //  _ScrollView.pagingEnabled = YES;
    
    
    
    
    [_ScrollView addSubview:Viewbig];
    [self.view addSubview:_ScrollView];
    
    
    
    _ScrollView.alwaysBounceVertical = YES;
    _ScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    Viewbig.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    // top
    tv = [_ScrollView addPullToRefreshPosition:AAPullToRefreshPositionTop actionHandler:^(AAPullToRefresh *v){[v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:2.0f];}];
    
    
    tv.fromLabel.text=@"pull to update headlines";
    tv.fromLabel.textColor=[UIColor whiteColor];
    tv.borderColor = [UIColor whiteColor];
    
    
    
    


    //------------------- Set Curl Page ----------
    
    [[pageViewController view] setFrame:CGRectMake(0,20,screenFramec.size.width,screenFramec.size.height+20)];
 
    
    ChildViewController *initialViewController = [self viewControllerAtIndex:WsApi.index_page-1];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:pageViewController];
    [_ScrollView addSubview:[pageViewController view]];
  //  [pageViewController didMoveToParentViewController:self];

    //--------------------------------------------
    //////////////////////////////////////////////
    //--------------------------------------------
    
    UIView *couverture = [[UIView alloc] initWithFrame:CGRectMake(0, 24, Viewbig.bounds.size.width, 40)];
    couverture.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:36.0f/255.0f blue:84.0f/255.0f alpha:1.0];


    
    //-------------------------------------
    viewWhite= [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    viewWhite.backgroundColor=[UIColor clearColor];
    [_ScrollView addSubview:viewWhite];
    
    CALayer * marker = [CALayer layer];
    [marker setBounds:CGRectMake(0, 0, kDefaultThickness, kDefaultLength)];
    [marker setCornerRadius:kDefaultThickness*0.5];
    [marker setBackgroundColor:[kDefaultColor CGColor]];
    [marker setPosition:CGPointMake(kDefaultHUDSide*0.5, kDefaultHUDSide*0.5+kDefaultSpread)];
    
    spinnerReplicator = [CAReplicatorLayer layer];
    [spinnerReplicator setBounds:CGRectMake(0, 0, kDefaultHUDSide, kDefaultHUDSide)];
    [spinnerReplicator setCornerRadius:10.0];
    [spinnerReplicator setBackgroundColor:[kDefaultHUDColor CGColor]];
    [spinnerReplicator setPosition:CGPointMake(CGRectGetMidX(_ScrollView.frame), CGRectGetMidY(_ScrollView.frame))];
    
    CGFloat angle = (2.0*M_PI)/(kDefaultNumberOfSpinnerMarkers);
    CATransform3D instanceRotation = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0);
    [spinnerReplicator setInstanceCount:kDefaultNumberOfSpinnerMarkers];
    [spinnerReplicator setInstanceTransform:instanceRotation];
    
    [spinnerReplicator addSublayer:marker];
    [_ScrollView.layer addSublayer:spinnerReplicator];
    
    [marker setOpacity:0.0];
    CABasicAnimation * fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [fade setFromValue:[NSNumber numberWithFloat:1.0]];
    [fade setToValue:[NSNumber numberWithFloat:0.0]];
    [fade setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [fade setRepeatCount:HUGE_VALF];
    [fade setDuration:kDefaultSpeed];
    CGFloat markerAnimationDuration = kDefaultSpeed/kDefaultNumberOfSpinnerMarkers;
    [spinnerReplicator setInstanceDelay:markerAnimationDuration];
    [marker addAnimation:fade forKey:kMarkerAnimationKey];
    
    
    UIButton *SettingClickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [SettingClickButton addTarget:self action:@selector(profile_droite:) forControlEvents:UIControlEventTouchUpInside];
    SettingClickButton.backgroundColor=[UIColor clearColor];
    [SettingClickButton setTitle:@"" forState:UIControlStateNormal];
    SettingClickButton.frame = CGRectMake(self.view.bounds.size.width-45, -21, 40, 40);
    SettingClickButton.tag = 12345;
    [_ScrollView addSubview:SettingClickButton];
    
    
    UIButton *refreshClickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [refreshClickButton addTarget:self action:@selector(profile_gauche:) forControlEvents:UIControlEventTouchUpInside];
    refreshClickButton.backgroundColor=[UIColor clearColor];
    [refreshClickButton setTitle:@"" forState:UIControlStateNormal];
    refreshClickButton.frame = CGRectMake(0, -21, 40, 40);
    refreshClickButton.tag = 6789;
    [_ScrollView addSubview:refreshClickButton];

    
    //---------------------------
  //  spinnerReplicator.hidden=true;viewWhite.hidden=true;
    
    //--------------------------
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataRecivedtNotification:)
                                                 name:@"dataRecived"
                                               object:nil];

    
   
    
  
   
    
}



- (void) dataRecivedtNotification:(NSNotification *) notification
{
    
    spinnerReplicator.hidden=true;viewWhite.hidden=true;
    //    NSLog(@"recoit notification    %d",WsApi.API_CategorieList.count);
    
    
  
    
    
    ChildViewController *viewController = [self.pageViewController.viewControllers lastObject];
    [viewController.collectionView reloadData];
    
    
    
    [tv.scrollView setContentOffset:CGPointMake(tv.scrollView.contentInset.left, -40) animated:YES];
    //  [_ScrollView setContentOffset:CGPointMake(_ScrollView.contentInset.left, -39) animated:YES];
    
}



-(void)viewDidAppear:(BOOL)animated
{
    [tv.scrollView setContentOffset:CGPointMake(tv.scrollView.contentInset.left, -40) animated:NO ];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}


- (void) displayReloadIndicator:(UIPanGestureRecognizer*) sender {
    
    //NSLog(@"cvcvcvcvcvcv");
  
  //  NSLog(@"ffffff %f", [sender locationInView:self.view].y);
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        startlocation = [sender locationInView:self.view];
    }
 /*   else if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint stopLocation = [sender locationInView:self.view];
        CGFloat dx = stopLocation.x - startlocation.x;
        CGFloat dy = stopLocation.y - startlocation.y;
        CGFloat distance = sqrt(dx*dx + dy*dy );
        NSLog(@"Distance: %f", distance);
    }*/

    
    
    CGPoint stopLocation = [sender locationInView:self.view];
    CGFloat dx = stopLocation.x - startlocation.x;
    CGFloat dy = (stopLocation.y - startlocation.y)/2;
    CGFloat distance = sqrt(dx*dx + dy*dy );
    NSLog(@"Distance: %f", dy);
    
    
    
    if(curl_test==1)
    {
        _ScrollView.contentOffset = CGPointMake(_ScrollView.contentOffset.x, -40);
        return;
    }
   
    
    
   if(distance>25)
   {
    if(_ScrollView.contentOffset.y<=0)
    {
       if (sender.state == UIGestureRecognizerStateEnded)
        {
            if(_ScrollView.contentOffset.y>-30)
                 [tv.scrollView setContentOffset:CGPointMake(tv.scrollView.contentInset.left, 0) animated:YES];
            else if (_ScrollView.contentOffset.y<=-40)
            {
                
              [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                    [tv.scrollView setContentOffset:CGPointMake(tv.scrollView.contentInset.left, -40) animated:YES ];
                } completion:^(BOOL finished) {
                    if(_ScrollView.contentOffset.y<=-90)[self Refresh];
                
                }];
            }
            
        }
        else
        {
            ChildViewController *viewController = [self.pageViewController.viewControllers lastObject];
            
            if(viewController.collectionView.contentOffset.y==0)
            {  _ScrollView.contentOffset = CGPointMake(_ScrollView.contentOffset.x, -40-dy);}
        }
    }
   }
    

    
    
    
/*    else
    {
        
       ChildViewController *viewController = [self.pageViewController.viewControllers lastObject];
        viewController.collectionView.contentOffset = CGPointMake(viewController.collectionView.contentOffset.x, dy);
    }
    */
}






- (void) receiveTestNotification:(NSNotification *) notification
{


    
    ChildViewController *viewController = [self.pageViewController.viewControllers lastObject];

    
    if (viewController.collectionView.contentOffset.y<=0 )
    {
        [viewController.collectionView setContentOffset: CGPointMake(viewController.collectionView.contentOffset.x,0)];
        
      //  viewController.collectionView.scrollEnabled = NO;
      //  viewController.collectionView.scrollEnabled = YES;
        
    }
    else
    {
 //       [tv.scrollView setContentOffset:CGPointMake(tv.scrollView.contentInset.left, 0) animated:NO];
    }


}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    titleLabel.hidden=true;titleLabel_update.hidden=true;
    if(scrollView.contentOffset.y<-50 && scrollView.contentOffset.y>-90)
        tv.fromLabel.text=@"pull to update headlines";
    else if(scrollView.contentOffset.y<=-90)
    {tv.fromLabel.text=@"Release to update";putit=1;}
    else if(scrollView.contentOffset.y>-50)
    {
        titleLabel.hidden=false;
        tv.fromLabel.text=@"";
    }
    

    
    if (scrollView.contentOffset.y>-40 )
    {
        [_ScrollView setContentOffset: CGPointMake(_ScrollView.contentOffset.x,-40)];

       // ChildViewController *viewController = [self.pageViewController.viewControllers lastObject];
       // [viewController.collectionView setContentOffset: CGPointMake(viewController.collectionView.contentOffset.x,0)];
      //  viewController.collectionView.scrollEnabled = true;
    }
    

/*

    if (scrollView.contentOffset.y==0)
    {
        scrollView.scrollEnabled=false;
        scrollView.scrollEnabled=true;
    }
    */
 
  
}





- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
  //  scrollView.scrollEnabled=false;
  //  scrollView.scrollEnabled=true;
    
    if(scrollView.contentOffset.y>-40)
    {
        [_ScrollView setContentOffset: CGPointMake(scrollView.contentOffset.x,-40)];
    }
    
    
    tv.fromLabel.text=@"";
    
    if (scrollView.contentOffset.y==-40)
    {
        
        if(putit==1){ titleLabel_update.hidden=false; titleLabel.hidden=true;}
        else { titleLabel_update.hidden=true; titleLabel.hidden=false;}
       
        ChildViewController *viewController = [self.pageViewController.viewControllers lastObject];
        [viewController.collectionView setContentOffset: CGPointMake(viewController.collectionView.contentOffset.x,0)];
     //   viewController.collectionView.scrollEnabled = NO;
        
        
        if(putit==1) [self Refresh];
    }

    
}


- (void)viewWillLayoutSubviews
{
    CGRect rect = _ScrollView.bounds;
    rect.size.height = _ScrollView.contentSize.height;
    Viewbig.frame = rect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return Viewbig;
}


-(void)Refresh
{
    
    if(tapped_status==1)
        return;
    
    tapped_status=1;

    AnimationPullView.alpha=1.0;
    CGRect Framen = AnimationPullView.frame;
    Framen.size.width = 0.0f;
    Framen.origin.x=0.0f;
    [AnimationPullView setFrame:Framen];

    //------------------------- animation ----------------------
    CABasicAnimation *resizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    [resizeAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(([UIScreen mainScreen].bounds.size.width*2+50)/4,[UIScreen mainScreen].bounds.size.height)]];
    resizeAnimation.fillMode = kCAFillModeForwards;
    resizeAnimation.removedOnCompletion = YES;
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:resizeAnimation,nil];
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion=NO;
    animationGroup.duration = 0.25;
    animationGroup.delegate = self;
    [animationGroup setValue:@"animations" forKey:@"animationName"];
    [AnimationPullView.layer addAnimation:animationGroup forKey:@"animations"];
    //----------------------------------------------------------
    
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished
{
    
    if (finished)
    {
        NSString *animationName = [animation valueForKey:@"animationName"];
        
        
        if ([animationName isEqualToString:@"animationsFin"])
        {
            titleLabel_update.hidden=true;
            titleLabel.hidden=false;
            tapped_status=0;
            CGRect Framen = AnimationPullView.frame;
            Framen.size.width = 0.0f;
            Framen.origin.x=0.0f;
            [AnimationPullView setFrame:Framen];
            [AnimationPullView.layer removeAllAnimations];

            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
        else if ([animationName isEqualToString:@"animations"])
        {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [[WebServiceApiManager getInstance] getAllStories:^(NSDictionary *jMarathons) {
               
            }];
            
            [[WebServiceApiManager getInstance] getAllCategories:^(NSDictionary *jMarathons) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //Your main thread code goes in here
                    NSLog(@"Im on the main thread");
                    
                    CGRect newFrame = AnimationPullView.frame;
                    newFrame.size.width = ([UIScreen mainScreen].bounds.size.width)/4;
                    [AnimationPullView setFrame:newFrame];
                    
                    
                    //------------------------- animation ----------------------
                    
                    CABasicAnimation *completeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
                    [completeAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*2,[UIScreen mainScreen].bounds.size.height)]];
                    completeAnimation.fillMode = kCAFillModeForwards;
                    completeAnimation.removedOnCompletion = NO;
                    
                    CAAnimationGroup *animationCompleteGroup = [CAAnimationGroup animation];
                    animationCompleteGroup.animations = [NSArray arrayWithObjects:completeAnimation,nil];
                    animationCompleteGroup.fillMode = kCAFillModeForwards;
                    animationCompleteGroup.removedOnCompletion=NO;
                    animationCompleteGroup.delegate = self;
                    animationCompleteGroup.duration = 0.5;
                    [animationCompleteGroup setValue:@"animationsFin" forKey:@"animationName"];
                    [AnimationPullView.layer addAnimation:animationCompleteGroup forKey:@"animationsFin"];
                    putit=0;
                    
                    ChildViewController *viewController = [self.pageViewController.viewControllers lastObject];
                    [viewController.collectionView reloadData];
                });
            }];
            
            
        }
        else
            
        {
            
            HomeViewController *theCurrentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
            theCurrentViewController.view.alpha=1;
           // self.view.userInteractionEnabled = YES;

        }
    }
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



- (ChildViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    /*    if (([self.pageContent count] == 0) ||
     (index >= [self.pageContent count])) {
     return nil;
     }*/
    
    
    
    
    // Create a new view controller and pass suitable data.
    ChildViewController *dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];
    
    dataViewController.dataObject =[self.pageContent objectAtIndex:index];
    
    
    
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController: ( ChildViewController *) viewController
{
    return [self.pageContent indexOfObject: viewController.dataObject];
}






- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
   
    
    
    if(WsApi.index_page==WsApi.API_CategorieList.count+1) return nil;
    
/*
    if(WsApi.index_page==6)
    {
    //    self.view.userInteractionEnabled = NO;
        
        ChildViewController *initialViewController = [self viewControllerAtIndex:0];
        NSArray *viewControllers5 = [NSArray arrayWithObject:initialViewController];
        
        
       // [UIView setAnimationsEnabled:NO];
        
        [self.pageViewController setViewControllers:viewControllers5 direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        
        //   [self addChildViewController:self.pageViewController];
        //   [Viewbig addSubview:[self.pageViewController view]];
        //   [self.pageViewController didMoveToParentViewController:self];

        
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.6f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        transition.delegate = self;
        [transition setValue:@"animations" forKey:@"right"];
        [Viewbig.layer addAnimation:transition forKey:@"animations"];
        [topTabScroll setContentOffset:CGPointMake(topTabScroll.contentInset.left, topTabScroll.contentOffset.y) animated:YES];
        
        
        UIButton *btn = (UIButton *)[Viewbig viewWithTag:1];
        btn.autoresizesSubviews = NO;
        btn.clipsToBounds = NO;
        btn.frame = CGRectMake(btn.frame.origin.x,0,btn.frame.size.width,38);
        [btn setTitleColor:[UIColor colorWithRed:214.0f/255.0f green:36.0f/255.0f blue:84.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        //-----------------------------------
        
        for (NSInteger j = 1; j <= 6; j++)
        {
            if (j!=1) {
                UIButton *btn = (UIButton *)[Viewbig viewWithTag:j];
                btn.autoresizesSubviews = NO;
                btn.clipsToBounds = NO;
                btn.frame = CGRectMake(btn.frame.origin.x,3,btn.frame.size.width,38);
                [btn setTitleColor:[UIColor colorWithRed:66.0f/255.0f green:66.0f/255.0f blue:66.0f/255.0f alpha:1] forState:UIControlStateNormal];
            }
        }

        
        WsApi.index_page=1;
        //    return nil;
    }
    */
 
    type=1;
    return [self viewControllerAtIndex:WsApi.index_page-1];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
