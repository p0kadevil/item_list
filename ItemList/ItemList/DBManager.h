//
//  DBManager.h
//  ItemList
//
//  Created by Christopher Ebert on 27.03.18.
//  Copyright © 2018 Privat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBManager : NSObject

+ (bool) insertItem:(NSDictionary *)itemDict
        withContext:(NSManagedObjectContext *)context;
+ (NSMutableArray *) getItemsWithContext:(NSManagedObjectContext *)context;

@end
