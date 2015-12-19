#import "DEMStoreStuffBuy.h"

#import "DEMActionExchangeProtocol.h"
#import "DEMGravizzappa.h"

@implementation DEMStoreStuffBuy

@synthesize items = _items;
@dynamic visitor;
//#warning exchangableItems
//@dynamic exchangableItems;

- (instancetype)initWithVisitor:(id<DEMActionExchangeProtocol, DEMVisitorProtocol>)visitor {
	self = [super initWithVisitor:visitor];
	if (self == nil) return nil;

	_items = @[
			   [[DEMGravizzappa alloc] init],
			   ];

	return self;
}

- (NSString *)title {
	return NSLocalizedString(@"Shop", @"");
}

- (BOOL)canProcessVisitor {
	NSCAssert(NO, @"implement this method in subclass");
	return NO;
}

- (void)processItemAtIndex:(NSInteger)index {
	NSCAssert(NO, @"implement this method in subclass");
}

@end
