#import "DEMMotherShipVM.h"

@interface DEMMotherShipVM ()

@property (nonatomic, strong) DEMEnergyCellModel *currentEnergyCell;
@property (nonatomic, strong, readonly) DEMGravizzappa *gravizzappa;

@property (nonatomic, strong, readonly) RACSubject* energyStateSubject;

@end

@implementation DEMMotherShipVM

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

	}
	return self;
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
		[self.energyStateSubject sendNext:@(DEMMotherShipEnegyStateEmpty)];
	}
	else {
		_currentEnergyLevel = currentEnergyLevel;
	}
}

- (void)storeWarehouseItem:(id<DEMWarehouseItem>)item {
	[_warehouse storeItem:item];
}

- (void)installGravizzappa:(DEMGravizzappa *)gravizzappa {
	_gravizzappa = gravizzappa;
	NSLog(@"Gravizzappa has been installed!");
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
	self.currentEnergyLevel += _gravizzappa.energyPerSecond * duration;
}

@end
