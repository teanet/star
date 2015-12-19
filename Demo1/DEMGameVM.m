#import "DEMGameVM.h"

#import "DEMStoreStuffBuy.h"
#import "DEMStoreStuffUpgrade.h"

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

		DEMStoreStuffBuy *shop = [[DEMStoreStuffBuy alloc] initWithVisitor:motherShip];
		DEMStoreStuffUpgrade *workshop = [[DEMStoreStuffUpgrade alloc] initWithVisitor:motherShip];

		_storeVM = [[DEMStoreVM alloc] initWithVisitor:motherShip places:@[shop, workshop]];
	}
	return self;
}

- (DEMMotherShipVM *)motherShipVM {
	return self.gameCore.motherShip;
}

@end
