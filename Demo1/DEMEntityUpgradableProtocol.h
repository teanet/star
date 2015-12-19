@protocol DEMEntityUpgradableProtocol <NSObject>

- (BOOL)canBeUpgraded;
- (void)upgrade;

@end
