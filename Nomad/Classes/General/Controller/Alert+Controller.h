@protocol Alert_Delegate <NSObject>
@required
- (void)didAlertCancelled;
- (void)didAlertActioned:(NSInteger)index;
@end
@interface Alert_Controller : NSObject <UIAlertViewDelegate> {
@private
    UIAlertView *alert_view;
}
@property (nonatomic, assign) id<Alert_Delegate> alert_delegate;
- (void)showAlert:(NSString *)title
          Message:(NSString *)message
         Delegate:(id<Alert_Delegate>)delegate;
- (void)showQuestion:(NSString *)title
             Message:(NSString *)message
            Delegate:(id<Alert_Delegate>)delegate;
- (BOOL)isClosed;
- (void)close;
@end