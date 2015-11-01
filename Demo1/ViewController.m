//
//  ViewController.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "ViewController.h"
#import "DEMBaseVC.h"
#import "DEMMotherShipVM.h"

@interface ViewController ()

@property (nonatomic, strong) DEMMotherShipVM *motherShipVM;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self == nil) return nil;
	_motherShipVM = [DEMMotherShipVM new];
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

}

- (IBAction)showBase:(id)sender {

	DEMBaseVC *baseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"baseVC"];
	baseVC.motherShipVM = self.motherShipVM;
	[self.navigationController pushViewController:baseVC animated:YES];
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
