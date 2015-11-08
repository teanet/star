#import "DEMMotherShipVM.h"
#import "DEMProgressProtocol.h"

@interface DEMGameCore : NSObject

@property (nonatomic, strong, readonly) DEMMotherShipVM *motherShip;
@property (nonatomic, strong, readonly) NSObject<DEMProgressProtocol> *progressVM;

- (void)start;

@end
