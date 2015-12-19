#import "DEMBaseItem.h"

@implementation DEMBaseItem

- (instancetype)init {
	self = [super init];
	if (self == nil) return nil;

	_uuid = [DEMUUID uuid];

	return self;
}

@end
