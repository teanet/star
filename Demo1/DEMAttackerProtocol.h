#import "DEMBattleProtocol.h"

@protocol DEMAttackerProtocol <DEMBattleProtocol>

- (void)markAsPassed:(BOOL)passed;
- (void)finishBattle;

@end
