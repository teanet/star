//
//  DEMGameVM.h
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DEMMotherShipVM.h"
#import "DEMStoreVM.h"

@interface DEMGameVM : NSObject

@property (nonatomic, strong, readonly) DEMMotherShipVM *motherShipVM;
@property (nonatomic, strong, readonly) DEMStoreVM *storeVM;

@end
