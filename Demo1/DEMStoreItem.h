//
//  DEMStoreItem.h
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DEMStoreItem <NSObject>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) double price;

@end
