#import "DEMBattleProtocol.h"
#import "DEMClockEngineProtocol.h"

extern const NSTimeInterval kDEMMinimumDurationTime;
extern const NSTimeInterval kDEMMinimumScheduleTime;

typedef NS_OPTIONS(NSUInteger, DEMWaveState) {
	DEMWaveStateDead	= 0,
	DEMWaveStateBorned	= 0,
	DEMWaveStateActive	= 1 << 0,
	DEMWaveStateRun		= 1 << 1,
};

@interface DEMWave : NSObject
<
DEMBattleProtocol,
DEMClockEngineProtocol
>

@property (nonatomic, assign, readonly) uint32_t level;
@property (nonatomic, assign, readonly) float progress;
@property (nonatomic, assign, readonly) DEMWaveState state;

/** Wave Duration - максимальное время активного действтия волны */
@property (nonatomic, assign, readonly) NSTimeInterval duration;

/** Schedule Time - время ожидания волны */
@property (nonatomic, assign, readonly) NSTimeInterval scheduleTime;

- (void)activate:(BOOL)activate;

- (void)pass;
- (void)fail;

@end
