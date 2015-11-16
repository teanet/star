#import "DEMWave.h"

const NSTimeInterval kDEMMinimumDurationTime = 1.0;
const NSTimeInterval kDEMMinimumScheduleTime = 10.0;
const NSTimeInterval kDEMDefaultDPS = 1.0;
const double kDPSIncreaseFactor = 1.1;

#define CHECK_ACTIVE_STATE() {if (!self.isActive) return;}

@interface DEMWave ()

@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) BOOL passed;

@end

@implementation DEMWave

@synthesize state=_privateState;
@synthesize dps = _dps;
@synthesize delegate = _delegate;

- (instancetype)init {
	self = [super init];
	if (self == nil) return nil;
	// TODO: change to running time
	_duration = kDEMMinimumDurationTime;
	_scheduleTime = kDEMMinimumScheduleTime;
	_currentTime = 0.0;
	_privateState = DEMWaveStateDead;
	_dps = kDEMDefaultDPS;
	_passed = YES;
	return self;
}

- (NSTimeInterval)totalWaveDuration {
	return _duration + _scheduleTime;
}

- (void)activate:(BOOL)activate {
	_privateState = (activate) ? (_privateState | DEMWaveStateActive) : (_privateState & ~DEMWaveStateActive);
}

- (void)setRunning:(BOOL)running {
	_privateState = (running) ? (_privateState | DEMWaveStateRun) : (_privateState & ~DEMWaveStateRun);
}

- (BOOL)isActive {
	return DEMWaveStateActive == (_privateState & DEMWaveStateActive);
}

- (BOOL)isRunning {
	return DEMWaveStateRun == (_privateState & DEMWaveStateRun);
}

- (void)pass {
	NSLog(@"Увеличен уровень волны >>%@", self);
	_level++;
	_dps = kDEMDefaultDPS * pow(kDPSIncreaseFactor, _level);
}

- (NSString *)description {
	return [NSString stringWithFormat:@"Волна, уровень: %d, dps: %f", _level, _dps];
}

- (void)fail {

}

- (void)updateProgress {
	if (self.isRunning) {
		self.progress = (self.currentTime - _scheduleTime) / _duration;
	}
	else {
		self.progress = self.currentTime / _scheduleTime;
	}
}

- (NSTimeInterval)currentTime {
	return fmod(_currentTime, [self totalWaveDuration]);
}

#pragma mark DEMAttackerProtocol

- (void)markAsPassed:(BOOL)passed {
	_passed = passed;
}

- (void)receiveDamage:(double)damage {
	
}

- (void)finishBattle {
	if (_passed) {
		[self pass];
	}
}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration {
	CHECK_ACTIVE_STATE();

	_currentTime += duration;

	[self setRunning:self.currentTime >= _scheduleTime];
	[self updateProgress];
}

@end
