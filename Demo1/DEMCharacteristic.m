#import "DEMCharacteristic.h"

@implementation DEMCharacteristic

+ (instancetype)withValue:(double)value
{
	return [[self.class alloc] initWithValue:value];
}

- (instancetype)initWithValue:(double)value
{
	self = [super init];
	if (self == nil) return nil;

	_value = value;

	return self;
}

@end
