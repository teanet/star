//
//  DEMGameVM.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "DEMGameVM.h"

@implementation DEMGameVM

- (instancetype)init
{
	self = [super init];
	if (self) {
		_motherShipVM = [DEMMotherShipVM new];
		_storeVM = [[DEMStoreVM alloc] initWithMotherShipVM:_motherShipVM];
	}
	return self;
}

@end
