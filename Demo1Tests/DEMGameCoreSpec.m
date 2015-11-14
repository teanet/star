#import <Kiwi/Kiwi.h>
#import "DEMGameCore.h"

#import "DEMBattleEngine.h"
#import "DEMClockEngine.h"
#import "DEMWaveEngine.h"

@interface DEMGameCore (DEMTesting) <DEMWaveEngineDelegate>

@property (nonatomic, strong, readonly) DEMClockEngine *clockEngine;
@property (nonatomic, strong, readonly) DEMWaveEngine *waveEngine;
@property (nonatomic, strong, readonly) DEMBattleEngine *battleEngine;

- (void)tick:(NSTimeInterval)duration;

@end

SPEC_BEGIN(DEMGameCoreSpec)

describe(@"DEMGameCore", ^{

	let(core, ^DEMGameCore *{
		return [[DEMGameCore alloc] init];
	});

	it(@"Should create", ^{

		[[core shouldNot] beNil];
		[[core.clockEngine shouldNot] beNil];
		[[core.waveEngine shouldNot] beNil];
		[[core.battleEngine shouldNot] beNil];

	});

	it(@"Should start to receive tick", ^{

		[core start];
		[[core shouldEventually] receive:@selector(tick:) withCountAtLeast:1];

	});

	it(@"Should start once", ^{

		[[core.clockEngine should] receive:@selector(start)];
		[core start];
		[core start];

	});
	
	it(@"Engines should receive tick", ^{

		[[core.waveEngine should] receive:@selector(tick:)];
		[[core.battleEngine should] receive:@selector(tick:)];
		[core tick:0.0];

	});
	
	it(@"should start with single wave", ^{

		[core start];
		[[theValue(core.waveEngine.activeWavesCount) should] equal:@1];

	});

	context(@"Wave handling", ^{

		let(wave, ^DEMWave *{
			DEMWave *wave = [KWMock mockForClass:[DEMWave class]];
			[wave stub:@selector(isActive) andReturn:theValue(YES)];
			return wave;
		});

		it(@"Should add wave to battle engine when waveState changes to run", ^{
			[wave stub:@selector(isRunning) andReturn:theValue(YES)];

			[[core.battleEngine should] receive:@selector(addAttacker:) withArguments:wave, nil];
			[core waveEngine:nil didChangeStateForWave:wave];
		});

		it(@"Should remove wave from battle engine when waveState chenges to shedule", ^{
			[wave stub:@selector(isRunning) andReturn:theValue(NO)];

			[[core.battleEngine should] receive:@selector(removeAttacker:) withArguments:wave, nil];
			[core waveEngine:nil didChangeStateForWave:wave];
		});

	});

});

SPEC_END
