#import "DEMGameVM.h"

@interface DEMGameVM ()

@property (nonatomic, strong) DEMGameCore *gameCore;

@end

@implementation DEMGameVM

- (instancetype)init
{
	self = [super init];
	if (self) {
		_gameCore = [[DEMGameCore alloc] init];
		_storeVM = [[DEMStoreVM alloc] initWithMotherShipVM:_gameCore.motherShip];
	}
	return self;
}

- (DEMMotherShipVM *)motherShipVM
{
	return _gameCore.motherShip;
}

//- (DEMStoreVM *)storeVM
//{
//	return _gameCore;
//}

@end
