#import "DEMGameEngineProtocol.h"

@protocol DEMWaveEngineDelegate;

@interface DEMWaveEngine : NSObject
<
DEMGameEngineProtocol
>

- (instancetype)initWithDelegate:(id<DEMWaveEngineDelegate>)delegate;

@end

@protocol DEMWaveEngineDelegate <NSObject>

- (void)waveEngine:(DEMWaveEngine *)engine;

@end
