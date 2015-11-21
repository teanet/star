//
//  DEMWarehouseVM.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "DEMWarehouseVM.h"

@interface DEMWarehouseVM ()


@end

@implementation DEMWarehouseVM {
	NSMutableSet<id<DEMWarehouseItem>> *_items;
}

@synthesize items=_items;

- (instancetype)init {
	self = [super init];
	if (self == nil) return nil;

	_items = [NSMutableSet set];
	_capacity = 100;

	return self;
}

- (void)storeItem:(NSObject<DEMWarehouseItem> *)item {
	if (self.items.count < self.capacity) {
		NSLog(@"%@ has been stored", item.name);
		[_items addObject:item];
	}
	else {
		NSLog(@"Storehouse is full, %@ has been dropped", item.name);
	}
}

- (BOOL)hasEnegry:(double)enegry {
	__block double currentEnergy = 0.0;
	[self.items enumerateObjectsUsingBlock:^(NSObject<DEMWarehouseItem> *obj, BOOL *stop) {
		currentEnergy += obj.capacity;
	}];
	return currentEnergy > enegry;
}

@end
