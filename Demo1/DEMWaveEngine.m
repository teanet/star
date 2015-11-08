#import "DEMWaveEngine.h"

@interface DEMWaveEngine ()

@property (nonatomic, strong) NSMutableSet<DEMWave *> *waves;

@end

@implementation DEMWaveEngine

- (instancetype)initWithDelegate:(NSObject<DEMWaveEngineDelegate> *)delegate
{
	self = [super init];
	if (self)
	{
		_delegate = delegate;
		_waves = [NSMutableSet set];
	}
	return self;
}

- (void)addWave:(DEMWave *)wave
{
	[_waves addObject:wave];
	[wave activate:YES];
	[_delegate waveEngine:self didChangeStateForWave:wave];
}

- (NSInteger)activeWavesCount
{
	return _waves.count;
}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration
{
	[_waves enumerateObjectsUsingBlock:^(DEMWave *wave, BOOL *stop) {
//		DEMWaveState sta
		[wave tick:duration];
	}];
}

@end
