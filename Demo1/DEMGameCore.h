#import "DEMMotherShipVM.h"
#import "DEMProgressProtocol.h"

typedef NS_ENUM(NSUInteger, DEMGameFinishReason) {
	DEMGameFinishReasonLose,
};

@interface DEMGameCore : NSObject

@property (nonatomic, strong, readonly) DEMMotherShipVM *motherShip;
@property (nonatomic, strong, readonly) NSObject<DEMProgressProtocol> *progressVM;
@property (nonatomic, assign, readonly, getter=isRunning) BOOL running;

@property (nonatomic, strong, readonly) RACSignal *didFinishGameSignal;

- (void)start;

@end
