#import "DEMEnergyCellModel.h"

@interface DEMEnergyCellModel ()

@end

@implementation DEMEnergyCellModel

@synthesize capacity=_capacity;

- (instancetype)initWithEnergy:(double)energy
{
	self = [super init];
	if (self == nil) return nil;
	_capacity = 100.0;
	_currentEnergy = energy;
	return self;
}

- (void)addEnergy:(double)energy {
	_currentEnergy += energy;
}

- (double)isFull {
	return (_currentEnergy > _capacity);
}

- (NSString *)name {
	return NSLocalizedString(@"Energy cell", @"");
}

@end
