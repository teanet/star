#import <Kiwi/Kiwi.h>
#import "DEMWaveEngine.h"

@interface DEMWaveEngine (DEMTesting)

@property (nonatomic, strong) NSMutableSet<DEMWave *> *waves;

@end

SPEC_BEGIN(DEMWaveEngineSpec)

describe(@"DEMWaveEngine", ^{

	__block NSObject<DEMWaveEngineDelegate> *delegate;
	__block DEMWave *wave;

	let(waveEngine, ^DEMWaveEngine *{
		delegate = [KWMock mockForProtocol:@protocol(DEMWaveEngineDelegate)];
		[delegate stub:@selector(waveEngine:didChangeStateForWave:)];

		wave = [KWMock nullMockForClass:[DEMWave class]];
		[wave stub:@selector(activate:)];
		return [[DEMWaveEngine alloc] init];
	});

	it(@"Should create", ^{
		[[waveEngine shouldNot] beNil];
		[[waveEngine.delegate should] beNil];
		[[waveEngine.waves shouldNot] beNil];
		[[waveEngine.waves should] haveCountOf:0];
	});

	it(@"should add wave", ^{

		[waveEngine addWave:wave];
		[[waveEngine.waves should] haveCountOf:1];
		[[theValue(waveEngine.activeWavesCount) should] equal:theValue(1)];
		
	});

	it(@"waves should receive tick", ^{

		[waveEngine addWave:wave];
		const NSTimeInterval duration = 123.0;

		[[wave should] receive:@selector(tick:) withArguments:theValue(duration), nil];
		[waveEngine tick:duration];
	});

	it(@"should call delegate with wave state when add new wave", ^{

		waveEngine.delegate = delegate;
		[[delegate should] receive:@selector(waveEngine:didChangeStateForWave:)
					  withArguments:waveEngine, wave, nil];

		[waveEngine addWave:wave];

	});

	it(@"should change wave state to active when wave has been added", ^{

		[[wave should] receive:@selector(activate:) withArguments:theValue(YES), nil];
		[waveEngine addWave:wave];

	});

	it(@"Should call delegate when wave changes state", ^{
		waveEngine.delegate = delegate;
		[wave stub:@selector(state) andReturn:theValue(DEMWaveStateDead) times:@1 afterThatReturn:theValue(DEMWaveStateRun)];
		[waveEngine addWave:wave];

		[[delegate should] receive:@selector(waveEngine:didChangeStateForWave:) withArguments:waveEngine, wave, nil];
		[waveEngine tick:0.0];
	});

});

SPEC_END
