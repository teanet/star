#import "DEMWave.h"
#import <UIKit/UIKit.h>
const NSTimeInterval kDEMMinimumDurationTime = 30.0;
const NSTimeInterval kDEMMinimumScheduleTime = 60.0;

#define CHECK_ACTIVE_STATE() {if (!self.isActive) return;}

@interface DEMWave ()

@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) float progress;

@end

@implementation DEMWave

@synthesize state=_privateState;

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;
	_duration = kDEMMinimumDurationTime;
	_scheduleTime = kDEMMinimumScheduleTime;
	_currentTime = 0.0;
	_privateState = DEMWaveStateDead;

	return self;
}

- (NSTimeInterval)totalWaveDuration
{
	return _duration + _scheduleTime;
}

- (void)activate:(BOOL)activate
{
	_privateState = (activate) ? (_privateState | DEMWaveStateActive) : (_privateState & ~DEMWaveStateActive);
}

- (void)setRunning:(BOOL)running
{
	_privateState = (running) ? (_privateState | DEMWaveStateRun) : (_privateState & ~DEMWaveStateRun);
}

- (BOOL)isActive
{
	return DEMWaveStateActive == (_privateState & DEMWaveStateActive);
}

- (BOOL)isRunning
{
	return DEMWaveStateRun == (_privateState & DEMWaveStateRun);
}

- (void)pass
{

}

- (void)fail
{

}

- (void)updateProgress
{
	if (self.isRunning)
	{
		self.progress = (_currentTime - _scheduleTime) / _duration;
	}
	else
	{
		self.progress = _currentTime / _scheduleTime;
	}
}

#pragma mark DEMBattleProtocol

- (double)attackDamage
{
	return 0.0;
}

- (void)receiveDamage:(double)damage
{
	
}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration
{
	CHECK_ACTIVE_STATE();

	_currentTime += duration;
	_currentTime = fmod(_currentTime, [self totalWaveDuration]);

	[self setRunning:_currentTime >= _scheduleTime];
	[self updateProgress];
}

@end
