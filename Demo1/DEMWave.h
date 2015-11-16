#import "DEMAttackerProtocol.h"
#import "DEMClockEngineProtocol.h"
#import "DEMProgressProtocol.h"

extern const NSTimeInterval kDEMMinimumDurationTime;
extern const NSTimeInterval kDEMMinimumScheduleTime;
extern const NSTimeInterval kDEMDefaultDPS;

typedef NS_OPTIONS(NSUInteger, DEMWaveState) {
	DEMWaveStateDead	= 0,
	DEMWaveStateBorned	= 0,
	DEMWaveStateActive	= 1 << 0,
	DEMWaveStateRun		= 1 << 1,
};

@interface DEMWave : NSObject
<
DEMAttackerProtocol,
DEMClockEngineProtocol,
DEMProgressProtocol
>

@property (nonatomic, assign, readonly) uint32_t level;
@property (nonatomic, assign, readonly) DEMWaveState state;

/** Wave Duration - максимальное время активного действтия волны */
@property (nonatomic, assign, readonly) NSTimeInterval duration;

/** Schedule Time - время ожидания волны */
@property (nonatomic, assign, readonly) NSTimeInterval scheduleTime;

@property (nonatomic, assign, readonly) NSTimeInterval totalWaveDuration;

- (void)activate:(BOOL)activate;
- (BOOL)isActive;
- (BOOL)isRunning;

//- (void)pass;
//- (void)fail;

@end
