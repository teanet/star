#import <Kiwi/Kiwi.h>
#import "DEMStoreVM.h"
#import "DEMMotherShipVM.h"

SPEC_BEGIN(DEMStoreVMSpec)

describe(@"DEMStoreVM", ^{

	__block DEMMotherShipVM *_motherShip;
	__block DEMStoreVM *_store;

	beforeEach(^{
		_motherShip = [KWMock mockForClass:[DEMMotherShipVM class]];
		_store = [[DEMStoreVM alloc] initWithMotherShipVM:_motherShip];
	});

	it(@"Should create", ^{
		[[_store shouldNot] beNil];
		[[_store.motherShipVM shouldNot] beNil];
	});

});

SPEC_END
