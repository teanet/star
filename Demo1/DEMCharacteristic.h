#import "DEMCharacteristicTypes.h"

@interface DEMCharacteristic : NSObject

@property (nonatomic, assign, readonly) double value;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *type;

+ (instancetype)withValue:(double)value;
- (instancetype)initWithValue:(double)value;

@end
