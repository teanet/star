#import <Kiwi/Kiwi.h>
#import "DEMGameCore.h"

#import "DEMBattleEngine.h"
#import "DEMClockEngine.h"
#import "DEMWaveEngine.h"

@interface DEMGameCore (DEMTesting) <DEMWaveEngineDelegate>

@property (nonatomic, strong, readonly) DEMClockEngine *clockEngine;
@property (nonatomic, strong, readonly) DEMWaveEngine *waveEngine;
@property (nonatomic, strong, readonly) DEMBattleEngine *battleEngine;
@property (nonatomic, strong, readonly) NSMutableArray<id<DEMClockEngineProtocol>> *engines;

- (void)tick:(NSTimeInterval)duration;
- (void)performInitialSubscribes;
- (void)gameDidLose;

@end

SPEC_BEGIN(DEMGameCoreSpec)

describe(@"DEMGameCore", ^{

	__block DEMGameCore *core = nil;
	__block DEMWaveEngine *waveEngine = nil;
	__block DEMBattleEngine *battleEngine = nil;
	__block DEMMotherShipVM *motherShip = nil;

	beforeEach(^{

		waveEngine = KWNullMockClass(DEMWaveEngine);
		battleEngine = KWNullMockClass(DEMBattleEngine);
		motherShip = KWNullMockClass(DEMMotherShipVM);
		core = [[DEMGameCore alloc] initWithMotherShip:motherShip
										  battleEngine:battleEngine
											waveEngine:waveEngine];

	});

	it(@"Should create", ^{

		[[core shouldNot] beNil];
		[[core.motherShip shouldNot] beNil];
		[[core.clockEngine shouldNot] beNil];
		[[core.waveEngine shouldNot] beNil];
		[[core.battleEngine shouldNot] beNil];

	});

	it(@"engines order is mandotory", ^{

		[[(id)core.engines should] equal:@[
										   core.motherShip,
										   core.waveEngine,
										   core.battleEngine,
										   ]];

	});

	context(@"start", ^{

		it(@"Should start to receive tick", ^{

			[core start];
			[[theValue(core.isRunning) should] beYes];
			[[core shouldEventually] receive:@selector(tick:) withCountAtLeast:1];

		});

		it(@"Should start once", ^{

			[[core.clockEngine should] receive:@selector(start)];
			[core start];
			[core start];

		});

		it(@"should start with single wave", ^{

			[[core.clockEngine should] receive:@selector(start)];
			[[core.waveEngine should] receive:@selector(addWave:)];
			[[core.waveEngine should] receive:@selector(setDelegate:) withArguments:core];
			[[core.battleEngine should] receive:@selector(setDefender:) withArguments:motherShip];
			[[core should] receive:@selector(performInitialSubscribes)];
			
			[core start];
			
		});

	});

	it(@"Engines should receive tick", ^{

		[[core.waveEngine should] receive:@selector(tick:)];
		[[core.battleEngine should] receive:@selector(tick:)];
		[[core.motherShip should] receive:@selector(tick:)];
		[core tick:0.0];

	});

	it(@"should stop", ^{

		[[core.clockEngine should] receive:@selector(stop)];

		[core stop];
		[[theValue(core.isRunning) should] beNo];

	});

	context(@"subscribe", ^{

		__block RACSubject *defenderDidFinallyCrashSignal = nil;
		beforeEach(^{
			defenderDidFinallyCrashSignal = [RACSubject subject];
			[core.battleEngine stub:@selector(defenderDidFinallyCrashSignal) andReturn:defenderDidFinallyCrashSignal];
		});

		it(@"should receive did finish game signal when battleEngine generate defenderDidFinallyCrashSignal", ^{

			[core performInitialSubscribes];
			[[core should] receive:@selector(gameDidLose)];
			[defenderDidFinallyCrashSignal sendNext:core.motherShip];

		});

		it(@"should handle lose", ^{

			[[core should] receive:@selector(stop)];
			NSNumber *reason = [core.didFinishGameSignal dgs_lastObjectAfterAction:^{
				[core gameDidLose];
			}];
			[[reason should] equal:@(DEMGameFinishReasonLose)];

		});

	});

	context(@"Wave handling", ^{

		__block DEMWave *wave = nil;

		beforeEach(^{

			wave = [KWMock mockForClass:[DEMWave class]];
			[wave stub:@selector(isActive) andReturn:theValue(YES)];

		});

		it(@"Should add wave to battle engine when waveState changes to run", ^{
			[wave stub:@selector(isRunning) andReturn:theValue(YES)];

			[[core.battleEngine should] receive:@selector(battleWillStartForAttacker:) withArguments:wave, nil];
			[core waveEngine:nil didChangeStateForWave:wave];
		});

		it(@"Should remove wave from battle engine when waveState chenges to shedule", ^{
			[wave stub:@selector(isRunning) andReturn:theValue(NO)];

			[[core.battleEngine should] receive:@selector(battleDidEndForAttacker:) withArguments:wave, nil];
			[core waveEngine:nil didChangeStateForWave:wave];
		});

	});

});

SPEC_END
