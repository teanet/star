#import "DEMVisitorPlace.h"

#import "DEMEntityUpgradableProtocol.h"
#import "DEMActionUpgradeProtocol.h"

@interface DEMStoreStuffUpgrade : DEMVisitorPlace

@property (nonatomic, strong, readonly) NSArray<id<DEMEntityUpgradableProtocol>> *items;
@property (nonatomic, strong, readonly) id<DEMActionUpgradeProtocol> visitor;

- (instancetype)initWithVisitor:(id<DEMActionUpgradeProtocol, DEMVisitorProtocol>)visitor;

@end
