#import <Kiwi/Kiwi.h>
#import "DEMGravizzappa.h"

extern const double kDEMDefaultEPS;

SPEC_BEGIN(DEMGravizzappaSpec)

describe(@"DEMGravizzappa", ^{

	let(gravizzappa, ^DEMGravizzappa *{
		return [[DEMGravizzappa alloc] init];
	});

	it(@"Should create", ^{
		[[gravizzappa shouldNot] beNil];
		[[gravizzappa.name shouldNot] beNil];
		[[theValue(gravizzappa.price) should] equal:kDEMGravizzappaPrice withDelta:DBL_EPSILON];
		[[theValue(gravizzappa.energyPerSecond) should] equal:kDEMDefaultEPS withDelta:DBL_EPSILON];

	});

});

SPEC_END
