//
//  DEMWarehouseItem.h
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//



@protocol DEMWarehouseItem <NSObject>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) double capacity;

@end
