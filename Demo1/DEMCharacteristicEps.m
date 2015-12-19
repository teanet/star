#import "DEMCharacteristicEps.h"

@implementation DEMCharacteristicEps

@synthesize type = _type;
@synthesize name = _name;

- (instancetype)initWithValue:(double)value {
	self = [super initWithValue:value];
	if (self == nil) return nil;

	_name = @"eps";
	_type = kDEMCharacteristicEPS;

	return self;
}

@end
