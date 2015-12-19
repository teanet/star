#import "DEMGravizzappa.h"

#import "DEMCharacteristicEps.h"
#import "DEMResources.h"

const double kDEMDefaultEPS = 0.1;
const double kDEMEPSPowFactor = 1.05;
const double kDEMInitialGravizzappaPrice = 50.0;
const double kDEMPriceFactor = 1.3;

@interface DEMGravizzappa ()
<
DEMResources,
DEMUpgradableStuffProtocol
>

@property (nonatomic, assign) uint32_t level;
@property (nonatomic, assign, readwrite) double price;
@property (nonatomic, assign, readwrite) double energyPerSecond;
@property (nonatomic, strong, readonly) NSMutableArray<DEMCharacteristic *> *charachteristics;

@end

@implementation DEMGravizzappa

@synthesize name = _name;
@synthesize price = _price;
@synthesize energyPerSecond = _energyPerSecond;
@synthesize resources = _resources;

- (instancetype)init {
	self = [super init];
	if (self) {

		_name = NSLocalizedString(@"Гравицаппа", @"");
		_price = kDEMInitialGravizzappaPrice;
		_charachteristics = [@[ [DEMCharacteristicEps withValue:kDEMDefaultEPS] ] mutableCopy];
		_energyPerSecond = [self calculatedEps];
		_resources = [[DEMResources alloc] init];

	}
	return self;
}

- (double)calculatedEps {
	__block double eps = 0.0;

	[self.charachteristics enumerateObjectsUsingBlock:^(DEMCharacteristic *ch, NSUInteger idx, BOOL *_) {
		if ([ch.type isEqualToString:kDEMCharacteristicEPS]) {
			eps += ch.value;
		}
	}];

	return eps;
}

#pragma mark DEMUpgradableProtocol
#warning TODO: make Upgradable Branches

- (BOOL)canBeUpgraded {
	return YES;
}

- (void)upgrade {
	self.level++;
	[self.charachteristics addObject:[DEMCharacteristicEps withValue:kDEMDefaultEPS]];
	self.energyPerSecond = [self calculatedEps];
	self.price = kDEMInitialGravizzappaPrice * pow(kDEMPriceFactor, self.level);
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
	DEMGravizzappa *newGravizzappa = [[DEMGravizzappa allocWithZone:zone] init];

	return newGravizzappa;
}

@end
