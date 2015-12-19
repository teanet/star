#import "DEMResources.h"

@protocol DEMActionExchangeResourcesProtocol <NSObject>

- (DEMResources *)availableResources;
- (void)addResources:(DEMResources *)resources;
- (void)withdrawResources:(DEMResources *)resources;

@end
