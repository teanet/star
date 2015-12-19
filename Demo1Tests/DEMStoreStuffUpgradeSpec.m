#import <Kiwi/Kiwi.h>

#import "DEMStoreStuffUpgrade.h"
#import "DEMActionUpgradeProtocol.h"
#import "DEMEntityUpgradableProtocol.h"

SPEC_BEGIN(DEMStoreStuffUpgradeSpec)

describe(@"DEMStoreStuffUpgrade", ^{

	__block DEMStoreStuffUpgrade *store = nil;
	__block NSObject<DEMVisitorProtocol, DEMActionUpgradeProtocol> *visitor = nil;
	__block NSObject<DEMEntityUpgradableProtocol> *item = nil;

	beforeEach(^{

		visitor = KWNullMockProtocol(DEMVisitorProtocol);
		store = [[DEMStoreStuffUpgrade alloc] initWithVisitor:visitor];
		item = KWNullMockProtocol(DEMEntityUpgradableProtocol);

	});

	context(@"Initialization", ^{

		it(@"should init", ^{

			[[store shouldNot] beNil];
			[[store.items should] haveCountOf:0];

		});

		it(@"should obtain all uuids from visitor", ^{

			[visitor stub:@selector(allUUIDs) andReturn:@[ @"1", @"2" ]];
			[visitor stub:@selector(itemWithUUID:) andReturn:KWNullMockProtocol(DEMEntityUpgradableProtocol)];
			store = [[DEMStoreStuffUpgrade alloc] initWithVisitor:visitor];

			[[store.items should] haveCountOf:2];

		});

		it(@"should process correct visitor", ^{

			[[theValue([store canProcessVisitor]) should] beYes];

		});

		it(@"should upgrade item at index 0", ^{

			[[item should] receive:@selector(upgrade)];

			[store stub:@selector(items) andReturn:@[item]];

			[store processItemAtIndex:0];

		});

	});

});

SPEC_END
