#import "Web+Controller.h"
@interface Web_Controller() <Alert_Delegate>
@end
@implementation Web_Controller {
@private
    NSString *web_url;
    bool init;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                  URL:(NSString *)url {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {
        web_url = url;
    }
    return self;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {}
- (void)webViewDidFinishLoad:(UIWebView *)webView {}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                      Message:[error localizedDescription]
                     Delegate:nil];
}
- (void)didAlertActioned:(NSInteger)index {}
- (void)didAlertCancelled {}
- (void)viewDidLoad {
    [super viewDidLoad];
    init = true;
    [Global_Controller setImageLeftButton:self ImageNamed:@"Icon-Menu-Back" Title:text_blank Action:@selector(doBack:)];
    [Global_Controller setDefaultBacgroundWithLogo:self.navigationController];
    [self setInitial];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(init) {
        init = false;
    }
}
- (IBAction)doBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (void)setInitial {
    NSURL *url = [NSURL URLWithString:web_url];
    NSURLRequest *url_request = [NSURLRequest requestWithURL:url];
    [self.web_view loadRequest:url_request];
}
@end