#import <Foundation/Foundation.h>

@protocol DEMBattleProtocol <NSObject>

@property (nonatomic, assign, readonly) double attackDamage;
- (void)receiveDamage:(double)damage;

@end
