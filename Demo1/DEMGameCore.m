#import "DEMGameCore.h"

#import "DEMGameEngine.h"

@interface DEMGameCore () <DEMGameEngineProtocol>

@property (nonatomic, strong, readonly) DEMGameEngine *engine;

@end

@implementation DEMGameCore

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_engine = [[DEMGameEngine alloc] init];

	return self;
}

#pragma mark DEMGameEngineDelegate

- (void)tick
{
	
}

@end
