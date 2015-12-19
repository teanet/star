#import "DEMVisitorPlaceProtocol.h"
#import "DEMVisitorPlace.h"
//#import "DEMStore.h"

//#import "DEMExchangeStuffProtocol.h"

//typedef NS_ENUM(NSUInteger, DEMStoreMode) {
//	DEMStoreModeBuy	= 0,
//	DEMStoreModeUpgrade,
//};

@interface DEMStoreVM : NSObject
<
DEMVisitorPlaceProtocol
>

- (instancetype)initWithVisitor:(id)visitor places:(NSArray<__kindof DEMVisitorPlace *> *)places;

@property (nonatomic, strong, readonly) RACSignal *didFailProcessSignal;
@property (nonatomic, strong, readonly) NSArray *placeTitles;
@property (nonatomic, assign, readonly) NSInteger placesCount;
@property (nonatomic, assign, readonly) NSInteger selectedPlaceIndex;

- (void)selectPlaceWithIndex:(NSInteger)index;
- (void)processItemAtIndex:(NSInteger)index;

@end
