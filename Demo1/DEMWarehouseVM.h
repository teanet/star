#import "DEMWarehouseItem.h"
#import "DEMActionExchangeResourcesProtocol.h"

@interface DEMWarehouseVM : NSObject
<DEMActionExchangeResourcesProtocol>

@property (nonatomic, assign, readonly) int32_t capacity;
@property (nonatomic, strong, readonly) NSSet<id<DEMWarehouseItem>> *items;

- (void)storeItem:(NSObject<DEMWarehouseItem> *)item;
- (BOOL)hasEnegry:(double)enegry;

@end
