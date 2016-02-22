//
//  WebServiceApiManager.h
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import <Foundation/Foundation.h>






//--------- API GET ALL Survay --------------------------------------
#define API_URI_GET_ALL_survay  @"http://wiinz.com/amcProject/api/surveys/dispo/1"



@interface WebServiceApiManager : NSObject
{
    //--------- API Response -----------------------------------------

    int index_page,index_collection_shoosen;
    NSMutableArray *API_SurvayList;
}


@property(nonatomic,retain)NSMutableArray *API_SurvayList;


@property (nonatomic, assign) int index_page;
@property (nonatomic, assign) int scroled;
@property (nonatomic, assign) int second_page_scroll;
@property (nonatomic, assign) int index_collection_shoosen;
@property (nonatomic, assign) float ScrollTopNotif;

//-------- Singloton-----------------
+(WebServiceApiManager*)getInstance;

-(void)getAllSurvay :(void (^)( NSDictionary * jMarathons))completionBlock;


@end
