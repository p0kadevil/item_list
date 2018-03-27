//
//  ViewController.m
//  ItemList
//
//  Created by Christopher Ebert on 27.03.18.
//  Copyright © 2018 Privat. All rights reserved.
//

#import "ItemListViewController.h"
#import "AppDelegate.h"

@interface ItemListViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ItemListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = [DBManager getItemsWithContext:[self getContext]];
    
    if(self.items.count <= 0)
    {
        [self fetchItemsFromNetworkAndPersist];
    }
    else
    {
        [self.itemTableView reloadData];
    }
}

- (void) fetchItemsFromNetworkAndPersist
{
    [self showActivity];
    
    __weak ItemListViewController *weakSelf = self;
    [RestManager getItemListWithSuccess:^(NSDictionary *result){
        
        [weakSelf hideActivty];
        
        if(result)
        {
            for(NSDictionary *item in result[@"items"])
            {
                [weakSelf.items addObject:item];
                [DBManager insertItem:item withContext:[self getContext]];
            }
            
            [weakSelf.itemTableView reloadData];
        }
        
    } andFailure:^(NSError *error){
        
        [weakSelf hideActivty];
    }];
}

- (void) showActivity
{
    self.activityView.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void) hideActivty
{
    self.activityView.hidden = YES;
    [self.activityIndicator stopAnimating];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item_reuse_id"];
    
    NSString *itemName = self.items[indexPath.row][@"name"];
    int itemNumber = [self.items[indexPath.row][@"no"] intValue];
    double price = [self.items[indexPath.row][@"price"] doubleValue];
    NSString *expires = self.items[indexPath.row][@"expires"];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ (No. %i)", itemName, itemNumber];
    cell.dateLabel.text = expires;
    cell.priceLabel.text = [NSString stringWithFormat:@"%.02f €", price];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSManagedObjectContext *) getContext
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate.persistentContainer.viewContext;
}

@end
