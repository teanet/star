#import "DEMEntityUpgradableProtocol.h"

@protocol DEMActionUpgradeProtocol <NSObject>

@property (nonatomic, strong) NSArray<NSObject<DEMEntityUpgradableProtocol> *> *upgradableItems;

- (BOOL)canUpgradeEntity:(id)entity;
- (void)upgradeEntity:(id<DEMEntityUpgradableProtocol>)entity withCompletionBlock:(void (^)(BOOL didPurchase))block;

@end
