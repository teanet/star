#import <Kiwi/Kiwi.h>
#import "DEMGravizzappa.h"
#import "DEMCharacteristicEps.h"

extern const double kDEMDefaultEPS;

@interface DEMGravizzappa (DGSTesting)
<
DEMResources,
DEMUpgradableStuffProtocol
>

@property (nonatomic, assign) uint32_t level;
@property (nonatomic, strong, readonly) NSMutableArray<DEMCharacteristicEps *> *charachteristics;

- (double)calculatedEps;

@end

SPEC_BEGIN(DEMGravizzappaSpec)

describe(@"DEMGravizzappa", ^{

	__block DEMGravizzappa *gravizzappa = nil;

	beforeEach(^{

		gravizzappa = [[DEMGravizzappa alloc] init];

	});

	it(@"Should create", ^{

		[[gravizzappa shouldNot] beNil];
		[[gravizzappa.name shouldNot] beNil];
		[[gravizzappa.resources shouldNot] beNil];
		[[theValue(gravizzappa.price) should] equal:kDEMInitialGravizzappaPrice withDelta:DBL_EPSILON];
		[[theValue(gravizzappa.energyPerSecond) should] equal:kDEMDefaultEPS withDelta:DBL_EPSILON];
		[[theValue(gravizzappa.level) should] equal:theValue(0)];
		[[gravizzappa.charachteristics should] haveCountOf:1];

	});

	it(@"should calculate eps", ^{

		[[theValue([gravizzappa calculatedEps]) should] equal:kDEMDefaultEPS withDelta:DBL_EPSILON];

	});

	it(@"should be always upgradable", ^{

		[[theValue(gravizzappa.canBeUpgraded) should] beYes];

	});

	it(@"should upgrade", ^{

		[gravizzappa upgrade];

		[[theValue(gravizzappa.level) should] equal:theValue(1)];
		[[theValue(gravizzappa.energyPerSecond) should] beGreaterThan:theValue(kDEMDefaultEPS)];
		[[theValue(gravizzappa.price) should] beGreaterThan:theValue(kDEMInitialGravizzappaPrice)];

	});

});

SPEC_END
