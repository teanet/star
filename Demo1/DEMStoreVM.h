//
//  DEMStoreVM.h
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DEMStoreItem.h"
@class DEMMotherShipVM;

@interface DEMStoreVM : NSObject

@property (nonatomic, strong) NSArray<NSObject<DEMStoreItem> *> *items;

- (instancetype)initWithMotherShipVM:(DEMMotherShipVM *)motherShipVM;
- (BOOL)canPurchaseItem:(NSObject<DEMStoreItem> *)storeItem;
- (void)installItem:(NSObject<DEMStoreItem> *)storeItem;

@end
