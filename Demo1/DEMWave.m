#import "DEMWave.h"

const NSTimeInterval kDEMMinimumDurationTime = 1.0;
const NSTimeInterval kDEMMinimumScheduleTime = 3.0;
const NSTimeInterval kDEMDefaultDPS = 1.0;

#define CHECK_ACTIVE_STATE() {if (!self.isActive) return;}

@interface DEMWave ()

@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) float progress;

@end

@implementation DEMWave

@synthesize state=_privateState;

- (instancetype)init {
	self = [super init];
	if (self == nil) return nil;
	_duration = kDEMMinimumDurationTime;
	_scheduleTime = kDEMMinimumScheduleTime;
	_currentTime = 0.0;
	_privateState = DEMWaveStateDead;

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

- (void)pass{

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

#pragma mark DEMBattleProtocol

- (double)dps {
	return kDEMDefaultDPS;
}

- (void)receiveDamage:(double)damage {
	
}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration {
	CHECK_ACTIVE_STATE();

	_currentTime += duration;

	[self setRunning:_currentTime >= _scheduleTime];
	[self updateProgress];
}

@end
