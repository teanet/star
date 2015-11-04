#import <Kiwi/Kiwi.h>
#import "DEMWarehouseVM.h"


SPEC_BEGIN(DEMWarehouseVMSpec)

describe(@"DEMWarehouseVM", ^{

	let(warehouse, ^DEMWarehouseVM *{
		return [[DEMWarehouseVM alloc] init];
	});

	it(@"should init with initial capacity", ^{

		[[theValue(warehouse.capacity) should] equal:theValue(100)];

	});

	it(@"should add intem", ^{

		NSObject<DEMWarehouseItem> *item = [KWMock nullMockForProtocol:@protocol(DEMWarehouseItem)];
		[warehouse storeItem:item];

		[[warehouse.items should] haveCountOf:1];

	});

	it(@"should have 0 energy at start", ^{

		[[theValue([warehouse hasEnegry:1]) should] beNo];

	});

	it(@"should have 0 energy at start", ^{

		[[theValue([warehouse hasEnegry:-1]) should] beYes];

	});

});

SPEC_END
