//
//  DEMStoreItemCell.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "DEMStoreItemCell.h"

@implementation DEMStoreItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
	return self;
}

- (void)setItem:(NSObject<DEMStoreItem> *)item {
	_item = item;
	self.textLabel.text = item.name;
	self.detailTextLabel.text = [NSString stringWithFormat:@"%.0f", item.price];
}

@end
