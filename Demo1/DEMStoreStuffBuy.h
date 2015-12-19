#import "DEMActionExchangeProtocol.h"
#import "DEMVisitorPlace.h"

@interface DEMStoreStuffBuy : DEMVisitorPlace

@property (nonatomic, strong, readonly) NSArray<id<DEMEntityExchangableProtocol>> *items;
@property (nonatomic, strong, readonly) id<DEMActionExchangeProtocol> visitor;

- (instancetype)initWithVisitor:(id<DEMActionExchangeProtocol, DEMVisitorProtocol>)visitor;

@end
