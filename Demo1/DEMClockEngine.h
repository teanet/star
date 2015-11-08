

#import "DEMClockEngineProtocol.h"

extern const NSTimeInterval kDEMDefaultTimePeriod;

@interface DEMClockEngine : NSObject

@property (nonatomic, assign) NSTimeInterval period;
@property (nonatomic, weak) id<DEMClockEngineProtocol> delegate;

- (void)start;
- (void)stop;

@end
