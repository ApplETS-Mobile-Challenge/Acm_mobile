//
//  WebServiceApiManager.m
//  Onus
//
//  Created by User on 2016-02-2.
//  Copyright © 2015 Mahdi ELARBI. All rights reserved.
//

#import "WebServiceApiManager.h"
#import "AppDelegate.h"

#import "survay.h"
#import "company.h"
#import "question.h"
//#import "ASIHTTPRequest.h"

@implementation WebServiceApiManager
@synthesize index_page;
AppDelegate *appDelegateWS;
static WebServiceApiManager *instance = nil;

+(WebServiceApiManager *)getInstance
{
    
    @synchronized(self)
    {
        if(instance==nil)
        {
            appDelegateWS=  (AppDelegate*)[[UIApplication sharedApplication] delegate];
            instance= [WebServiceApiManager new];
            
        }
    }
    return instance;
}



-(void)getAllSurvay :(void (^)( NSDictionary * jMarathons))completionBlock{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:API_URI_GET_ALL_survay]];
    
    [request setHTTPMethod:@"GET"];
    
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: queue
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error || !data)
         {
             NSLog(@"Get Login Authentification Error : %@", error);
             dispatch_async(dispatch_get_main_queue(), ^{
                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please verify you internet conenction" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alert show];
             });
         }
         else
         {
             NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
             
             _API_SurvayList = [[NSMutableArray alloc] init];
             
    
             for (NSDictionary *stateDict in jsonObjects)
             {
                 NSDictionary *result = [stateDict objectForKey:@"company"];
                 
                company *response = [[company alloc] init];
                 response.image=[result objectForKey:@"img"];
                 response.price=[stateDict objectForKey:@"price"];
                 
           
                
                     NSDictionary *resultquest = [stateDict objectForKey:@"questions"];
                 
           NSMutableArray  *questionList = [[NSMutableArray alloc] init];
                 
                 for (NSDictionary *state in resultquest)
                 {
                     
                     
                  //    NSLog(@"-----------0      %@ ",[state objectForKey:@"libelle"]);
                     
                     question *respo = [[question alloc] init];
                     respo.libelé=[state objectForKey:@"libelle"];
                     [questionList addObject:respo];
                     
                 //    NSLog(@"input  %@",respo.libelé);
                     
                 }
                 
             
                 
                 
                 
                 
                 
                // response.question= [[NSMutableArray alloc] init];
                response.question=questionList;
                 
              
                 
                 
                 [_API_SurvayList addObject:response];
                 
                 
                // company *aStory = [API_SurvayList objectAtIndex:0];
                 
             
             }
             
             NSLog(@"nnnn  %d",API_SurvayList.count);
             
             for(int i=0; i<API_SurvayList.count;i++)
             {
               company *aStory = [API_SurvayList objectAtIndex:i];
               NSLog(@"nobre de question   %d",aStory.question.count);
             }
             
             
             
            // NSMutableArray *questions =aStory.question;
           //  question *q = [questions objectAtIndex:0];
              //   NSLog(@"question number %@",aStory.price);
             
             completionBlock(jsonObjects);
         }
     }];

}




@end
