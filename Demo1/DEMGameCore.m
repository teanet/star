#import "DEMGameCore.h"

#import "DEMClockEngine.h"

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
	[_didFinishGameSubject sendCompleted];
}

- (instancetype)initWithMotherShip:(DEMMotherShipVM *)motherShip
					  battleEngine:(DEMBattleEngine *)battleEngine
						waveEngine:(DEMWaveEngine *)waveEngine
{
	self = [super init];
	if (self == nil) return nil;

	NSCParameterAssert(motherShip);
	NSCParameterAssert(battleEngine);
	NSCParameterAssert(waveEngine);

	_didFinishGameSubject = [RACSubject subject];
	_didFinishGameSignal = _didFinishGameSubject;

	_semaphore = dispatch_semaphore_create(1);

	_motherShip = motherShip;
	_waveEngine = waveEngine;

	_clockEngine = [[DEMClockEngine alloc] init];
	_clockEngine.delegate = self;

	_battleEngine = battleEngine;

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

		self.waveEngine.delegate = self;
		[self.waveEngine addWave:[[DEMWave alloc] init]];

		[self.battleEngine setDefender:self.motherShip];

		[self.clockEngine start];

		[self performInitialSubscribes];
	};


	dispatch_semaphore_signal(_semaphore);
}

- (void)stop {
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	[self.clockEngine stop];
	_running = NO;
	dispatch_semaphore_signal(_semaphore);
}

- (void)performInitialSubscribes {
	@weakify(self);

	[self.battleEngine.defenderDidFinallyCrashSignal subscribeNext:^(id _) {
		
		@strongify(self);

		[self gameDidLose];

	}];
}

- (void)gameDidLose {
	[self stop];
	[self.didFinishGameSubject sendNext:@(DEMGameFinishReasonLose)];
}

#pragma mark DEMClockEngineDelegate

- (void)tick:(NSTimeInterval)duration {
	[self.engines enumerateObjectsUsingBlock:^(id<DEMClockEngineProtocol>engine, NSUInteger _, BOOL *stop) {
		[engine tick:duration];
	}];
}

#pragma mark DEMWaveEngineDelegate

- (void)waveEngine:(DEMWaveEngine *)engine didChangeStateForWave:(DEMWave *)wave {
	self.progressVM = wave;

	if (!wave.isActive) return;

	if (wave.isRunning) {
		[self.battleEngine battleWillStartForAttacker:wave];
	}
	else {
		[self.battleEngine battleDidEndForAttacker:wave];
	}
}

@end
