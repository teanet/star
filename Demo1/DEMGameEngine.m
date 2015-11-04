#import "DEMGameEngine.h"

const NSTimeInterval kDEMDefaultTimePeriod = 0.1;

@interface DEMGameEngine ()

@property (nonatomic, strong)  NSTimer *timer;

@end

@implementation DEMGameEngine

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
											  target:self.delegate
											selector:@selector(tick)
											userInfo:nil
											 repeats:YES];
}

- (void)stop
{
	[self.timer invalidate], self.timer = nil;
}

@end
