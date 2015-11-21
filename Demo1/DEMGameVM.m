#import "DEMGameVM.h"

@interface DEMGameVM ()

@property (nonatomic, strong) DEMGameCore *gameCore;

@end

@implementation DEMGameVM

- (instancetype)init
{
	self = [super init];
	if (self) {
		DEMMotherShipVM *motherShip = [[DEMMotherShipVM alloc] init];
		DEMBattleEngine *battleEngine = [[DEMBattleEngine alloc] init];
		DEMWaveEngine *waveEngine = [[DEMWaveEngine alloc] init];

		_gameCore = [[DEMGameCore alloc] initWithMotherShip:motherShip
											   battleEngine:battleEngine
												 waveEngine:waveEngine];
		
		_storeVM = [[DEMStoreVM alloc] initWithMotherShipVM:motherShip];
	}
	return self;
}

- (DEMMotherShipVM *)motherShipVM
{
	return self.gameCore.motherShip;
}

//- (DEMStoreVM *)storeVM
//{
//	return _gameCore;
//}

@end
