#import "DEMWaveEngine.h"

@interface DEMWaveEngine ()

@property (nonatomic, strong) NSMutableSet<DEMWave *> *waves;

@end

@implementation DEMWaveEngine

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		_waves = [NSMutableSet set];
	}
	return self;
}

- (void)addWave:(DEMWave *)wave
{
	[self.waves addObject:wave];
	[wave activate:YES];
	[self.delegate waveEngine:self didChangeStateForWave:wave];
}

- (NSInteger)activeWavesCount
{
	return self.waves.count;
}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration
{
	[self.waves enumerateObjectsUsingBlock:^(DEMWave *wave, BOOL *stop) {
		DEMWaveState state = wave.state;
		[wave tick:duration];
		
		if (state != wave.state)
		{
			[self.delegate waveEngine:self didChangeStateForWave:wave];
		}
	}];
}

@end
