#import "Loading+Controller.h"
#import <MBProgressHUD/MBProgressHUD.h>
@implementation Loading_Controller {
@private
    MBProgressHUD *hud;
    UITapGestureRecognizer *tap;
    bool cancel;
}
- (void)show:(UIViewController *)view_controller
     Message:(NSString *)message
  Cancelable:(bool)cancelable {
    cancel = cancelable;
    hud = [MBProgressHUD showHUDAddedTo:view_controller.view animated:NO];
    hud.labelText = [App_Controller getTitle:@"title_app"];
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [hud addGestureRecognizer:tap];
    [hud show:YES];
}
- (void)close {
    if(hud != nil) {
        [hud removeGestureRecognizer:tap];
        [hud hide:NO];
        hud = nil;
    }
}
- (bool)isClosed {
    if(hud != nil) {
        return false;
    }
    return true;
}
- (void)tap {
    if(cancel) {
        [self close];
    }
}
- (void)task {}
@end