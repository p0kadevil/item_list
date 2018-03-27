//
//  DBManager.m
//  ItemList
//
//  Created by Christopher Ebert on 27.03.18.
//  Copyright © 2018 Privat. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+ (bool) insertItem:(NSDictionary *)itemDict
        withContext:(NSManagedObjectContext *)context
{
    long currentTimestamp = [[NSDate date] timeIntervalSince1970];
    
    NSString *itemName = itemDict[@"name"];
    int itemNumber = [itemDict[@"no"] intValue];
    double price = [itemDict[@"price"] doubleValue];
    long validUntil = [itemDict[@"expires"] longValue] + currentTimestamp;
    
    NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
    [newItem setValue:itemName forKey:@"name"];
    [newItem setValue:[NSNumber numberWithInt:itemNumber] forKey:@"no"];
    [newItem setValue:[NSNumber numberWithDouble:price] forKey:@"price"];
    [newItem setValue:[NSNumber numberWithLong:validUntil] forKey:@"valid_until"];
    
    NSError *error = nil;
    return [context save:&error];
}

+ (NSMutableArray *) getItemsWithContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    NSMutableArray *items = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSMutableArray *finalItems = [NSMutableArray new];
    
    for(NSManagedObject *obj in items)
    {
        [finalItems addObject:[DBManager itemToDict:obj]];
    }
    
    return finalItems;
}

+ (NSDictionary *) itemToDict:(NSManagedObject *)item
{
    NSString *name = [item valueForKey:@"name"];
    NSNumber *price = [item valueForKey:@"price"];
    NSNumber *validUntil = [item valueForKey:@"valid_until"];
    NSNumber *no = [item valueForKey:@"no"];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", price, @"price", validUntil, @"expire", no, @"no", nil];
}

@end
