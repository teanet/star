#import "DEMBattleEngine.h"

@interface DEMBattleEngine ()

@property (nonatomic, strong, readonly) id<DEMBattleProtocol> defender;
@property (nonatomic, strong, readonly) NSMutableArray<id<DEMAttackerProtocol>> *attackers;
@property (nonatomic, strong, readonly) dispatch_semaphore_t semaphore;
@property (nonatomic, strong, readonly) RACSubject *defenderDidFinallyCrashSubject;

@end

@implementation DEMBattleEngine

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;
	
	_attackers = [NSMutableArray array];
	_semaphore = dispatch_semaphore_create(1);

	_defenderDidFinallyCrashSubject = [RACSubject subject];
	_defenderDidFinallyCrashSignal = _defenderDidFinallyCrashSubject;

	return self;
}

- (void)setDefender:(id<DEMBattleProtocol>)defender {
	@weakify(self);

	_defender = defender;

	[defender.battleActionSignal subscribeNext:^(NSNumber *an) {
		@strongify(self);

		DEMBattleAction action = an.unsignedIntegerValue;

		switch (action) {
			case DEMBattleActionNone: {
				NSCAssert(NO, @"Undefined action.");
			} break;
			case DEMBattleActionDie: {
				[self defenderDidDie];
			} break;
		}
	}];
}

- (NSUInteger)attackersCount {
	return self.attackers.count;
}

- (void)defenderDidDie {
	[self.attackers enumerateObjectsUsingBlock:^(id<DEMAttackerProtocol> attacker, NSUInteger idx, BOOL *stop) {
		[attacker markAsPassed:NO];

		if (!attacker.canBeWeaker) {
			[self defenderDidFinallyDie];
		}

	}];
}

- (void)defenderDidFinallyDie {
	[self.defenderDidFinallyCrashSubject sendNext:self.defender];
}

- (void)battleWillStartForAttacker:(id<DEMAttackerProtocol>)attacker {

	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);

	[self.attackers addObject:attacker];
	NSLog(@"Add attacker: %@\nattackers: %@", attacker, self.attackers);

	dispatch_semaphore_signal(_semaphore);

}

- (void)battleDidEndForAttacker:(id<DEMAttackerProtocol>)attacker {

	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);

	[attacker finishBattle];
	[self.attackers removeObject:attacker];
	NSLog(@"Remove attacker: %@\nattackers: %@", attacker, self.attackers);

	dispatch_semaphore_signal(_semaphore);

}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration {
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);

	[self.attackers enumerateObjectsUsingBlock:^(id<DEMAttackerProtocol> attacker, NSUInteger _, BOOL *stop) {
		[self.defender receiveDamage:attacker.dps * duration];
	}];

	dispatch_semaphore_signal(_semaphore);
}

@end
