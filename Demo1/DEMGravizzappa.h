#import "DEMStuffProtocol.h"

#import "DEMBaseItem.h"

extern const double kDEMInitialGravizzappaPrice;

@interface DEMGravizzappa : DEMBaseItem
<
DEMExchangableStuffProtocol,
DEMStuffProtocol,
NSCopying
>

@property (nonatomic, assign, readonly) double energyPerSecond;

@end
