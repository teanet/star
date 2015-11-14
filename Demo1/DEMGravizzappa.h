#import "DEMStoreItem.h"

extern const double kDEMGravizzappaPrice;

@interface DEMGravizzappa : NSObject
<
DEMStoreItem
>

@property (nonatomic, assign, readonly) double energyPerSecond;

@end
