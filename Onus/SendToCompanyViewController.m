//
//  SendToCompanyViewController.m
//  challenge
//
//  Created by User on 2016-02-13.
//  Copyright © 2016 Mahdi ELARBI. All rights reserved.
//

#import "SendToCompanyViewController.h"

@interface SendToCompanyViewController ()<UIPickerViewDelegate>

@end

@implementation SendToCompanyViewController


UITextField *myTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *blurBG = [[UIImageView alloc] initWithFrame:self.view.bounds];
    blurBG.contentMode = UIViewContentModeScaleAspectFill;
    blurBG.image = [UIImage imageNamed:@"blur_BG.png"];
    [self.view addSubview:blurBG];
    
    
    
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
    
    
    
    UILabel *argent = [[UILabel alloc]initWithFrame:CGRectMake (0, 100, [UIScreen mainScreen].bounds.size.width, 40)];
    argent.numberOfLines = 1;
    argent.font=[UIFont fontWithName:@"Helvetica" size:40];
    argent.backgroundColor = [UIColor clearColor];
    argent.textColor = [UIColor whiteColor];
    argent.textAlignment = NSTextAlignmentCenter;
    argent.text=@"10 $";
    [self.view addSubview:argent];
    
    
    
    
    
    
    UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 500)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:myPickerView];
    
    
    
    [myPickerView selectRow:9 inComponent:0 animated:NO];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    int selectedRow = (int)[pickerView selectedRowInComponent:0];
    NSLog(@"%i",selectedRow);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm to offer money"
                                                    message:@"Please choose the price that do you want to offer"
                                                   delegate:self
                                          cancelButtonTitle:@"Done"
                                          otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%@", [alertView textFieldAtIndex:0].text);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 20;
    
    return numRows;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"Walmart walmart walmart";
    
    
    if(component==0)title = @"Hypertention Canada";
    if(component==1)title = @"SPA de qeubec";
    if(component==2)title = @"La sociéte de l’arthrite";
    if(component==3)title = @"Fondation canadienne du concer du sein";
    if(component==4)title = @"Foundation fighting blindess";
    if(component==5)title = @"Alzhymer society";
   
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}


// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [@"" stringByAppendingFormat:@"%d",row];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
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
