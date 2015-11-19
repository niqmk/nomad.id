@interface Web_Controller : UIViewController <UIWebViewDelegate>
@property (nonatomic, strong) IBOutlet UIWebView *web_view;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                  URL:(NSString *)url;
@end