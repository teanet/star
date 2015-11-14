@class DGSContextHolder;

#define KWMockClass(__CLASS_) ([KWMock mockForClass:[__CLASS_ class]])
#define KWNullMockClass(__CLASS_) ([KWMock nullMockForClass:[__CLASS_ class]])

@interface RACSignal (DGSTestHelper)

- (id)dgs_subscribeNextSyncWithActionBlock:(dispatch_block_t)block;

@end
