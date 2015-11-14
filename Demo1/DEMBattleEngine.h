#import "DEMClockEngineProtocol.h"
#import "DEMBattleProtocol.h"

@interface DEMBattleEngine : NSObject
<
DEMClockEngineProtocol
>

@property (nonatomic, assign, readonly) NSUInteger attackersCount;

- (instancetype)initWithDefender:(id<DEMBattleProtocol>)defender;
- (void)addAttacker:(id<DEMBattleProtocol>)attacker;
- (void)removeAttacker:(id<DEMBattleProtocol>)attacker;

@end
