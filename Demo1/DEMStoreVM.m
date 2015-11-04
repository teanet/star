#import "DEMStoreVM.h"
#import "DEMGravizzappa.h"
#import "DEMMotherShipVM.h"
#import "DEMGravizzappa.h"

@implementation DEMStoreVM {
	NSMutableArray<NSObject<DEMStoreItem> *> *_items;
	DEMGravizzappa *_gravizzappa;
}

@synthesize items=_items;

- (instancetype)initWithMotherShipVM:(DEMMotherShipVM *)motherShipVM
{
	self = [super init];
	if (self == nil) return nil;

	_items = [NSMutableArray array];
	_motherShipVM = motherShipVM;
	[_items addObject:[DEMGravizzappa new]];

	return self;
}

- (BOOL)canPurchaseItem:(NSObject<DEMStoreItem> *)storeItem {
	return [_motherShipVM.warehouse hasEnegry:storeItem.price];
}

- (void)installItem:(NSObject<DEMStoreItem> *)storeItem {
	if ([storeItem isKindOfClass:[DEMGravizzappa class]]) {
		_gravizzappa = (DEMGravizzappa *)storeItem;
		NSLog(@"Gravizappa has been bought!");

		[self.motherShipVM installGravizzappa:_gravizzappa];
	}
}

@end
