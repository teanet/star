#import "DEMUUID.h"

@implementation DEMUUID

+ (instancetype)uuid
{
	return (DEMUUID *)[NSUUID UUID].UUIDString;
}

@end
