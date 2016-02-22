//
//  ChildViewController.m
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import "ChildViewController.h"
#import "WebServiceApiManager.h"
#import "CollectionViewCell.h"
#import "image-color.h"
#import "SDWebImageManager.h"
#import "company.h"
#import "StoryCoverViewController.h"



@interface ChildViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    WebServiceApiManager *WsApi;
}

@end

@implementation ChildViewController
CGRect screenFrame;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WsApi= [WebServiceApiManager getInstance];
    screenFrame = [UIScreen mainScreen].applicationFrame;
    
    
    //------------------ Curl page ------------------

    self.view.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0];
    
    //-------------------- Search -----------
    
   UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10,10,screenFrame.size.width-20,30)];
    searchBar.barTintColor = [UIColor whiteColor];
    
    [searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    
    
    [self.view addSubview:searchBar];
    
    //------------------------ Collection ------------------
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(3,searchBar.frame.origin.y+searchBar.frame.size.height+3,screenFrame.size.width,self.view.frame.size.height-(searchBar.frame.origin.y+searchBar.frame.size.height)-70) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[CollectionViewCell class]forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView.scrollEnabled=YES;
    _collectionView.backgroundColor=[UIColor clearColor];
    
    
    
    [self.view addSubview:_collectionView];
    
  


}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
  //  NSLog(@"intern   %f",scrollView.contentOffset.y);
    
    WsApi.ScrollTopNotif=scrollView.contentOffset.y;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:self];
    
  /*  if (scrollView.contentOffset.y<0 )
    {
        [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x,0)];
        scrollView.scrollEnabled = NO;
    }
    
*/

    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
   // scrollView.scrollEnabled=false;
   // scrollView.scrollEnabled=true;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
   // scrollView.scrollEnabled=false;
   // scrollView.scrollEnabled=true;
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
   // scrollView.scrollEnabled=false;
   // scrollView.scrollEnabled=true;
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
 
    
     return WsApi.API_SurvayList.count;
    
    
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CollectionViewCell *cel = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    
    if (cel == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[CollectionViewCell class]])
            {
                cel = (CollectionViewCell *)currentObject;
                break;
            }
        }
    }
    cel.backgroundColor=[UIColor whiteColor];
    
    
    company *aStory = [WsApi.API_SurvayList objectAtIndex:indexPath.row];


    [cel.im setImage:[UIImage imageNamed:@"img4.jpg"]];
    cel.Label.text= [NSString stringWithFormat:@"%@ $",aStory.price];
    
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.7];
    
    cel.im.image = [UIImage imageWithColor:color];
    
    cel.layer.borderColor = [UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1.0f].CGColor;
    cel.layer.borderWidth = 0.3f;
    
    [cel.im setClipsToBounds:YES];


    
    NSString *url=[NSString stringWithFormat:@"http://wiinz.com/amcProject/%@",aStory.image];

    dispatch_queue_t myqueue = dispatch_queue_create("myqueue", NULL);
    // execute a task on that queue asynchronously
    dispatch_async(myqueue, ^{
        
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
         {}
        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                          if (image)
                                                          {
                                                              if ([[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:url]])
                                                              {
                                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                                      cel.im.image=image;
                                                                  });
                                                              }
                                                              else
                                                              {
                                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                                      cel.im.image=image;
                                                                      CATransition *transition = [CATransition animation];
                                                                      transition.duration = 0.5f;
                                                                      transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                                                                      transition.type = kCATransitionFade;
                                                                      [cel.im.layer addAnimation:transition forKey:nil];
                                                                  });
                                                              }
                                                          }
                                                      }];
        
    });
    
      
    return cel;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(screenFrame.size.width/2-18.0f, screenFrame.size.width/2-18.0f+25);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_collectionView performBatchUpdates:nil completion:nil];
}


- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(6, 9, 6, 9); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12.0;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
 

    WsApi.index_page=indexPath.row;

    
    StoryCoverViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryCoverViewController"];
    
    
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



@end
