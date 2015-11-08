#import "DEMMotherShipVM.h"
#import "DEMStoreVM.h"
#import "DEMGameCore.h"

@interface DEMGameVM : NSObject

@property (nonatomic, strong, readonly) DEMGameCore *gameCore;
@property (nonatomic, strong, readonly) DEMMotherShipVM *motherShipVM;
@property (nonatomic, strong, readonly) DEMStoreVM *storeVM;

@end
