#import "DEMVisitorProtocol.h"

@protocol DEMVisitorPlaceProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSArray *items;
@property (nonatomic, strong, readonly) id<DEMVisitorProtocol> visitor;

- (BOOL)canProcessVisitor;
- (void)processItemAtIndex:(NSInteger)index;

@end
