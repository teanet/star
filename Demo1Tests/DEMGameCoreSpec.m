#import <Kiwi/Kiwi.h>
#import "DEMGameCore.h"
#import "DEMClockEngine.h"
#import "DEMWaveEngine.h"

@interface DEMGameCore (DEMTesting)

@property (nonatomic, strong, readonly) DEMClockEngine *clockEngine;
@property (nonatomic, strong, readonly) DEMWaveEngine *waveEngine;
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

	});

	it(@"Should receive tick", ^{

		[core start];
		[[core shouldEventually] receive:@selector(tick:) withCountAtLeast:1];

	});
	
	it(@"Should receive tick", ^{

		[[core.waveEngine should] receive:@selector(tick:)];
		[core tick:0.0];

	});
	
	it(@"should start with single wave", ^{

		[core start];
		[[theValue(core.waveEngine.activeWavesCount) should] equal:@1];

	});

});

SPEC_END
