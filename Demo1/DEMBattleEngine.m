#import "DEMBattleEngine.h"

@interface DEMBattleEngine ()
<
DEMBattleAction
>

@property (nonatomic, strong, readonly) id<DEMBattleProtocol> defender;
@property (nonatomic, strong, readonly) NSMutableArray<id<DEMBattleProtocol>> *attackers;
@property (nonatomic, strong, readonly) dispatch_semaphore_t semaphore;

@end

@implementation DEMBattleEngine

- (instancetype)initWithDefender:(id<DEMBattleProtocol>)defender
{
	self = [super init];
	if (self == nil) return nil;

	_defender = defender;
	_attackers = [NSMutableArray array];
	_semaphore = dispatch_semaphore_create(1);

	return self;
}

- (NSUInteger)attackersCount {
	return _attackers.count;
}

- (void)battleWillStartForAttacker:(id<DEMAttackerProtocol>)attacker {
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	[_attackers addObject:attacker];
	NSLog(@"Add attacker: %@\nattackers: %@", attacker, _attackers);
	dispatch_semaphore_signal(_semaphore);
}

- (void)battleDidEndForAttacker:(id<DEMAttackerProtocol>)attacker {
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	//	[attacker finshBattle];
	[attacker finishBattle];
	[_attackers removeObject:attacker];
	NSLog(@"Remove attacker: %@\nattackers: %@", attacker, _attackers);
	dispatch_semaphore_signal(_semaphore);
}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration {
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);

	[_attackers enumerateObjectsUsingBlock:^(id<DEMBattleProtocol> attacker, NSUInteger _, BOOL *stop) {
		[_defender receiveDamage:attacker.dps * duration];
	}];

	dispatch_semaphore_signal(_semaphore);
}

#pragma mark DEMBattleAction

- (void)didDie:(id<DEMBattleProtocol>)unit {
//	if ([unit isEqual:_defender])
//	{
//		[_attackers enumerateObjectsUsingBlock:^(id<DEMBattleProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//			[obj setState:FAILED];
//		}];
//	}
//	else
//	{
//		[unit setState:FAILED];
//	}
}


@end
