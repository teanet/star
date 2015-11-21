#import "DEMBattleProtocol.h"

@protocol DEMAttackerProtocol <DEMBattleProtocol>

- (BOOL)canBeWeaker;
- (void)markAsPassed:(BOOL)passed;
- (void)finishBattle;

@end
