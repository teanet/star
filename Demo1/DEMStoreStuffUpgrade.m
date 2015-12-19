#import "DEMStoreStuffUpgrade.h"

#import "DEMGravizzappa.h"

@implementation DEMStoreStuffUpgrade

@dynamic visitor;
@synthesize items = _items;

- (instancetype)initWithVisitor:(id<DEMActionUpgradeProtocol, DEMVisitorProtocol>)visitor {
	self = [super initWithVisitor:visitor];
	if (self == nil) return nil;

	NSArray<DEMUUID *> *visitorUUIDs = [visitor allUUIDs];
	NSMutableArray<DEMBaseItem *> *upgradableItems = [NSMutableArray array];

	[visitorUUIDs enumerateObjectsUsingBlock:^(DEMUUID *uuid, NSUInteger idx, BOOL *_) {
		DEMBaseItem *item = [visitor itemWithUUID:uuid];
		if ([item conformsToProtocol:@protocol(DEMEntityUpgradableProtocol)]) {
			[upgradableItems addObject:item];
		}
	}];

	_items = [upgradableItems copy];

	return self;
}

- (NSString *)title {
	return NSLocalizedString(@"Workshop", @"");
}

- (BOOL)canProcessVisitor {
	return YES;
}

- (void)processItemAtIndex:(NSInteger)index {
	id<DEMEntityUpgradableProtocol> item = self.items[index];
	[item upgrade];
}

@end
