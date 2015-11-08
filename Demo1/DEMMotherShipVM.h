
#import "DEMEnergyCellModel.h"
#import "DEMWarehouseVM.h"
#import "DEMBattleProtocol.h"
#import "DEMClockEngineProtocol.h"
#import "DEMGravizzappa.h"

@interface DEMMotherShipVM : NSObject
<
DEMBattleProtocol,
DEMClockEngineProtocol
>

@property (nonatomic, assign) double currentEnergyLevel;
@property (nonatomic, assign) double extraEnergyLevel;

@property (nonatomic, strong, readonly) DEMWarehouseVM *warehouse;
@property (nonatomic, assign, readonly) double maxEnergyLevel;

- (void)installGravizzappa:(DEMGravizzappa *)gravizzappa;

@end
