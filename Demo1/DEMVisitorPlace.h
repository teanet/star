#import "DEMVisitorPlaceProtocol.h"

@interface DEMVisitorPlace : NSObject
<
DEMVisitorPlaceProtocol
>

- (instancetype)initWithVisitor:(id<DEMVisitorProtocol>)visitor;

@end
