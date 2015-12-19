#import <Kiwi/Kiwi.h>
#import "DEMMotherShipVM.h"
#import "DEMGravizzappa.h"

@interface DEMMotherShipVM (Testing)
<DEMActionExchangeResourcesProtocol>

@property (nonatomic, strong, readonly) DEMGravizzappa *gravizzappa;
@property (nonatomic, strong, readonly) NSMutableDictionary<DEMUUID *, DEMBaseItem *> *allItems;

@end

SPEC_BEGIN(DEMMotherShipVMSpec)

describe(@"DEMMotherShipVM", ^{

	__block DEMMotherShipVM *mothership = nil;

	beforeEach(^{
		mothership = [[DEMMotherShipVM alloc] init];
	});

	it(@"Should create Mothership", ^{

		[[mothership shouldNot] beNil];
		[[mothership.allItems should] haveCountOf:0];

	});

	it(@"Should get surrent mothership attack damage", ^{
		[[theValue(mothership.dps) should] equal:0.0 withDelta:DBL_EPSILON];
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

		it(@"should send battleActionSignal with DIE", ^{

			NSNumber *_state = [mothership.battleActionSignal dgs_lastObjectAfterAction:^{
				mothership.currentEnergyLevel = -1.0;
			}];
			[[_state should] equal:@(DEMBattleActionDie)];

		});

		it(@"should have available resources", ^{

			DEMResources *resources = KWMockClass(DEMResources);
			[mothership.warehouse stub:@selector(availableResources) andReturn:resources];
			[[mothership.availableResources should] equal:resources];

		});

	});

	context(@"DEMExchangeProtocol", ^{

		__block NSObject<DEMEntityExchangableProtocol> *stuff = nil;

		beforeEach(^{

			stuff = KWMockProtocol(DEMEntityExchangableProtocol);
			[stuff stub:@selector(price) andReturn:theValue(100.0)];

		});

		pending(@"can purchase stuff", ^{

			[mothership stub:@selector(availableEnergyCredits) andReturn:theValue(100.0)];

			[[theValue([mothership canPurchaseStuff:stuff]) should] beYes];

		});

		pending(@"can't purchase stuff", ^{

			[mothership stub:@selector(availableEnergyCredits) andReturn:theValue(99.0)];

			[[theValue([mothership canPurchaseStuff:stuff]) should] beNo];
			
		});

		it(@"should purchase stuff", ^{

			[mothership stub:@selector(canPurchaseStuff:) andReturn:theValue(YES)];
			[mothership stub:@selector(installStuff:) andReturn:theValue(YES)];

			[mothership purchaseStuff:stuff withCompletionBlock:^(BOOL didPurchase) {
				[[theValue(didPurchase) should] beYes];
			}];

		});

		it(@"shouldn't purchase stuff", ^{

			[mothership stub:@selector(canPurchaseStuff:) andReturn:theValue(NO)];

			[mothership purchaseStuff:stuff withCompletionBlock:^(BOOL didPurchase) {
				[[theValue(didPurchase) should] beNo];
			}];
			
		});
		
	});

	context(@"DEMVisitorProtocol", ^{

		it(@"should return empty uuids", ^{

			[[[mothership allUUIDs] should] haveCountOf:0];

		});

		it(@"should return item with uuid", ^{

			DEMBaseItem *item = KWNullMockClass(DEMBaseItem);
			DEMUUID *uuid = KWNullMockClass(DEMUUID);
			[mothership stub:@selector(allItems) andReturn:@{ uuid : item }];

			[[[mothership itemWithUUID:uuid] should] equal:item];

		});

	});

	context(@"install stuff", ^{

		__block NSObject<DEMStuffProtocol> *stuff = nil;

		beforeEach(^{

			stuff = KWMockProtocol(DEMStuffProtocol);
			[stuff stub:@selector(price) andReturn:theValue(100.0)];

		});

		it(@"shouldn't install random stuff", ^{

			[[theValue([mothership installStuff:stuff]) should] beNo];

		});

		context(@"resources", ^{

			pending(@"should return avaliable resources", ^{



			});

		});

		context(@"gravizzappa", ^{

			__block DEMGravizzappa *gravizzappa = nil;

			beforeEach(^{

				gravizzappa = KWMockClass(DEMGravizzappa);
				[gravizzappa stub:@selector(uuid) andReturn:@"uuid"];
				[gravizzappa stub:@selector(copy) andReturn:gravizzappa];
				[mothership installStuff:gravizzappa];

			});

			it(@"should increase energu level when gr installed on tick", ^{

				[gravizzappa stub:@selector(energyPerSecond) andReturn:theValue(0.1)];
				double _currentEnergyLevel = mothership.currentEnergyLevel;
				[mothership tick:0.1];

				[[theValue(mothership.currentEnergyLevel) should] beGreaterThan:theValue(_currentEnergyLevel)];

			});

			it(@"Should install gravizzappa", ^{

				[[mothership.gravizzappa should] equal:gravizzappa];
				[[mothership.installedItems should] containObjects:gravizzappa, nil];
				
			});

			it(@"shouldn't install gravizzappa twice", ^{

				[[theValue([mothership installStuff:gravizzappa]) should] beNo];
				[[mothership.installedItems should] haveCountOf:1];


			});
			
		});

	});

});

SPEC_END
