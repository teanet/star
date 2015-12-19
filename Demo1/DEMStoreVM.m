#import "DEMStoreVM.h"

@interface DEMStoreVM ()

@property (nonatomic, copy, readonly) NSArray<__kindof DEMVisitorPlace *> *places;
@property (nonatomic, assign, readwrite) NSInteger selectedPlaceIndex;
//@property (nonatomic, strong, readonly) DEMStore *store;
//@property (nonatomic, strong, readonly) RACSubject* didFailPurchaseSubject;

@end

@implementation DEMStoreVM

@synthesize visitor = _visitor;

//- (void)dealloc {
//	[_didFailPurchaseSubject sendCompleted];
//}

- (instancetype)initWithVisitor:(id)visitor places:(NSArray<__kindof DEMVisitorPlace *> *)places {
	self = [super init];
	if (self == nil) return nil;

	_visitor = visitor;
	_places = places;
	_selectedPlaceIndex = 0;
	NSMutableArray *placeTitles = [NSMutableArray arrayWithCapacity:places.count];
	[places enumerateObjectsUsingBlock:^(__kindof DEMVisitorPlace * _Nonnull place, NSUInteger idx, BOOL * _Nonnull stop) {
		[placeTitles addObject:place.title];
	}];
	_placeTitles = [placeTitles copy];
//	_didFailPurchaseSubject = [RACSubject subject];
//	_didFailPurchaseSignal = _didFailPurchaseSubject;

	return self;
}

- (DEMVisitorPlace *)currentPlace {
	return self.places[self.selectedPlaceIndex];
}

#pragma mark DEMVisitorPlaceProtocol

- (NSString *)title {
	return self.currentPlace.title;
}

- (NSArray *)items {
	return self.currentPlace.items;
}

- (BOOL)canProcessVisitor {
	return NO;
}

- (void)selectPlaceWithIndex:(NSInteger)index {
	self.selectedPlaceIndex = (index < self.placesCount && index >= 0) ? (index) : (self.selectedPlaceIndex);
}

- (void)processItemAtIndex:(NSInteger)index {
	[self.currentPlace processItemAtIndex:index];
}

- (NSInteger)placesCount {
	return self.places.count;
}

//- (void)processItemAtIndex:(NSInteger)intex {
//	switch (self.mode) {
//		case DEMStoreModeBuy: {
//			//			[self buy:stuff];
//		} break;
//
//		case DEMStoreModeUpgrade: {
//			//			if ([stuff conformsToProtocol:@protocol(DEMUpgradableProtocol)]) {
//			//				[self upgrade:(id<DEMExchangeStuffProtocol, DEMUpgradableProtocol>)stuff];
//			//			}
//			
//		} break;
//	}
//}
//
//- (void)processExchangableItem:(id<DEMEntityExchangableProtocol>)stuff {
//
//}
//
//- (void)processExchangeItem:(id<DEMEntity>)stuff {
//
//}
//
//
//
//- (void)buy:(id<DEMExchangeStuffProtocol>)stuff {
//
//	if ([self.buyer canPurchaseStuff:stuff]) {
//		[self.buyer purchaseStuff:stuff withCompletionBlock:^(BOOL didPurchase) {
//			if (didPurchase) {
//				NSLog(@"%@ purchased stuff item: %@", self.buyer, stuff);
//			}
//			else {
//				NSLog(@"%@ didn't purchase stuff item: %@", self.buyer, stuff);
//				NSError *error = [NSError errorWithDomain:@"com.demo1.demo1" code:0 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Бро, у тебя уже есть гравицапа!", @"")}];
//				[self.didFailPurchaseSubject sendNext:error];
//			}
//		}];
//	}
//	else {
//		NSError *error = [NSError errorWithDomain:@"com.demo1.demo1" code:0 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Сорян, нет бабок", @"")}];
//		[self.didFailPurchaseSubject sendNext:error];
//	}
//
//}
//
//- (void)upgrade:(id<DEMExchangeStuffProtocol, DEMUpgradableProtocol>)stuff {
//
//	// Если
//
//	if ([self.buyer canPurchaseStuff:stuff]) {
//		[self.buyer purchaseStuff:stuff withCompletionBlock:^(BOOL didPurchase) {
//			if (didPurchase) {
//				NSLog(@"%@ purchased stuff item: %@", self.buyer, stuff);
//			}
//			else {
//				NSLog(@"%@ didn't purchase stuff item: %@", self.buyer, stuff);
//				NSError *error = [NSError errorWithDomain:@"com.demo1.demo1" code:0 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Бро, у тебя уже есть гравицапа!", @"")}];
//				[self.didFailPurchaseSubject sendNext:error];
//			}
//		}];
//	}
//	else {
//		NSError *error = [NSError errorWithDomain:@"com.demo1.demo1" code:0 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Сорян, нет бабок", @"")}];
//		[self.didFailPurchaseSubject sendNext:error];
//	}
//}
//
//- (NSArray<id<DEMExchangeStuffProtocol>> *)stuffItems {
//
//	NSArray<id<DEMExchangeStuffProtocol>> *stuffItems = nil;
//
//	switch (self.mode) {
//		case DEMStoreModeBuy: {
//			stuffItems = self.store.stuffItems;
//		} break;
//
//		case DEMStoreModeUpgrade: {
//			stuffItems = self.buyer.stuffItems;
//		} break;
//	}
//
//	return stuffItems;
//}

@end
