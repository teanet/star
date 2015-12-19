#import <Kiwi/Kiwi.h>
#import "DEMStoreVM.h"
#import "DEMMotherShipVM.h"

static NSString * const kTitle0 = @"kTitle1";
static NSString * const kTitle1 = @"kTitle2";

SPEC_BEGIN(DEMStoreVMSpec)

describe(@"DEMStoreVM", ^{

	__block DEMStoreVM *storeVM = nil;
	__block NSObject *visitor = nil;
	__block DEMVisitorPlace *visitorPlace0 = nil;
	__block DEMVisitorPlace *visitorPlace1 = nil;

	DEMVisitorPlace *(^newVisitorPlace)(NSString *) = ^(NSString *title) {
		DEMVisitorPlace *visitorPlace = KWNullMockClass(DEMVisitorPlace);
		[visitorPlace stub:@selector(items) andReturn:@[]];
		[visitorPlace stub:@selector(title) andReturn:title];
		return visitorPlace;
	};

	beforeEach(^{

		visitor = KWNullMockClass(NSObject);
		visitorPlace0 = newVisitorPlace(kTitle0);
		visitorPlace1 = newVisitorPlace(kTitle1);
		storeVM = [[DEMStoreVM alloc] initWithVisitor:visitor places:@[visitorPlace0, visitorPlace1]];

	});

	it(@"Should create", ^{

		[[storeVM shouldNot] beNil];
		[[(id)storeVM.visitor should] equal:visitor];
		[[storeVM.title should] equal:kTitle0];
		[[storeVM.items should] haveCountOf:0];
		[[storeVM.placeTitles should] equal:@[kTitle0, kTitle1]];
		[[theValue(storeVM.placesCount) should] equal:theValue(2)];
		[[theValue(storeVM.canProcessVisitor) should] beNo];
		[[theValue(storeVM.selectedPlaceIndex) should] equal:theValue(0)];

	});

	it(@"should select place at index 1", ^{

		[storeVM selectPlaceWithIndex:1];

		[[theValue(storeVM.selectedPlaceIndex) should] equal:theValue(1)];

	});

	it(@"shouldn't select place at index 5", ^{

		[storeVM selectPlaceWithIndex:5];

		[[theValue(storeVM.selectedPlaceIndex) should] equal:theValue(0)];

	});
	
	it(@"shouldn't select place at index -1", ^{

		[storeVM selectPlaceWithIndex:-1];

		[[theValue(storeVM.selectedPlaceIndex) should] equal:theValue(0)];

	});
	
	it(@"should processItemAtIndex 1", ^{

		[[visitorPlace0 should] receive:@selector(processItemAtIndex:) withArguments:theValue(1)];

		[storeVM processItemAtIndex:1];

	});

//	context(@"process stuff", ^{
//
//		it(@"should process stuff for upgrade mode", ^{
//
//			[[storeVM should] receive:@selector(upgrade:) withArguments:stuff];
//
//			storeVM.mode = DEMStoreModeUpgrade;
//			[storeVM process:stuff];
//			
//		});
//
//		it(@"should process stuff for buy mode", ^{
//
//			[[storeVM should] receive:@selector(buy:) withArguments:stuff];
//
//			storeVM.mode = DEMStoreModeBuy;
//			[storeVM process:stuff];
//			
//		});
//
//	});
//
//	context(@"buy stuff", ^{
//
//		it(@"should buy stuff", ^{
//
//			[[motherShip should] receive:@selector(purchaseStuff:withCompletionBlock:)];
//
//			[motherShip stub:@selector(canPurchaseStuff:) andReturn:theValue(YES)];
//			[storeVM buy:stuff];
//
//		});
//
//		it(@"shouldn't buy stuff", ^{
//
//			[[motherShip shouldNot] receive:@selector(purchaseStuff:withCompletionBlock:)];
//
//			[motherShip stub:@selector(canPurchaseStuff:) andReturn:theValue(NO)];
//			NSObject<DEMExchangeStuffProtocol> *stuff = KWMockProtocol(DEMExchangeStuffProtocol);
//			[storeVM buy:stuff];
//
//		});
//
//		it(@"should receive fail signal whaen item can't be purchased", ^{
//
//			[[[storeVM.didFailPurchaseSignal dgs_lastObjectAfterAction:^{
//
//				[motherShip stub:@selector(canPurchaseStuff:) andReturn:theValue(NO)];
//				[storeVM buy:stuff];
//
//			}] should] beKindOfClass:[NSError class]];
//			
//		});
//
//	});
//
//	context(@"upgrade stuff", ^{
//
//		it(@"should upgrade stuff", ^{
//
//			[[motherShip should] receive:@selector(purchaseStuff:withCompletionBlock:)];
//
//			[motherShip stub:@selector(canPurchaseStuff:) andReturn:theValue(YES)];
//			[storeVM buy:stuff];
//
//		});
//
//		pending(@"shouldn't upgrade stuff", ^{
//
//			[[motherShip shouldNot] receive:@selector(purchaseStuff:withCompletionBlock:)];
//
//			[motherShip stub:@selector(canPurchaseStuff:) andReturn:theValue(NO)];
//			NSObject<DEMExchangeStuffProtocol> *stuff = KWMockProtocol(DEMExchangeStuffProtocol);
//			[storeVM buy:stuff];
//
//		});
//
//		pending(@"should receive fail signal whaen item can't be purchased", ^{
//
//			[[[storeVM.didFailPurchaseSignal dgs_lastObjectAfterAction:^{
//
//				[motherShip stub:@selector(canPurchaseStuff:) andReturn:theValue(NO)];
//				[storeVM buy:stuff];
//
//			}] should] beKindOfClass:[NSError class]];
//			
//		});
//		
//	});
//
//	context(@"switch modes", ^{
//
//		__block NSObject<DEMExchangeStuffProtocol> *storeStuff = nil;
//		__block NSObject<DEMExchangeStuffProtocol> *buyerStuff = nil;
//
//		beforeEach(^{
//
//			storeStuff = KWMockProtocol(DEMExchangeStuffProtocol);
//			buyerStuff = KWMockProtocol(DEMExchangeStuffProtocol);
//			[motherShip stub:@selector(stuffItems) andReturn:@[buyerStuff]];
//			[store stub:@selector(stuffItems) andReturn:@[storeStuff]];
//
//		});
//
//		it(@"should switch to upgrade mode", ^{
//
//			storeVM.mode = DEMStoreModeUpgrade;
//			[[storeVM.stuffItems should] containObjects:buyerStuff, nil];
//
//		});
//
//		it(@"should switch to buy mode", ^{
//
//			storeVM.mode = DEMStoreModeBuy;
//			[[storeVM.stuffItems should] containObjects:storeStuff, nil];
//
//		});
//
//	});

});

SPEC_END
