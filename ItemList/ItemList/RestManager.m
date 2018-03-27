//
//  RestManager.m
//  ItemList
//
//  Created by Christopher Ebert on 27.03.18.
//  Copyright © 2018 Privat. All rights reserved.
//

#import "RestManager.h"

@implementation RestManager

+ (void) getItemListWithSuccess:(void(^) (NSDictionary * successDict)) successBlock
                     andFailure:(void(^) (NSError * failureDict)) failureBlock
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURL *URL = [NSURL URLWithString:kItemListUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                    
                                                    if (error)
                                                    {
                                                        failureBlock(error);
                                                    }
                                                    else
                                                    {
                                                        NSError *error;
                                                        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                                                        
                                                        if(!error)
                                                        {
                                                            successBlock(jsonDict);
                                                        }
                                                        else
                                                        {
                                                            failureBlock(error);
                                                        }
                                                    }
                                                }];
    
    [dataTask resume];
}

@end
