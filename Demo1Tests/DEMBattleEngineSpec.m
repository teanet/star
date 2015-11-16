#import <Kiwi/Kiwi.h>
#import "DEMBattleEngine.h"

@interface DEMBattleEngine (DEMTesting)

@property (nonatomic, strong) NSObject<DEMBattleProtocol> *defender;
@property (nonatomic, strong) NSMutableArray<id<DEMBattleProtocol>> *attackers;

@end

SPEC_BEGIN(DEMBattleEngineSpec)

describe(@"DEMBattleEngine", ^{

	__block DEMBattleEngine *engine = nil;
	__block NSObject<DEMAttackerProtocol> *attacker = nil;
	__block NSObject<DEMBattleProtocol> *defender = nil;

	beforeEach(^{
		attacker = [KWMock mockForProtocol:@protocol(DEMAttackerProtocol)];
		[attacker stub:@selector(dps) andReturn:theValue(1.0)];
		defender = [KWMock mockForProtocol:@protocol(DEMBattleProtocol)];
		engine = [[DEMBattleEngine alloc] initWithDefender:defender];
	});

	it(@"Should create", ^{
		[[engine shouldNot] beNil];
		[[engine.defender shouldNot] beNil];
		[[engine.attackers should] haveCountOf:0];
		[[theValue(engine.attackersCount) should] equal:theValue(0)];
	});

	it(@"Should start attack", ^{
		[engine battleWillStartForAttacker:attacker];
		[[engine.attackers should] haveCountOf:1];
	});

	it(@"Should end attack", ^{
		[[attacker should] receive:@selector(finishBattle)];
		[engine battleWillStartForAttacker:attacker];
		[engine battleDidEndForAttacker:attacker];
		[[engine.attackers should] haveCountOf:0];
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

SPEC_END
