#import "Alert+Controller.h"
@implementation Alert_Controller
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(self.alert_delegate != nil) {
        [self.alert_delegate didAlertCancelled];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(self.alert_delegate != nil) {
        [self.alert_delegate didAlertActioned:buttonIndex];
    }
}
- (void)showAlert:(NSString *)title
          Message:(NSString *)message
         Delegate:(id<Alert_Delegate>)delegate {
    self.alert_delegate = delegate;
    alert_view = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert_view show];
}
- (void)showQuestion:(NSString *)title
             Message:(NSString *)message
            Delegate:(id<Alert_Delegate>)delegate {
    self.alert_delegate = delegate;
    alert_view = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
    [alert_view show];
}
- (BOOL)isClosed {
    if(alert_view == nil) {
        return true;
    }
    return [alert_view isVisible];
}
- (void)close {
    if(alert_view == nil) {
        return;
    }
    [alert_view dismissWithClickedButtonIndex:0 animated:YES];
}
@end