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
@property (weak, nonatomic) IBOutlet UILabel *energyCellLabel;

@end

@implementation DEMBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

	RAC(self.energyLabel, text) =
		[RACObserve(self.motherShipVM, currentEnergyLevel)
			map:^id(NSNumber *value) {
				return [NSString stringWithFormat:@"Energy: %@", value];
			}];
	RAC(self.energyCellLabel, text) =
		[RACObserve(self.motherShipVM, extraEnergyLevel)
			map:^id(NSNumber *value) {
				return [NSString stringWithFormat:@"Extra energy: %@", value];
			}];
}

- (IBAction)addEnergy:(id)sender {
	self.motherShipVM.currentEnergyLevel += 50.0;
}

@end
