#import <Kiwi/Kiwi.h>
#import "DEMWaveEngine.h"

@interface DEMWaveEngine (DEMTesting)

@property (nonatomic, strong) NSMutableSet<DEMWave *> *waves;

@end

SPEC_BEGIN(DEMWaveEngineSpec)

describe(@"DEMWaveEngine", ^{

	__block NSObject<DEMWaveEngineDelegate> *_delegate;
	__block DEMWave *_wave;

	let(waveEngine, ^DEMWaveEngine *{
		_delegate = [KWMock mockForProtocol:@protocol(DEMWaveEngineDelegate)];
		[_delegate stub:@selector(waveEngine:didChangeStateForWave:)];

		_wave = [KWMock mockForClass:[DEMWave class]];
		[_wave stub:@selector(activate:)];
		return [[DEMWaveEngine alloc] initWithDelegate:_delegate];
	});

	it(@"Should create", ^{
		[[waveEngine shouldNot] beNil];
		[[waveEngine.delegate shouldNot] beNil];
		[[waveEngine.waves shouldNot] beNil];
		[[waveEngine.waves should] haveCountOf:0];
	});

	it(@"should add wave", ^{

		[waveEngine addWave:_wave];
		[[waveEngine.waves should] haveCountOf:1];
		
	});

	it(@"waves should receive tick", ^{

		[waveEngine addWave:_wave];
		const NSTimeInterval duration = 123.0;

		[[_wave should] receive:@selector(tick:) withArguments:theValue(duration), nil];
		[waveEngine tick:duration];
	});

	it(@"should call delegate with wave state when add new wave", ^{

		[[_delegate should] receive:@selector(waveEngine:didChangeStateForWave:)
					  withArguments:waveEngine, _wave, nil];

		[waveEngine addWave:_wave];

	});

	it(@"should chenge wave state to active when wave has been added", ^{

		[[_wave should] receive:@selector(activate:) withArguments:theValue(YES), nil];
		[waveEngine addWave:_wave];

	});

});

SPEC_END
