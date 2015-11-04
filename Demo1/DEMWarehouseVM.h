//
//  DEMWarehouseVM.h
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//


#import "DEMWarehouseItem.h"

@interface DEMWarehouseVM : NSObject

@property (nonatomic, assign, readonly) int32_t capacity;
@property (nonatomic, strong, readonly) NSSet<id<DEMWarehouseItem>> *items;

- (void)storeItem:(NSObject<DEMWarehouseItem> *)item;
- (BOOL)hasEnegry:(double)enegry;

@end
