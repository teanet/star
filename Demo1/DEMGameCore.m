#import "DEMGameCore.h"

#import "DEMBattleEngine.h"
#import "DEMClockEngine.h"
#import "DEMWaveEngine.h"

@interface DEMGameCore () <DEMClockEngineProtocol, DEMWaveEngineDelegate>

@property (nonatomic, strong, readonly) DEMClockEngine *clockEngine;
@property (nonatomic, strong, readonly) DEMWaveEngine *waveEngine;
@property (nonatomic, strong, readonly) DEMBattleEngine *battleEngine;
@property (nonatomic, strong) NSObject<DEMProgressProtocol> *progressVM;
@property (nonatomic, strong, readonly) dispatch_semaphore_t semaphore;

@property (nonatomic, strong, readonly) RACSubject *didFinishGameSubject;

@end

@implementation DEMGameCore

- (void)dealloc {
	[self.didFinishGameSubject sendCompleted];
}

- (instancetype)init {
	self = [super init];
	if (self == nil) return nil;

	_didFinishGameSubject = [RACSubject subject];
	_didFinishGameSignal = _didFinishGameSubject;

	_semaphore = dispatch_semaphore_create(1);

	_motherShip = [[DEMMotherShipVM alloc] init];
	_waveEngine = [[DEMWaveEngine alloc] initWithDelegate:self];

	_clockEngine = [[DEMClockEngine alloc] init];
	_clockEngine.delegate = self;

	_battleEngine = [[DEMBattleEngine alloc] initWithDefender:_motherShip];

	return self;
}

- (void)start {
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	if (!self.isRunning) {
		_running = YES;

		[_waveEngine addWave:[[DEMWave alloc] init]];
		[_clockEngine start];
	};
	dispatch_semaphore_signal(_semaphore);
}

#pragma mark DEMClockEngineDelegate

- (void)tick:(NSTimeInterval)duration {
	// WaveEngine should be first, переделать на массив!
	[_waveEngine tick:duration];
	[_battleEngine tick:duration];
}

#pragma mark DEMWaveEngineDelegate

- (void)waveEngine:(DEMWaveEngine *)engine didChangeStateForWave:(DEMWave *)wave {
	self.progressVM = wave;

	if (!wave.isActive) return;

	if (wave.isRunning)
	{
		[_battleEngine addAttacker:wave];
	}
	else
	{
		[_battleEngine removeAttacker:wave];
	}
}

@end
