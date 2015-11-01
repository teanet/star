//
//  DEMGravizappa.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "DEMGravizappa.h"

@implementation DEMGravizappa

@synthesize name = _name;
@synthesize price = _price;

- (instancetype)init
{
	self = [super init];
	if (self) {
		NSLocalizedString(@"", @"");
		_name = NSLocalizedString(@"Гравицаппа", @"");
		_price = 500.0;
	}
	return self;
}

@end
