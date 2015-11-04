
#import "DEMStoreItem.h"
#import "DEMMotherShipVM.h"

@interface DEMStoreVM : NSObject

@property (nonatomic, strong) NSArray<NSObject<DEMStoreItem> *> *items;
@property (nonatomic, weak, readonly) DEMMotherShipVM *motherShipVM;

- (instancetype)initWithMotherShipVM:(DEMMotherShipVM *)motherShipVM;
- (BOOL)canPurchaseItem:(NSObject<DEMStoreItem> *)storeItem;
- (void)installItem:(NSObject<DEMStoreItem> *)storeItem;

@end
