@protocol DEMBattleProtocol;

@protocol DEMBattleAction <NSObject>

- (void)didDie:(id<DEMBattleProtocol>)unit;

@end

@protocol DEMBattleProtocol <NSObject>

@property (nonatomic, assign, readonly) double dps;
@property (nonatomic, weak) id<DEMBattleAction> delegate;

- (void)receiveDamage:(double)damage;

@end
