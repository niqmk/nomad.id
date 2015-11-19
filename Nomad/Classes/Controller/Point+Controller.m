#import "Point+Controller.h"
#import "Web+Controller.h"
#import "Point+Buy+View.h"
#import "Point+Free+View.h"
#import "URL+Manager.h"
typedef NS_ENUM(NSInteger, Alert_Status) {
    ExpiredAlertStatusCode
};
typedef NS_ENUM(NSInteger, Point_Type) {
    NonePointType,
    WebPointType,
    WebClosePointType
};
@interface Point_Controller() <Point_Buy_View_Delegate, Alert_Delegate>
@end
@implementation Point_Controller {
@private
    Web_Controller *web_controller;
    Point_Buy_View *point_buy_view;
    Point_Free_View *point_free_view;
    Paid_Point_Model *paid_point_data;
    Global_Variables *gb_variables;
    Alert_Status alert_status;
    Point_Type point_type;
    bool init;
    bool fd;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           FromDetail:(bool)from_detail {
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        gb_variables = [Global_Variables instance];
        fd = from_detail;
    }
    return self;
}
- (void)didPointBuyViewSelected:(Paid_Point_Model *)paid_point_model {
    [self setBuyRequest:paid_point_model.id];
}
- (void)didAlertActioned:(NSInteger)index {
    switch (alert_status) {
        case ExpiredAlertStatusCode:
            [App_Controller clearSession];
            break;
        default:
            break;
    }
}
- (void)didAlertCancelled {}
- (void)viewDidLoad {
    [super viewDidLoad];
    init = true;
    [self setInitial];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(init) {
        init = false;
        [self setLayout];
    }
    if(point_type == WebPointType) {
        point_type = NonePointType;
        [App_Controller refreshMe];
        if(fd) {
            [self doBack:self];
        }
    }
}
- (IBAction)doBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)doBuy:(id)sender {
    [self scrollTo:0];
}
- (IBAction)doFree:(id)sender {
    [self scrollTo:1];
}
- (void)setInitial {
    [Global_Controller setDefaultBacgroundWithLogo:self.navigationController];
    [Global_Controller setImageLeftButton:self ImageNamed:@"Icon-Menu-Back" Title:text_blank Action:@selector(doBack:)];
    [self.btn_buy rounded];
    [self.btn_buy stroke];
    [self.btn_free rounded];
    [self.btn_free stroke];
}
- (void)setLayout {
    point_buy_view = [[Point_Buy_View alloc] init];
    point_buy_view.delegate = self;
    point_free_view = [[Point_Free_View alloc] init];
    point_free_view.frame = self.scv_main.bounds;
    point_free_view.frame = CGRectMake(self.scv_main.frame.size.width, 0, self.scv_main.frame.size.width, self.scv_main.frame.size.height);
    [self.scv_main addSubview:point_buy_view];
    [self.scv_main addSubview:point_free_view];
    self.scv_main.contentSize = CGSizeMake(self.scv_main.frame.size.width * 2, 0);
    [point_buy_view show];
    [point_free_view show];
}
- (void)setBuyRequest:(long)id {
    [App_Controller showLoading:self];
    [URL_Manager PaidPointBuy:id
    Complete:^(NSDictionary *response) {
        [App_Controller closeLoading];
        if([response objectForKey:@"url"] != nil) {
            [self showURL:[response objectForKey:@"url"]];
        }
    } Failed:^(NSString *message) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:message
                         Delegate:nil];
    } Expired:^{
        alert_status = ExpiredAlertStatusCode;
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_user_expired"]
                         Delegate:self];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_request_failed"]
                         Delegate:nil];
    }];
}
- (void)showURL:(NSString *)url {
    point_type = WebPointType;
    web_controller = [[Web_Controller alloc] initWithNibName:@"Web+Controller"
                                                      bundle:nil
                                                         URL:url];
    [self pushDetail:web_controller];
}
- (void)scrollTo:(NSInteger)index {
    if(index == 0) {
        [self.scv_main setContentOffset:CGPointZero animated:YES];
    }else {
        [self.scv_main setContentOffset:CGPointMake(self.scv_main.frame.size.width * index, 0) animated:YES];
    }
}
- (void)pushDetail:(UIViewController *)view_controller {
    [self.navigationController pushViewController:view_controller animated:true];
}
@end