#import "DEMGameCore.h"

#import "DEMClockEngine.h"
#import "DEMWaveEngine.h"

@interface DEMGameCore () <DEMClockEngineProtocol, DEMWaveEngineDelegate>

@property (nonatomic, strong, readonly) DEMClockEngine *clockEngine;
@property (nonatomic, strong, readonly) DEMWaveEngine *waveEngine;
@property (nonatomic, strong) NSObject<DEMProgressProtocol> *progressVM;

@end

@implementation DEMGameCore

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_motherShip = [[DEMMotherShipVM alloc] init];
	_waveEngine = [[DEMWaveEngine alloc] initWithDelegate:self];

	_clockEngine = [[DEMClockEngine alloc] init];
	_clockEngine.delegate = self;


	return self;
}

- (void)start
{
	[_waveEngine addWave:[[DEMWave alloc] init]];
	[_clockEngine start];
}

#pragma mark DEMClockEngineDelegate

- (void)tick:(NSTimeInterval)duration
{
	[_waveEngine tick:duration];
}

#pragma mark DEMWaveEngineDelegate

- (void)waveEngine:(DEMWaveEngine *)engine didChangeStateForWave:(DEMWave *)wave
{
	self.progressVM = wave;
}

@end
