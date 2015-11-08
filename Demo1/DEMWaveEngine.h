#import "DEMClockEngineProtocol.h"
#import "DEMWave.h"

@protocol DEMWaveEngineDelegate;

@interface DEMWaveEngine : NSObject
<
DEMClockEngineProtocol
>

@property (nonatomic, weak, readonly) NSObject<DEMWaveEngineDelegate> *delegate;

- (instancetype)initWithDelegate:(NSObject<DEMWaveEngineDelegate> *)delegate;
- (NSInteger)activeWavesCount;
- (void)addWave:(DEMWave *)wave;

@end

@protocol DEMWaveEngineDelegate <NSObject>

- (void)waveEngine:(DEMWaveEngine *)engine didChangeStateForWave:(DEMWave *)wave;

@end
