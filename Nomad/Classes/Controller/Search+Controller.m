#import "Search+Controller.h"
#import "Home+Controller.h"
#import "Home+Menu+Controller.h"
#import "URL+Manager.h"
@interface Search_Controller() <UITextFieldDelegate>
@end
@implementation Search_Controller {
@private
    UITapGestureRecognizer *tap_recognizer;
    Search_Model *search_data;
    NSString *search_value;
    bool init;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
               Search:(NSString *)search {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {
        search_value = search;
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [search_data.search_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *search_list_id = @"SearchListID";
    Search_Cell *cell = (Search_Cell *)[tableView dequeueReusableCellWithIdentifier:search_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Search+Cell" owner:self options:nil];
        cell = self.search_cell;
    }
    Search_Model *search_model = [search_data.search_list objectAtIndex:row];
    [cell set:search_model];
    [Global_Controller setSelectedCell:cell Color:[UIColor redColor]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self setSelected:row];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txt_search isFirstResponder]) {
        [self doSearch:self];
        return NO;
    }
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    init = true;
    [Global_Controller removeAllViews:self.navigationController];
    [Global_Controller setImageLeftButton:self ImageNamed:@"Icon-Menu-Back" Title:text_blank Action:@selector(doBack:)];
    [Global_Controller setImageRightButton:self ImageNamed:@"Icon-Search" Title:text_blank Action:@selector(doSearch:)];
    tap_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    [self setMessage:false];
    [self setSearchLayout];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [App_Controller addKeyboardListen:self
                       onKeyboardShow:@selector(keyboardWillShow:)
                       onKeyboardHide:@selector(keyboardWillHide:)];
    if(init) {
        init = false;
        [self setInitial];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [App_Controller removeKeyboardListen:self];
}
- (IBAction)doBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)doSearch:(id)sender {
    [self closeFocus];
    search_value = self.txt_search.text;
    if(![Global_Controller isNotNull:search_value]) {
        return;
    }
    [self request];
}
- (void)setInitial {
    [self request];
}
- (void)keyboardWillShow:(NSNotification *)note {
    [self.view addGestureRecognizer:tap_recognizer];
}
- (void)keyboardWillHide:(NSNotification *)note {
    [self.view removeGestureRecognizer:tap_recognizer];
}
- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer {
    [self closeFocus];
}
- (void)request {
    [self setMessage:false];
    [self setLoading:true];
    [URL_Manager Search:search_value
    Complete:^(Search_Model *search_model) {
        [self setLoading:false];
        search_data = search_model;
        [self.lst_result reloadData];
    } Failed:^(NSString *message) {
        [self.lbl_message setText:message];
        [self setLoading:false];
        [self setMessage:true];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [self.lbl_message setText:[App_Controller getError:@"error_request_failed"]];
        [self setLoading:false];
        [self setMessage:true];
    }];
}
- (void)setSearchLayout {
    self.txt_search = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 24)];
    self.txt_search.delegate = self;
    self.txt_search.placeholder = @"Pencarian";
    self.txt_search.text = search_value;
    self.txt_search.returnKeyType = UIReturnKeySearch;
    self.txt_search.font = [UIFont boldSystemFontOfSize:18];
    self.txt_search.textColor = [UIColor blackColor];
    self.txt_search.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *img_search = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-Search"]];
    img_search.frame = CGRectMake(0, 0, 24, 24);
    [self.txt_search setBackground:[UIImage imageNamed:@"Icon-Select"]];
    self.txt_search.leftView = img_search;
    self.navigationItem.titleView = self.txt_search;
}
- (void)setSelected:(NSInteger)index {
    Search_Model *search_model = [search_data.search_list objectAtIndex:index];
    UIViewController *view_controller = (UIViewController *)[self.navigationController.viewControllers objectAtIndex:0];
    if([view_controller isKindOfClass:[Home_Controller class]]) {
        [((Home_Controller *)view_controller) pushDetail:search_model];
    }else if([view_controller isKindOfClass:[Home_Menu_Controller class]]) {
        [((Home_Menu_Controller *)view_controller) pushDetail:search_model];
    }
}
- (void)closeFocus {
    if([self.txt_search isFirstResponder]) {
        [self.txt_search resignFirstResponder];
    }
}
- (void)setMessage:(bool)show {
    [self.vw_message setHidden:!show];
}
- (void)setLoading:(bool)show {
    [self.vw_loading setHidden:!show];
}
@end