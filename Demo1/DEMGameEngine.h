#import <Foundation/Foundation.h>

#import "DEMGameEngineProtocol.h"

extern const NSTimeInterval kDEMDefaultTimePeriod;

@interface DEMGameEngine : NSObject

@property (nonatomic, assign) NSTimeInterval period;
@property (nonatomic, weak) id<DEMGameEngineProtocol> delegate;

- (void)start;
- (void)stop;

@end
