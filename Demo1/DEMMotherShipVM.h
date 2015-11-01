//
//  DEMMotherShipVM.h
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DEMEnergyCellModel.h"
#import "DEMWarehouseVM.h"

@interface DEMMotherShipVM : NSObject

@property (nonatomic, assign) double currentEnergyLevel;
@property (nonatomic, assign) double extraEnergyLevel;

@property (nonatomic, strong, readonly) DEMWarehouseVM *warehouse;
@property (nonatomic, assign, readonly) double maxEnergyLevel;

@end
