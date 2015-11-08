#import <Kiwi/Kiwi.h>
#import "DEMGameVM.h"


SPEC_BEGIN(DEMGameVMSpec)

describe(@"DEMGameVM", ^{

	let(gameVM, ^DEMGameVM *{
		return [[DEMGameVM alloc] init];
	});

	it(@"Should create", ^{

		[[gameVM shouldNot] beNil];
		[[gameVM.motherShipVM shouldNot] beNil];
		[[gameVM.storeVM shouldNot] beNil];
		[[gameVM.gameCore shouldNot] beNil];
		
	});

});

SPEC_END
