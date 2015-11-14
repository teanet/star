#import "DEMGameCore.h"

#import "DEMBattleEngine.h"
#import "DEMClockEngine.h"
#import "DEMWaveEngine.h"

@interface DEMGameCore () <DEMClockEngineProtocol, DEMWaveEngineDelegate>

@property (nonatomic, strong, readonly) DEMClockEngine *clockEngine;
@property (nonatomic, strong, readonly) DEMWaveEngine *waveEngine;
@property (nonatomic, strong, readonly) DEMBattleEngine *battleEngine;
@property (nonatomic, strong, readonly) NSMutableArray<id<DEMClockEngineProtocol>> *engines;
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

	// WaveEngine should be first, переделать на массив!
	_engines =
	[@[
	   _motherShip,
	   _waveEngine,
	   _battleEngine
	  ] mutableCopy];

	return self;
}

- (void)start {

	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	if (!self.isRunning) {
		_running = YES;

		[_waveEngine addWave:[[DEMWave alloc] init]];
		[_clockEngine start];

		[self performInitialSubscribes];
	};


	dispatch_semaphore_signal(_semaphore);
}

- (void)stop {
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	[_clockEngine stop];
	_running = NO;
	dispatch_semaphore_signal(_semaphore);
}

- (void)performInitialSubscribes {
	@weakify(self);

	[_motherShip.energyStateSignal subscribeNext:^(NSNumber *state) {
		@strongify(self);

		if (DEMMotherShipEnegyStateEmpty == (DEMMotherShipEnegyState)state.unsignedIntegerValue) {
			[self gameDidLose];
		}

	}];
}

- (void)gameDidLose {
	[self stop];
	[self.didFinishGameSubject sendNext:@(DEMGameFinishReasonLose)];
}

#pragma mark DEMClockEngineDelegate

- (void)tick:(NSTimeInterval)duration {
	[_engines enumerateObjectsUsingBlock:^(id<DEMClockEngineProtocol>engine, NSUInteger _, BOOL *stop) {
		[engine tick:duration];
	}];
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
