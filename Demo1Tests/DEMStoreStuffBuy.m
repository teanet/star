#import <Kiwi/Kiwi.h>
#import "DEMStoreStuffBuy.h"

SPEC_BEGIN(DEMStoreStuffBuySpec)

describe(@"DEMStoreStuffBuy", ^{

	__block DEMStoreStuffBuy *store = nil;
	__block NSObject<DEMActionExchangeProtocol> *visitor = nil;
	beforeEach(^{

		visitor = KWMockProtocol(DEMActionExchangeProtocol);
		store = [[DEMStoreStuffBuy alloc] initWithVisitor:visitor];

	});

	it(@"Should create", ^{

		[[store shouldNot] beNil];
		[[(id)store.visitor should] equal:visitor];
		[[store.items should] haveCountOf:1];

	});

});

SPEC_END
