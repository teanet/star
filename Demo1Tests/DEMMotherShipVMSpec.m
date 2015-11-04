#import <Kiwi/Kiwi.h>
#import "DEMMotherShipVM.h"
#import "DEMGravizzappa.h"

@interface DEMMotherShipVM (Testing)

@property (nonatomic, strong, readonly) DEMGravizzappa *gravizzappa;

@end

SPEC_BEGIN(DEMMotherShipVMSpec)

describe(@"DEMMotherShipVM", ^{

	let(mothership, ^DEMMotherShipVM *{
		return [[DEMMotherShipVM alloc] init];
	});

	it(@"Should create Mothership", ^{
		[[mothership shouldNot] beNil];
	});

	it(@"Should receive 1 damage", ^{
		[mothership receiveDamage:1.0];

		[[theValue(mothership.currentEnergyLevel) should] equal:-1.0 withDelta:DBL_EPSILON];
	});

	it(@"Initial energy should be equal 0.0", ^{
		[[theValue(mothership.currentEnergyLevel) should] equal:0.0 withDelta:DBL_EPSILON];
	});

	it(@"Should get surrent mothership attack damage", ^{
		[[theValue(mothership.attackDamage) should] equal:0.0 withDelta:DBL_EPSILON];
	});

	it(@"Should install gravizzappa", ^{
		DEMGravizzappa *gravizzappa = [KWMock mockForClass:[DEMGravizzappa class]];
		[mothership installGravizzappa:gravizzappa];

		[[mothership.gravizzappa should] equal:gravizzappa];
	});
});

SPEC_END
