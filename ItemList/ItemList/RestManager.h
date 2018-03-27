//
//  RestManager.h
//  ItemList
//
//  Created by Christopher Ebert on 27.03.18.
//  Copyright © 2018 Privat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLSessionManager.h"
#import "Constants.h"

@interface RestManager : NSObject

+ (void) getItemListWithSuccess:(void(^) (NSDictionary * successDict)) successBlock
                     andFailure:(void(^) (NSError * failureDict)) failureBlock;

@end
