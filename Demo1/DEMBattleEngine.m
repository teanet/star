#import "DEMBattleEngine.h"

@interface DEMBattleEngine ()

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

- (NSUInteger)attackersCount
{
	return _attackers.count;
}

- (void)addAttacker:(id<DEMBattleProtocol>)attacker
{
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	[_attackers addObject:attacker];
	NSLog(@"Add attacker: %@\nattackers: %@", attacker, _attackers);
	dispatch_semaphore_signal(_semaphore);
}

- (void)removeAttacker:(id<DEMBattleProtocol>)attacker
{
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	[_attackers removeObject:attacker];
	NSLog(@"Remove attacker: %@\nattackers: %@", attacker, _attackers);
	dispatch_semaphore_signal(_semaphore);
}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration
{
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);

	[_attackers enumerateObjectsUsingBlock:^(id<DEMBattleProtocol> attacker, NSUInteger _, BOOL *stop) {
		[_defender receiveDamage:attacker.dps * duration];
	}];

	dispatch_semaphore_signal(_semaphore);
}

@end
