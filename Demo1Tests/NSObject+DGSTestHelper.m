#import "NSObject+DGSTestHelper.h"

@implementation RACSignal (DGSTestHelper)

- (id)dgs_subscribeNextSyncWithActionBlock:(dispatch_block_t)block
{
	__block id _x;
	[self subscribeNext:^(id x) {
		_x = x;
	}];
	if (block)
	{
		block();
	}
	return _x;
}

@end
