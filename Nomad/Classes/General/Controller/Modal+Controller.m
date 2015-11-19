#import "Modal+Controller.h"
#import "RNBlurModalView.h"
@implementation Modal_Controller
static RNBlurModalView *modal;
+ (void)show:(UIViewController *)view_controller
        View:(UIView *)view {
    modal = [[RNBlurModalView alloc] initWithViewController:view_controller view:view];
    [modal hideCloseButton:true];
    [modal show];
}
+ (void)close {
    if(modal == nil) {
        return;
    }
    [modal hide];
    modal = nil;
}
@end
