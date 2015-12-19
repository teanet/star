#import <UIKit/UIKit.h>
#import "DEMStuffProtocol.h"

@interface DEMStoreItemCell : UITableViewCell

@property (nonatomic, strong) NSObject<DEMStuffProtocol> *item;

@end
