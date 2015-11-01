//
//  DEMStoreVC.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "DEMStoreVC.h"
#import "DEMStoreVM.h"
#import "DEMStoreItemCell.h"
#import "DEMStoreVM.h"

@interface DEMStoreVC ()

@property (nonatomic, strong, readonly) DEMStoreVM *storeVM;


@end

@implementation DEMStoreVC

- (instancetype)initWithStoreVM:(DEMStoreVM *)storeVM 
{
	self = [super init];
	if (self == nil) return nil;
	_storeVM = storeVM;
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.tableView registerClass:[DEMStoreItemCell class] forCellReuseIdentifier:@"DEMStoreItemCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storeVM.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DEMStoreItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DEMStoreItemCell"];
	NSObject<DEMStoreItem> *item = self.storeVM.items[indexPath.row];
	cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	NSObject<DEMStoreItem> *item = self.storeVM.items[indexPath.row];
	if ([self.storeVM canPurchaseItem:item]) {
		[self.storeVM installItem:item];
	}
	else {
		[[[UIAlertView alloc] initWithTitle:@"Not enogh founds" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
	}
}

@end
