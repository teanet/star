#import <Kiwi/Kiwi.h>
#import "DEMWave.h"

@interface DEMWave (DEMTesting)

@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) BOOL passed;

- (void)setRunning:(BOOL)running;

@end

SPEC_BEGIN(DEMWaveSpec)

describe(@"DEMWave", ^{

	let(wave, ^DEMWave *{
		return [[DEMWave alloc] init];
	});

	it(@"Should create", ^{
		
		[[wave shouldNot] beNil];
		[[theValue(wave.level) should] equal:theValue(0)];
		[[theValue(wave.duration) should] beGreaterThanOrEqualTo:theValue(kDEMMinimumDurationTime)];
		[[theValue(wave.scheduleTime) should] beGreaterThanOrEqualTo:theValue(kDEMMinimumScheduleTime)];
		[[theValue(wave.state) should] equal:theValue(DEMWaveStateBorned)];
		[[theValue(wave.progress) should] equal:0.0f withDelta:FLT_EPSILON];
		[[theValue(wave.dps) should] equal:kDEMDefaultDPS withDelta:FLT_EPSILON];
		[[theValue(wave.passed) should] beYes];

	});

	it(@"active wave should change state when progress become more than schedule duration", ^{

		[wave activate:YES];
		[wave tick:kDEMMinimumScheduleTime + DBL_EPSILON];
		[[theValue(DEMWaveStateRun & wave.state) should] equal:theValue(DEMWaveStateRun)];

	});
	
	it(@"should not change progress when state is not active", ^{

		[[theValue(wave.state & DEMWaveStateActive) shouldNot] equal:theValue(DEMWaveStateActive)];
		const NSTimeInterval duration = 0.1;
		NSTimeInterval currentTime = wave.currentTime;
		[wave tick:duration];
		[[theValue(wave.currentTime) should] equal:currentTime withDelta:DBL_EPSILON];

	});

	it(@"should change progress when state is active", ^{

		[wave activate:YES];
		[[theValue(DEMWaveStateActive & wave.state) should] equal:theValue(DEMWaveStateActive)];
		const NSTimeInterval duration = 0.1;
		NSTimeInterval currentTime = wave.currentTime;
		[wave tick:duration];
		[[theValue(wave.currentTime) should] equal:currentTime + duration withDelta:DBL_EPSILON];

	});

	it(@"should change state to scheduling when progress become more than schedule+running duration", ^{

		[[theValue(DEMWaveStateRun & wave.state) shouldNot] equal:theValue(DEMWaveStateRun)];
		[wave tick:kDEMMinimumScheduleTime + kDEMMinimumDurationTime + DBL_EPSILON];
		[[theValue(DEMWaveStateRun & wave.state) shouldNot] equal:theValue(DEMWaveStateRun)];

	});

	it(@"active wave should update progress on tick", ^{

		[wave activate:YES];
		[wave tick:0.1];

		[[theValue(wave.progress) should] beGreaterThan:theValue(0.0f)];

	});

	it(@"should get current time on duration more than totalWaveDuration", ^{

		[wave activate:YES];
		[wave tick:1000.0];
		[[theValue(wave.currentTime) should] beLessThanOrEqualTo:theValue(wave.totalWaveDuration)];

	});

	it(@"progress should be less then 1.0", ^{

		[wave activate:YES];
		[wave tick:1000.0];
		[[theValue(wave.progress) should] beLessThanOrEqualTo:theValue(1.0)];

	});

	it(@"should change state from running to scheduling for active wave", ^{

		[wave activate:YES];
		[wave tick:wave.scheduleTime + 0.1];
		[[theValue(wave.isRunning) should] beYes];
		[wave tick:wave.duration];
		[[theValue(wave.isRunning) should] beNo];

	});

	context(@"pass", ^{

		it(@"should mark as passed", ^{

			[wave markAsPassed:YES];
			[[theValue(wave.passed) should] beYes];

		});

		it(@"should increase level", ^{

			uint32_t _level = wave.level;
			[wave markAsPassed:YES];
			[wave finishBattle];
			[[theValue(wave.level) should] beGreaterThan:theValue(_level)];
			
		});

		it(@"should increase dps", ^{

			double _dps = wave.dps;
			[wave markAsPassed:YES];
			[wave finishBattle];
			[[theValue(wave.dps) should] beGreaterThan:theValue(_dps)];

		});

	});


});

SPEC_END
