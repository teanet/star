//
//  DEMStoreVM.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "DEMStoreVM.h"
#import "DEMGravizappa.h"
#import "DEMMotherShipVM.h"
#import "DEMGravizappa.h"

@implementation DEMStoreVM {
	NSMutableArray<NSObject<DEMStoreItem> *> *_items;
	DEMMotherShipVM *_motherShipVM;
	DEMGravizappa *_gravizappa;
}

@synthesize items=_items;

- (instancetype)initWithMotherShipVM:(DEMMotherShipVM *)motherShipVM
{
	self = [super init];
	if (self == nil) return nil;

	_items = [NSMutableArray array];
	_motherShipVM = motherShipVM;
	[_items addObject:[DEMGravizappa new]];

	return self;
}

- (BOOL)canPurchaseItem:(NSObject<DEMStoreItem> *)storeItem {
	return [_motherShipVM.warehouse hasEnegry:storeItem.price];
}

- (void)installItem:(NSObject<DEMStoreItem> *)storeItem {
	if ([storeItem isKindOfClass:[DEMGravizappa class]]) {
		_gravizappa = (DEMGravizappa *)storeItem;
		NSLog(@"Gravizappa installed");
	}
}

@end
