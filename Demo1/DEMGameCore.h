#import "DEMMotherShipVM.h"
#import "DEMProgressProtocol.h"
#import "DEMBattleEngine.h"
#import "DEMWaveEngine.h"

typedef NS_ENUM(NSUInteger, DEMGameFinishReason) {
	DEMGameFinishReasonLose,
};

@interface DEMGameCore : NSObject

@property (nonatomic, strong, readonly) DEMMotherShipVM *motherShip;
@property (nonatomic, strong, readonly) NSObject<DEMProgressProtocol> *progressVM;
@property (nonatomic, assign, readonly, getter=isRunning) BOOL running;

@property (nonatomic, strong, readonly) RACSignal *didFinishGameSignal;

- (instancetype)initWithMotherShip:(DEMMotherShipVM *)motherShip
					  battleEngine:(DEMBattleEngine *)battleEngine
						waveEngine:(DEMWaveEngine *)waveEngine NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
						
- (void)start;
- (void)stop;

@end
