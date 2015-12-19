#import "DEMStoreVC.h"
#import "DEMStoreVM.h"
#import "DEMStoreItemCell.h"
#import "DEMStoreVM.h"

@interface DEMStoreVC ()

@property (nonatomic, strong, readonly) DEMStoreVM *storeVM;


@end

@implementation DEMStoreVC

- (instancetype)initWithStoreVM:(DEMStoreVM *)storeVM 
{
	self = [super init];
	if (self == nil) return nil;

	_storeVM = storeVM;

	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:self.storeVM.placeTitles];
	[sc addTarget:self action:@selector(switch:) forControlEvents:UIControlEventValueChanged];
	sc.selectedSegmentIndex = self.storeVM.selectedPlaceIndex;
	self.navigationItem.titleView = sc;

	[self.tableView registerClass:[DEMStoreItemCell class] forCellReuseIdentifier:@"DEMStoreItemCell"];

	[self.storeVM.didFailProcessSignal subscribeNext:^(NSError *error) {
		[[[UIAlertView alloc] initWithTitle:@"Not enogh founds" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
	}];
}

- (void)switch:(UISegmentedControl *)sc {
	[self.storeVM selectPlaceWithIndex:sc.selectedSegmentIndex];
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storeVM.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DEMStoreItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DEMStoreItemCell"];
	NSObject<DEMStuffProtocol> *item = self.storeVM.items[indexPath.row];
	cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	[self.storeVM processItemAtIndex:indexPath.row];
}

@end
