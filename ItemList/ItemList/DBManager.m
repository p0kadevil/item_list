//
//  DBManager.m
//  ItemList
//
//  Created by Christopher Ebert on 27.03.18.
//  Copyright © 2018 Privat. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

+ (bool) insertItem:(NSDictionary *)itemDict
{
    NSManagedObjectContext *context = [DBManager managedObjectContext];
    
    NSString *itemName = itemDict[@"name"];
    int itemNumber = [itemDict[@"no"] intValue];
    double price = [itemDict[@"price"] doubleValue];
    NSString *expires = itemDict[@"expires"];
    
    NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
    [newItem setValue:itemName forKey:@"name"];
    [newItem setValue:[NSNumber numberWithInt:itemNumber] forKey:@"no"];
    [newItem setValue:[NSNumber numberWithDouble:price] forKey:@"price"];
    [newItem setValue:expires forKey:@"expire"];
    
    NSError *error = nil;
    return [context save:&error];
}

+ (NSMutableArray *) getItems
{
    NSManagedObjectContext *managedObjectContext = [DBManager managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    return [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

@end
