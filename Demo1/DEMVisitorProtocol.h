#import "DEMBaseItem.h"

@protocol DEMVisitorProtocol <NSObject>

- (NSArray<DEMUUID *> *)allUUIDs;
- (DEMBaseItem *)itemWithUUID:(DEMUUID *)uuid;
- (void)setItem:(DEMBaseItem *)item forUUID:(DEMUUID *)uuid;

@end
