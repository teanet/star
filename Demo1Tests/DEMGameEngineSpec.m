#import <Kiwi/Kiwi.h>
#import "DEMGameEngine.h"

@interface DEMGameEngine (DEMTesting)

@property (nonatomic, strong)  NSTimer *timer;

@end

SPEC_BEGIN(DEMGameEngineSpec)

describe(@"DEMGameEngine", ^{

	let(engine, ^DEMGameEngine *{
		return [[DEMGameEngine alloc] init];
	});

	it(@"Should create engine with default time period", ^{
		[[theValue(engine.period) should] equal:kDEMDefaultTimePeriod withDelta:DBL_EPSILON];
	});

	it(@"Engine should start", ^{
		[engine start];

		[[engine.timer shouldNot] beNil];
		[[theValue(engine.timer.timeInterval) should] equal:kDEMDefaultTimePeriod withDelta:DBL_EPSILON];
	});

	it(@"Engine should receive tick", ^{

		NSObject<DEMGameEngineProtocol> *delegate = [KWMock mockForProtocol:@protocol(DEMGameEngineProtocol)];
		engine.delegate = delegate;

		[[delegate shouldEventually] receive:@selector(tick) withCountAtLeast:1];
		[engine start];
	});

	it(@"Engine should stop", ^{
		[engine start];
		[engine stop];

		[[engine.timer should] beNil];
	});
});

SPEC_END
