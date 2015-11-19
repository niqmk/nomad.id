#import "Nav+Controller.h"
#import <MMDrawerController/MMDrawerController.h>
#import "Home+Controller.h"
#import "Detail+Controller.h"
@implementation Nav_Controller {
@private
    Home_Controller *home_controller;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitial];
}
- (void)openMenu {
    MMDrawerController *drawer_controller = (MMDrawerController *)self.parentViewController;
    [drawer_controller openDrawerSide:MMDrawerSideLeft animated:true completion:nil];
}
- (void)openDefaultRoot {
    if(home_controller == nil) {
        home_controller = [[Home_Controller alloc] initWithNibName:@"Home+Controller" bundle:nil];
    }
    [self setViewControllers:@[home_controller]];
}
- (void)openAsRoot:(UIViewController *)view_controller {
    if(self.viewControllers > 0) {
        [self popToRootViewControllerAnimated:false];
        [self setViewControllers:@[view_controller]];
    }
}
- (void)reload {
    if(self.viewControllers > 0) {
        UIViewController *view_controller = [self.viewControllers objectAtIndex:[self.viewControllers count] - 1];
        if([view_controller isKindOfClass:[Detail_Controller class]]) {
            [((Detail_Controller *)view_controller) reload];
        }
    }
}
- (BOOL)isAutorotate {
    if(self.viewControllers > 0) {
        UIViewController *view_controller = [self.viewControllers objectAtIndex:[self.viewControllers count] - 1];
        if([view_controller isKindOfClass:[Detail_Controller class]]) {
            return [((Detail_Controller *)view_controller) isAutorotate];
        }
    }
    return NO;
}
- (void)setInitial {
    home_controller = [[Home_Controller alloc] initWithNibName:@"Home+Controller" bundle:nil];
    [self setViewControllers:@[home_controller]];
    [home_controller.view setFrame:[self.view bounds]];
}
@end