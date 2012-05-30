#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LBAppDelegate : UIResponder <UIApplicationDelegate>
{
    CLLocationManager *locationManager;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) CLLocationManager *locationManager;
@end
