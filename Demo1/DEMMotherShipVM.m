//
//  DEMMotherShipVM.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "DEMMotherShipVM.h"


@interface DEMMotherShipVM ()

@property (nonatomic, strong) DEMEnergyCellModel *currentEnergyCell;

@end

@implementation DEMMotherShipVM

- (instancetype)init {
	self = [super init];
	if (self) {
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
	else {
		_currentEnergyLevel = currentEnergyLevel;
	}
}

- (void)storeWarehouseItem:(id<DEMWarehouseItem>)item {
	[_warehouse storeItem:item];
}

@end
