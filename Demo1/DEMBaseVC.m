//
//  DEMBaseVC.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "DEMBaseVC.h"
#import "DEMMotherShipVM.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DEMBaseVC ()

@property (weak, nonatomic) IBOutlet UILabel *energyLabel;

@end

@implementation DEMBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

	RAC(self.energyLabel, text) =
		[RACObserve(self.motherShipVM, energyLevel)
			map:^id(NSNumber *value) {
				return [NSString stringWithFormat:@"Energy: %@", value];
			}];
}

- (IBAction)addEnergy:(id)sender {
	self.motherShipVM.energyLevel++;
}

@end
