#import "DEMClockEngineProtocol.h"
#import "DEMAttackerProtocol.h"

@interface DEMBattleEngine : NSObject
<
DEMClockEngineProtocol
>

@property (nonatomic, strong, readonly) RACSignal *defenderDidFinallyCrashSignal;
@property (nonatomic, assign, readonly) NSUInteger attackersCount;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (void)battleWillStartForAttacker:(id<DEMAttackerProtocol>)attacker;
- (void)battleDidEndForAttacker:(id<DEMAttackerProtocol>)attacker;
- (void)setDefender:(id<DEMBattleProtocol>)defender;

@end
