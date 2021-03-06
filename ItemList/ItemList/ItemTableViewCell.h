//
//  ItemTableViewCell.h
//  ItemList
//
//  Created by Christopher Ebert on 27.03.18.
//  Copyright © 2018 Privat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
