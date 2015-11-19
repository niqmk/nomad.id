#import "CustomMMDrawerController.h"
#import "Nav+Controller.h"
@implementation CustomMMDrawerController
- (BOOL)shouldAutorotate {
    Nav_Controller *nav_controller = (Nav_Controller *)self.centerViewController;
    return [nav_controller isAutorotate];
}
@end