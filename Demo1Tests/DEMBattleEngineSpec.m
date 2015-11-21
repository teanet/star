#import <Kiwi/Kiwi.h>
#import "DEMBattleEngine.h"

@interface DEMBattleEngine (DEMTesting)

@property (nonatomic, strong) NSObject<DEMBattleProtocol> *defender;
@property (nonatomic, strong) NSMutableArray<id<DEMBattleProtocol>> *attackers;

- (void)defenderDidDie;
- (void)defenderDidFinallyDie;

@end

SPEC_BEGIN(DEMBattleEngineSpec)

describe(@"DEMBattleEngine", ^{

	__block DEMBattleEngine *engine = nil;
	__block NSObject<DEMAttackerProtocol> *attacker = nil;
	__block NSObject<DEMBattleProtocol> *defender = nil;

	beforeEach(^{

		attacker = KWNullMockProtocol(DEMAttackerProtocol);
		[attacker stub:@selector(dps) andReturn:theValue(1.0)];
		defender = KWNullMockProtocol(DEMBattleProtocol);
		engine = [[DEMBattleEngine alloc] init];

	});

	it(@"Should create", ^{

		[[engine shouldNot] beNil];
		[[engine.defender should] beNil];
		[[engine.attackers should] haveCountOf:0];
		[[theValue(engine.attackersCount) should] equal:theValue(0)];

	});

	context(@"With Attacker", ^{

		beforeEach(^{

			[engine battleWillStartForAttacker:attacker];

		});

		it(@"Should start attack", ^{

			[[engine.attackers should] haveCountOf:1];

		});

		it(@"Should end attack", ^{

			[[attacker should] receive:@selector(finishBattle)];
			[engine battleDidEndForAttacker:attacker];
			[[engine.attackers should] haveCountOf:0];

		});

	});

	context(@"With Defender", ^{

		beforeEach(^{

			[engine setDefender:defender];

		});

		it(@"Should simulate attack", ^{

			[engine battleWillStartForAttacker:attacker];
			[[engine.defender should] receive:@selector(receiveDamage:)];

			[engine tick:0.1];

		});

		it(@"Should simulate multiple attack", ^{

			[engine battleWillStartForAttacker:attacker];
			[engine battleWillStartForAttacker:attacker];
			[[engine.defender should] receive:@selector(receiveDamage:) withCount:2];
			[engine tick:0.1];

		});

	});

	context(@"Defender and Attacker", ^{

		beforeEach(^{

			[engine battleWillStartForAttacker:attacker];
			[engine setDefender:defender];

		});

		it(@"Should handle defender did die", ^{

			[[attacker should] receive:@selector(markAsPassed:) withArguments:theValue(NO)];

			[engine defenderDidDie];

		});

		it(@"Should handle defender did finally die", ^{

			[[engine should] receive:@selector(defenderDidFinallyDie)];

			[attacker stub:@selector(canBeWeaker) andReturn:theValue(NO)];
			[engine defenderDidDie];

		});

	});

	context(@"Reactive stuff", ^{

		__block RACSubject *battleActionSignal = nil;

		beforeEach(^{
			battleActionSignal = [RACSubject subject];
			[defender stub:@selector(battleActionSignal) andReturn:battleActionSignal];
		});

		it(@"Should subscribe to defender", ^{

			[[battleActionSignal should] receive:@selector(subscribeNext:)];

			[engine setDefender:defender];

		});

		it(@"Should receive defenderDidDie when defender die", ^{

			[[engine should] receive:@selector(defenderDidDie)];

			[engine setDefender:defender];
			[battleActionSignal sendNext:@(DEMBattleActionDie)];

		});

		it(@"Should send defenderDidFinallyCrashSignal", ^{

			[[[engine.defenderDidFinallyCrashSignal dgs_lastObjectAfterAction:^{

				[engine setDefender:defender];
				[engine defenderDidFinallyDie];

			}] should] equal:defender];

		});

	});

});

SPEC_END
