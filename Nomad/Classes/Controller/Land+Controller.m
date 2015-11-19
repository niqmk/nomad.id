#import "Land+Controller.h"
@implementation Land_Controller {
@private
    bool login_direct;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
            ShowLogin:(bool)login {
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        login_direct = login;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitial];
    if(login_direct) {
        [App_Controller openCredential:self];
    }
}
- (IBAction)doWatch:(id)sender {
    [App_Controller openHomeController];
}
- (IBAction)doLogin:(id)sender {
    [App_Controller openCredential:self];
}
- (void)setInitial {}
@end