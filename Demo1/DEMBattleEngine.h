#import "DEMClockEngineProtocol.h"
#import "DEMAttackerProtocol.h"

@interface DEMBattleEngine : NSObject
<
DEMClockEngineProtocol
>

@property (nonatomic, assign, readonly) NSUInteger attackersCount;

- (instancetype)initWithDefender:(id<DEMBattleProtocol>)defender;
- (void)battleWillStartForAttacker:(id<DEMAttackerProtocol>)attacker;
- (void)battleDidEndForAttacker:(id<DEMAttackerProtocol>)attacker;

@end
