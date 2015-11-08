#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	if (NSClassFromString(@"XCTestCase")) return YES;

	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UIViewController *vc = [storyboard instantiateInitialViewController];
	self.window.rootViewController = vc;
	[self.window makeKeyAndVisible];

	return YES;
}

@end
