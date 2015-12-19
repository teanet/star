#import "DEMEntityExchangableProtocol.h"

@protocol DEMActionExchangeProtocol <NSObject>

@property (nonatomic, strong, readonly) RACSignal *didChangeMoneySignal;
//@property (nonatomic, strong) NSArray<NSObject<DEMEntityExchangableProtocol> *> *exchangableItems;

- (BOOL)canPurchaseStuff:(id<DEMEntityExchangableProtocol>)stuff;
- (void)purchaseStuff:(id<DEMEntityExchangableProtocol>)stuff withCompletionBlock:(void (^)(BOOL didPurchase))block;

@end
