#import <Kiwi/Kiwi.h>
#import "DEMWarehouseVM.h"


SPEC_BEGIN(DEMWarehouseVMSpec)

describe(@"DEMWarehouseVM", ^{


	__block NSObject<DEMWarehouseItem> *item = nil;
	__block DEMWarehouseVM *warehouse = nil;

	beforeEach(^{
		warehouse = [[DEMWarehouseVM alloc] init];
		item = KWNullMockProtocol(DEMWarehouseItem);
	});

	it(@"should init with initial capacity", ^{

		[[theValue(warehouse.capacity) should] equal:theValue(100)];

	});

	it(@"should add intem", ^{

		[warehouse storeItem:item];

		[[warehouse.items should] haveCountOf:1];

	});

	it(@"should have 0 energy at start", ^{

		[[theValue([warehouse hasEnegry:1]) should] beNo];

	});

	it(@"should have 0 energy at start", ^{

		[[theValue([warehouse hasEnegry:-1]) should] beYes];

	});

	it(@"should exceed capacity", ^{

		[warehouse stub:@selector(capacity) andReturn:theValue(0)];
		[warehouse storeItem:item];
		[[warehouse.items should] haveCountOf:0];

	});

});

SPEC_END
