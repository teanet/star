//
//  ViewController.m
//  Demo1
//
//  Created by tea on 01/11/15.
//  Copyright © 2015 demo. All rights reserved.
//

#import "ViewController.h"
#import "DEMBaseVC.h"
#import "DEMGameVM.h"
#import "DEMStoreVC.h"

@interface ViewController ()

@property (nonatomic, strong) DEMGameVM *gameVM;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self == nil) return nil;
	_gameVM = [DEMGameVM new];
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

}

- (IBAction)showBase:(id)sender {

	DEMBaseVC *baseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"baseVC"];
	baseVC.motherShipVM = self.gameVM.motherShipVM;
	[self.navigationController pushViewController:baseVC animated:YES];
	
}

- (IBAction)showStore:(id)sender {
	DEMStoreVC *storeVC = [[DEMStoreVC alloc] initWithStoreVM:self.gameVM.storeVM];
	[self.navigationController pushViewController:storeVC animated:YES];
}

@end
