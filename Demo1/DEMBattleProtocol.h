typedef NS_ENUM(NSUInteger, DEMBattleAction) {
	DEMBattleActionNone = 0,
	DEMBattleActionDie,
};

@protocol DEMBattleProtocol <NSObject>

@property (nonatomic, assign, readonly) double dps;
@property (nonatomic, strong, readonly) RACSignal *battleActionSignal;

- (void)receiveDamage:(double)damage;

@end
