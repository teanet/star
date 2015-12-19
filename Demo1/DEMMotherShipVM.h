#import "DEMWarehouseVM.h"
#import "DEMBattleProtocol.h"
#import "DEMClockEngineProtocol.h"
#import "DEMStuffProtocol.h"
#import "DEMActionExchangeProtocol.h"
#import "DEMActionUpgradeProtocol.h"
#import "DEMVisitorProtocol.h"

@interface DEMMotherShipVM : NSObject
<
DEMBattleProtocol,
DEMVisitorProtocol,
DEMClockEngineProtocol,
DEMActionExchangeProtocol,
DEMActionUpgradeProtocol
>

@property (nonatomic, assign) double currentEnergyLevel;
@property (nonatomic, assign) double extraEnergyLevel;

@property (nonatomic, strong, readonly) DEMWarehouseVM *warehouse;
@property (nonatomic, strong, readonly) NSArray *installedItems;
@property (nonatomic, assign, readonly) double maxEnergyLevel;

- (BOOL)installStuff:(id)stuff;

@end
