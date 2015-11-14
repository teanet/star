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

	it(@"Should get surrent mothership attack damage", ^{
		[[theValue(mothership.dps) should] equal:0.0 withDelta:DBL_EPSILON];
	});

	it(@"Should install gravizzappa", ^{
		DEMGravizzappa *gravizzappa = [KWMock mockForClass:[DEMGravizzappa class]];
		[mothership installGravizzappa:gravizzappa];

		[[mothership.gravizzappa should] equal:gravizzappa];
	});

	context(@"energy level", ^{

		it(@"should set energy level with 1", ^{

			mothership.currentEnergyLevel = 1.0;
			[[theValue(mothership.currentEnergyLevel) should] equal:1.0 withDelta:DBL_EPSILON];

		});

		it(@"Should receive 1 damage", ^{

			mothership.currentEnergyLevel = 10.0;
			[mothership receiveDamage:1.0];
			[[theValue(mothership.currentEnergyLevel) should] equal:9.0 withDelta:DBL_EPSILON];

		});

		it(@"Initial energy should be equal 0.0", ^{

			[[theValue(mothership.currentEnergyLevel) should] equal:0.0 withDelta:DBL_EPSILON];

		});

		it(@"should send energy state signal with EMPTY", ^{

			NSNumber *_state = [mothership.energyStateSignal dgs_subscribeNextSyncWithActionBlock:^{
				mothership.currentEnergyLevel = -1.0;
			}];
			[[_state should] equal:@(DEMMotherShipEnegyStateEmpty)];

		});

	});

	context(@"gravizzappa", ^{

		__block DEMGravizzappa *gravizzappa = nil;
		beforeEach(^{
			gravizzappa = KWMockClass(DEMGravizzappa);
			[mothership installGravizzappa:gravizzappa];
		});

		it(@"should increase energu level when gr installed on tick", ^{

			[gravizzappa stub:@selector(energyPerSecond) andReturn:theValue(0.1)];
			double _currentEnergyLevel = mothership.currentEnergyLevel;
			[mothership tick:0.1];
			[[theValue(mothership.currentEnergyLevel) should] beGreaterThan:theValue(_currentEnergyLevel)];

		});

	});

});

SPEC_END
