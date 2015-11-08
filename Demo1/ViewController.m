#import "ViewController.h"
#import "DEMBaseVC.h"
#import "DEMGameVM.h"
#import "DEMStoreVC.h"

@interface ViewController ()

@property (nonatomic, strong) DEMGameVM *gameVM;
@property (nonatomic, strong) UIProgressView *progressView;

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
	self.navigationController.navigationBar.translucent = NO;

	self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
	self.progressView.trackTintColor = [UIColor lightGrayColor];
	[self.view addSubview:self.progressView];
	[self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(self.view).with.offset(20.0);
		make.top.equalTo(self.view).with.offset(20.0);
		make.width.equalTo(self.view).with.dividedBy(2.0);
	}];

	RAC(self.progressView, progress) =
		[RACObserve(self.gameVM.gameCore, progressVM.progress)
			ignore:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.gameVM.gameCore start];
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
