#import "DEMGravizzappa.h"

const double kDEMDefaultEPS = 0.1;
const double kDEMGravizzappaPrice = 500.0;

@implementation DEMGravizzappa

@synthesize name = _name;
@synthesize price = _price;
@synthesize energyPerSecond = _energyPerSecond;

- (instancetype)init
{
	self = [super init];
	if (self) {
		NSLocalizedString(@"", @"");
		_name = NSLocalizedString(@"Гравицаппа", @"");
		_price = kDEMGravizzappaPrice;

	}
	return self;
}

- (double)energyPerSecond {
	return kDEMDefaultEPS;
}

@end
