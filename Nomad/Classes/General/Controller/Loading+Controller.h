@interface Loading_Controller : NSObject
- (void)show:(UIViewController *)view_controller
     Message:(NSString *)message
  Cancelable:(bool)cancelable;
- (void)close;
- (bool)isClosed;
@end