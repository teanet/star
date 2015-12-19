#import "DEMMotherShipVM.h"

#import "DEMEnergyCellModel.h"
#import "DEMGravizzappa.h"
#import "DEMActionExchangeResourcesProtocol.h"

@interface DEMMotherShipVM ()
<DEMActionExchangeResourcesProtocol>

@property (nonatomic, strong) DEMEnergyCellModel *currentEnergyCell;
@property (nonatomic, strong, readonly) DEMGravizzappa *gravizzappa;
@property (nonatomic, strong, readonly) NSMutableArray *mutableInstalledItems;
@property (nonatomic, strong, readonly) RACSubject *energyStateSubject;
@property (nonatomic, strong, readonly) NSMutableDictionary<DEMUUID *, DEMBaseItem *> *allItems;

@end

@implementation DEMMotherShipVM

@synthesize battleActionSignal = _energyStateSignal;
@synthesize didChangeMoneySignal = _didChangeMoneySignal;
//@dynamic exchangableItems;

- (void)dealloc {
	[self.energyStateSubject sendCompleted];
}

- (instancetype)init {
	self = [super init];
	if (self) {

		_energyStateSubject = [RACSubject subject];
		_energyStateSignal = _energyStateSubject;

		_warehouse = [DEMWarehouseVM new];
		_currentEnergyCell = [self newEnergyCellWithEnergy:0.0];
		_maxEnergyLevel = 100.0;

		_mutableInstalledItems = [NSMutableArray array];
		_allItems = [NSMutableDictionary dictionary];
#warning TEST PURPOSE ONLY
		DEMGravizzappa *g = [[DEMGravizzappa alloc] init];
		[_allItems setObject:g forKey:g.uuid];

	}
	return self;
}

- (NSArray *)installedItems {
	return [_mutableInstalledItems copy];
}

- (NSArray<NSObject<DEMEntityExchangableProtocol> *> *)exchangableItems {
	// TODO: добавить поддержку итемов которые мы можем поменять
	return @[];
}

- (DEMEnergyCellModel *)newEnergyCellWithEnergy:(double)energy {
	return [[DEMEnergyCellModel alloc] initWithEnergy:energy];
}

- (void)setCurrentEnergyLevel:(double)currentEnergyLevel {
	if (currentEnergyLevel > self.maxEnergyLevel) {
		double freeEnergy = currentEnergyLevel - self.maxEnergyLevel;
		[self.currentEnergyCell addEnergy:freeEnergy];
		self.extraEnergyLevel = self.currentEnergyCell.currentEnergy;

		if (self.currentEnergyCell.isFull) {
			DEMEnergyCellModel *storeCell = self.currentEnergyCell;
			self.currentEnergyCell = [self newEnergyCellWithEnergy:0.0];
			[self storeWarehouseItem:storeCell];
		}
	}
	else if (currentEnergyLevel < 0.0) {
		_currentEnergyLevel = 0.0;
		[self.energyStateSubject sendNext:@(DEMBattleActionDie)];
	}
	else {
		_currentEnergyLevel = currentEnergyLevel;
	}
}

- (void)storeWarehouseItem:(id<DEMWarehouseItem>)item {
	[self.warehouse storeItem:item];
}

- (BOOL)installStuff:(DEMBaseItem *)stuff {
	BOOL didInstallStuff = NO;

	if ([stuff isKindOfClass:[DEMGravizzappa class]]) {
		if (![stuff isEqual:_gravizzappa]) {
			_gravizzappa = [(DEMGravizzappa *)stuff copy];
			NSLog(@"Gravizzappa has been installed!");
			didInstallStuff = YES;
		}
	}

	if (didInstallStuff) {
		[self.mutableInstalledItems addObject:stuff];
		self.allItems[stuff.uuid] = stuff;
	}

	return didInstallStuff;
}

#pragma mark DEMBattleProtocol

- (double)dps {
	return 0.0;
}

- (void)receiveDamage:(double)damage
{
	NSLog(@"Mothership receive damage: %f", damage);
	self.currentEnergyLevel -= damage;
}

#pragma mark DEMClockEngineProtocol

- (void)tick:(NSTimeInterval)duration {
	self.currentEnergyLevel += self.gravizzappa.energyPerSecond * duration;
}

#pragma mark DEMExchangeProtocol

- (BOOL)canPurchaseStuff:(id<DEMEntityExchangableProtocol>)stuff {
	return NO;
#warning 123
//	return (self.availableResources >= stuff.price);
}

- (void)purchaseStuff:(id<DEMEntityExchangableProtocol>)stuff withCompletionBlock:(void (^)(BOOL))block {
	NSCParameterAssert(block);

	if (!block) return;

	if (![self canPurchaseStuff:stuff]) {
		block(NO);
	}
	else {
		block([self installStuff:stuff]);
	}
}

#pragma mark DEMActionUpgradeProtocol <NSObject>

- (BOOL)canUpgradeEntity:(id)entity {
	return NO;
}

- (void)upgradeEntity:(id<DEMEntityUpgradableProtocol>)entity withCompletionBlock:(void (^)(BOOL))block {

}

#pragma mark DEMVisitorProtocol

- (NSArray<DEMUUID *> *)allUUIDs {
	return self.allItems.allKeys;
}

- (DEMBaseItem *)itemWithUUID:(DEMUUID *)uuid {
	NSCParameterAssert(uuid);
	if (uuid == nil) return nil;

	return self.allItems[uuid];
}

- (void)setItem:(DEMBaseItem *)item forUUID:(DEMUUID *)uuid {
#warning TODO: make it
}

// MARK: DEMActionExchangeResourcesProtocol

- (DEMResources *)availableResources {
	return self.warehouse.availableResources;
}

- (void)addResources:(DEMResources *)resources {
	
}

- (void)withdrawResources:(DEMResources *)resources {

}

@end
