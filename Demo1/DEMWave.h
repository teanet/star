#import "DEMBattleProtocol.h"
#import "DEMGameEngineProtocol.h"

extern const NSTimeInterval kDEMMinimumDurationTime;
extern const NSTimeInterval kDEMMinimumScheduleTime;

typedef NS_ENUM(NSUInteger, DEMWaveState) {
	DEMWaveStateScheduling = 0,
	DEMWaveStateRunnig
};

@interface DEMWave : NSObject
<
DEMBattleProtocol,
DEMGameEngineProtocol
>

@property (nonatomic, assign, readonly) uint32_t level;
@property (nonatomic, assign, readonly) float progress;
@property (nonatomic, assign, readonly) DEMWaveState state;

/** Wave Duration - максимальное время активного действтия волны */
@property (nonatomic, assign, readonly) NSTimeInterval duration;

/** Schedule Time - время ожидания волны */
@property (nonatomic, assign, readonly) NSTimeInterval scheduleTime;

- (void)pass;
- (void)fail;

@end
