#import "DEMEntityExchangableProtocol.h"
#import "DEMEntityUpgradableProtocol.h"

@protocol DEMStuffProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *name;

@end

@protocol DEMUpgradableStuffProtocol <DEMStuffProtocol, DEMEntityUpgradableProtocol>
@end

@protocol DEMExchangableStuffProtocol <DEMStuffProtocol, DEMEntityExchangableProtocol>
@end
