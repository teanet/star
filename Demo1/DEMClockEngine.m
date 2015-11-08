#import "DEMClockEngine.h"

const NSTimeInterval kDEMDefaultTimePeriod = 0.1;

@interface DEMClockEngine ()

@property (nonatomic, strong)  NSTimer *timer;

@end

@implementation DEMClockEngine

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_period = kDEMDefaultTimePeriod;

	return self;
}

- (void)start
{
	_timer = [NSTimer scheduledTimerWithTimeInterval:kDEMDefaultTimePeriod
											  target:self
											selector:@selector(tick:)
											userInfo:nil
											 repeats:YES];
}

- (void)tick:(NSTimer *)timer
{
	[self.delegate tick:kDEMDefaultTimePeriod];
}

- (void)stop
{
	[self.timer invalidate], self.timer = nil;
}

@end
