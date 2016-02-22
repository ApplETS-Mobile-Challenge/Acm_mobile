//
//  SecondContentViewController.m
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import "SecondContentViewController.h"
#import "UIImage+BezierPath.h"
#import "QuartzCore/CALayer.h"
#import "WebServiceApiManager.h"
#import "company.h"
#import "question.h"


@interface SecondContentViewController ()<UIScrollViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{

    UILabel * date_desc;
     WebServiceApiManager *WsApi;
}

@end

@implementation SecondContentViewController
UIScrollView *_scroll_horisantal;






- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    // -------------------Ombre page ---------------------------------
    UIView * Ombre=[[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    Ombre.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.2];
    [self.view addSubview:Ombre];
    //------------------- Scroll horisantal ------------------------------
    
    _scroll_horisantal = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    _scroll_horisantal.tag=007;
    _scroll_horisantal.delegate=self;
    
    
    //------------------------------- content -------------------------

    
    
    company *aStory = [WsApi.API_SurvayList objectAtIndex:WsApi.index_page];
    NSMutableArray *questions =aStory.question;
    NSLog(@"question number %d",aStory.question.count);
    UIView *view1;
    for(int i=0; i<10; i++)
    {
        
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0,0.0f,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
 
        
    //-------------------- question label -----------------------------
        
        date_desc=[[UILabel alloc]initWithFrame:CGRectMake(20+[UIScreen mainScreen].bounds.size.width*i,[UIScreen mainScreen].bounds.size.height/2-100, [UIScreen mainScreen].bounds.size.width-40, 300)];
        [date_desc setTextColor:[UIColor whiteColor]];
        [date_desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:25]];
        

        question *aBook = [questions objectAtIndex:i];

        
        
        
        if(i==0)date_desc.text=@"Do you have cable connection?";
        if(i==1)date_desc.text=@"Were you satisfied with the speed of the service?";
        if(i==2)date_desc.text=@"Did you faced slow internet speeds problem, disconnections and drop-outs on the service side?";
        if(i==3)date_desc.text=@"Did you faced problems with wireless router?";
        if(i==4)date_desc.text=@"Do you have cable connection?";
        if(i==5)date_desc.text=@"Were you satisfied with the speed of the service?";
        if(i==6)date_desc.text=@"Did you faced slow internet speeds problem, disconnections and drop-outs on the service side?";
        if(i==7)date_desc.text=@"Did you faced problems with wireless router?";
        if(i==8)date_desc.text=@"Do you have cable connection?";
        if(i==9)date_desc.text=@"Were you satisfied with the speed of the service?";
    
        
    
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize = [date_desc.text sizeWithFont:date_desc.font constrainedToSize:maximumLabelSize lineBreakMode:date_desc.lineBreakMode];

        CGRect newFrame = date_desc.frame;
        newFrame.size.height = expectedLabelSize.height;
        date_desc.frame = newFrame;
        date_desc.textAlignment = NSTextAlignmentJustified;
        
        
        
        NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
        paragraphStyles.alignment = NSTextAlignmentJustified;      //justified text
        paragraphStyles.firstLineHeadIndent = 10.0;                //must have a value to make it work
        
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyles};
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString: @"Un peu d'air. De l'air! De l'air! C'est juste une question de survie.Coralie J'en ai assez. De scotcher devant la télé. J'ai besoin. D'un peu plus de fun?" attributes: attributes];
        
        date_desc.attributedText = attributedString;
        
        date_desc.numberOfLines=10;
        
       //-------------------- Response -----------------------------
        
        
        
        UIImageView *im_rep1 = [[UIImageView alloc]initWithFrame:CGRectMake(20+[UIScreen mainScreen].bounds.size.width/2-90+[UIScreen mainScreen].bounds.size.width*i, date_desc.frame.origin.y+date_desc.frame.size.height+30, 70, 70)];
        im_rep1.image = [UIImage imageNamed:@"dislike.png"];
        im_rep1.image = [im_rep1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [im_rep1 setTintColor:[UIColor colorWithRed:24.0f/255.0f green:85.0f/255.0f blue:43.0f/255.0f alpha:0.9]];
        
        im_rep1.backgroundColor = [UIColor clearColor];
        im_rep1.layer.borderWidth = 1.f;
        im_rep1.layer.borderColor = [UIColor whiteColor].CGColor;
        im_rep1.layer.cornerRadius = 15.0f;
        
        [view1 addSubview:im_rep1];
        
    
        
        UIImageView *im_rep2 = [[UIImageView alloc]initWithFrame:CGRectMake(20+im_rep1.frame.origin.x+im_rep1.frame.size.width, date_desc.frame.origin.y+date_desc.frame.size.height+30, 70, 70)];
        im_rep2.image = [UIImage imageNamed:@"like.png"];
        im_rep2.image = [im_rep2.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [im_rep2 setTintColor:[UIColor colorWithRed:195.0f/255.0f green:25.0f/255.0f blue:6.0f/255.0f alpha:0.9]];
        
        im_rep2.backgroundColor = [UIColor clearColor];
        im_rep2.layer.borderWidth = 1.f;
        im_rep2.layer.borderColor = [UIColor whiteColor].CGColor;
        im_rep2.layer.cornerRadius = 15.0f;
        
        [view1 addSubview:im_rep2];
        
       

        //------------------------------ Page -------------------------------
        
        UILabel  *page =[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i,[UIScreen mainScreen].bounds.size.height/2-170, [UIScreen mainScreen].bounds.size.width, 50)];
        [page setTextColor:[UIColor whiteColor]];
        [page setFont:[UIFont fontWithName:@"HelveticaNeue" size:30]];
        page.text=[NSString stringWithFormat:@"Question %d :",i+1];
        page.textAlignment=NSTextAlignmentCenter;
   //     page.backgroundColor = [UIColor clearColor];
    //    page.layer.borderWidth = 1.f;
    //    page.layer.borderColor = [UIColor whiteColor].CGColor;
    //    page.layer.cornerRadius = 15.0f;
        
        
        [view1 addSubview:page];
        [view1 addSubview:date_desc];

    [_scroll_horisantal addSubview:view1];
    }
    
   
    
    

  
 
    
    
    
    _scroll_horisantal.contentSize =CGSizeMake(view1.frame.size.width * 10, view1.frame.size.height);
    _scroll_horisantal.pagingEnabled = YES;
    
    [self.view addSubview:_scroll_horisantal];
    
    

    
    
   
    
    
    
    

}







-(void) back:(UIButton*)sender
{
    
    [_scroll_horisantal  setContentOffset:CGPointMake(0,0) animated:YES];
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(scrollView.tag==007)
    {
      for (UIView *subView in self.view.subviews)
      {
        if (subView.tag == 909)
        {
            [subView removeFromSuperview];
        }
      }
    }
    else
    {
        NSLog(@"--  %f",scrollView.contentOffset.y);
        NSLog(@"++  %f",[UIScreen mainScreen].bounds.size.height/3);
        
        if (scrollView.contentOffset.y<=1) {
            
            for (UIView *subView in self.view.subviews)
            {
                if (subView.tag == 909)
                {
                    [subView removeFromSuperview];
                }
            }
        }
        
  
    
    }
  

    }
    
   


@end
