@interface DEMResources : NSObject

// TODO: сделать конструктор с nsdictionary с кейпасами сделать все проперти ридонлевыми
@property (nonatomic, assign) double credits;

- (void)plus:(DEMResources *)resources;
- (void)minus:(DEMResources *)resources;

@end

@protocol DEMResources <NSObject>

@property (nonatomic, strong, readonly) DEMResources *resources;

@end
