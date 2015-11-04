#import <Kiwi/Kiwi.h>
#import "DEMWave.h"


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
	});

});

SPEC_END
