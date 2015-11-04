//
//  DEMEnergyCellModel.h
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//


#import "DEMWarehouseItem.h"

@interface DEMEnergyCellModel : NSObject
<DEMWarehouseItem>

@property (nonatomic, assign, readonly, getter=isFull) double full;
@property (nonatomic, assign, readonly) double currentEnergy;

- (instancetype)initWithEnergy:(double)energy NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)addEnergy:(double)energy;

@end

