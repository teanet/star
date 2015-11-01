//
//  DEMStoreItemCell.h
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DEMStoreItem.h"

@interface DEMStoreItemCell : UITableViewCell

@property (nonatomic, strong) NSObject<DEMStoreItem> *item;

@end
