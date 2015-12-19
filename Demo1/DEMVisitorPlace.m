#import "DEMVisitorPlace.h"

@implementation DEMVisitorPlace

@synthesize visitor = _visitor;
@dynamic items;
@dynamic title;

- (instancetype)initWithVisitor:(id<DEMVisitorProtocol>)visitor {
	self = [super init];
	if (self == nil) return nil;

	_visitor = visitor;

	return self;
}

- (NSString *)title {
	NSCAssert(NO, @"should be implemented in child class");
	return @"";
}

- (BOOL)canProcessVisitor {
	NSCAssert(NO, @"implement this method in subclass");
	return NO;
}

- (void)processItemAtIndex:(NSInteger)index {
	NSCAssert(NO, @"implement this method in subclass");
}

@end
