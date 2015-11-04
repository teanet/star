
#import "DEMEnergyCellModel.h"
#import "DEMWarehouseVM.h"
#import "DEMBattleProtocol.h"
#import "DEMGameEngineProtocol.h"
#import "DEMGravizzappa.h"

@interface DEMMotherShipVM : NSObject
<
DEMBattleProtocol,
DEMGameEngineProtocol
>

@property (nonatomic, assign) double currentEnergyLevel;
@property (nonatomic, assign) double extraEnergyLevel;

@property (nonatomic, strong, readonly) DEMWarehouseVM *warehouse;
@property (nonatomic, assign, readonly) double maxEnergyLevel;

- (void)installGravizzappa:(DEMGravizzappa *)gravizzappa;

@end
