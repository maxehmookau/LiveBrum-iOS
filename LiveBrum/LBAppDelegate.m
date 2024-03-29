#import "LBAppDelegate.h"
#import "LBTodayViewController.h"
#import "LBGenresSelectViewController.h"
#import "LBSearchViewController.h"

@implementation LBAppDelegate

@synthesize window = _window;
@synthesize locationManager = _locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    LBTodayViewController *todayVC = [[LBTodayViewController alloc] init];
    UINavigationController *todayNC = [[UINavigationController alloc] initWithRootViewController:todayVC];
    
    LBGenresSelectViewController *genresVC = [[LBGenresSelectViewController alloc] init];
    UINavigationController *genresNC = [[UINavigationController alloc] initWithRootViewController:genresVC];
    
    LBSearchViewController *searchVC = [[LBSearchViewController alloc] init];
    UINavigationController *searchNC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    
    todayNC.tabBarItem = [[UITabBarItem alloc]
                                     initWithTitle:@"Today"
                                     image:[UIImage imageNamed:@"65-note.png"]
                                     tag:0];
    
    searchNC.tabBarItem = [[UITabBarItem alloc]
                          initWithTitle:@"Search"
                          image:[UIImage imageNamed:@"06-magnify.png"]
                          tag:0];
    
    [tabBarController setViewControllers:[NSArray arrayWithObjects:todayNC, genresNC, searchNC, nil]];
    
    if([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setPurpose:@"LiveBrum would like to know your location so we can find events close to you."];
        [locationManager startUpdatingLocation];
    }
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
