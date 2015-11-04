#import "DEMWave.h"

const NSTimeInterval kDEMMinimumDurationTime = 30.0;
const NSTimeInterval kDEMMinimumScheduleTime = 60.0;

@implementation DEMWave

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_duration = kDEMMinimumDurationTime;
	_scheduleTime = kDEMMinimumScheduleTime;

	return self;
}

- (void)pass {

}

- (void)fail {

}

#pragma mark DEMBattleProtocol

- (double)attackDamage {
	return 0.0;
}

- (void)receiveDamage:(double)damage {
	
}

#pragma mark DEMGameEngineProtocol

- (void)tick {

}

@end
