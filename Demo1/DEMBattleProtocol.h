@protocol DEMBattleProtocol <NSObject>

@property (nonatomic, assign, readonly) double dps;

- (void)receiveDamage:(double)damage;

@end
