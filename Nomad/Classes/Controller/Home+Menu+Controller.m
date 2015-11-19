#import "Home+Menu+Controller.h"
#import "Nav+Controller.h"
#import "Detail+Controller.h"
#import "Search+Controller.h"
@interface Home_Menu_Controller() <UITextFieldDelegate>
@end
@implementation Home_Menu_Controller {
@private
    Detail_Controller *detail_controller;
    Search_Controller *search_controller;
    UITapGestureRecognizer *tap_recognizer;
    NSMutableDictionary *menu_view_list;
    NSMutableArray *menu_list;
    NSMutableDictionary *view_list;
    VideoType video_type;
    long category_id;
    bool init;
    bool menu_selected;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
            VideoType:(VideoType)type
                   ID:(long)id {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {
        video_type = type;
        category_id = id;
    }
    return self;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat page_width = self.scv_main.frame.size.width;
    int page = floor((self.scv_main.contentOffset.x - page_width / 2 ) / page_width) + 1;
    NSString *key = [menu_list objectAtIndex:page];
    if(!menu_selected) {
        [self setMenuSelected:key];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    menu_selected = false;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txt_search isFirstResponder]) {
        [self doActionSearch:self];
        return NO;
    }
    return YES;
}
- (void)didMenuViewSelected:(NSString *)key {
    [self setMenuSelected:key];
    menu_selected = true;
    [self scrollTo:key];
}
- (void)didHomeMenuViewPotraitSelected:(id)model {
    [self openDetail:model];
}
- (void)didHomeMenuViewLandscapeSelected:(id)model {
    [self openDetail:model];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    init = true;
    [Global_Controller setImageLeftButton:self ImageNamed:@"Icon-Menu" Title:text_blank Action:@selector(doMenu:)];
    [Global_Controller setImageRightButton:self ImageNamed:@"Icon-Search" Title:text_blank Action:@selector(doSearch:)];
    [App_Controller addKeyboardListen:self
                       onKeyboardShow:@selector(keyboardWillShow:)
                       onKeyboardHide:@selector(keyboardWillHide:)];
    tap_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    [self setSearchLayout];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [Global_Controller setDefaultBacgroundWithLogo:self.navigationController];
    if(init) {
        init = false;
        [self setInitial];
    }
}
- (IBAction)doMenu:(id)sender {
    [(Nav_Controller *)self.parentViewController openMenu];
}
- (IBAction)doSearch:(id)sender {
    [Global_Controller removeAllViews:self.navigationController];
    self.navigationItem.titleView = self.txt_search;
    [self.txt_search becomeFirstResponder];
}
- (IBAction)doActionSearch:(id)sender {
    [self closeFocus];
    NSString *search = self.txt_search.text;
    if(![Global_Controller isNotNull:search]) {
        return;
    }
    search_controller = [[Search_Controller alloc] initWithNibName:@"Search+Controller" bundle:nil Search:search];
    [self.navigationController pushViewController:search_controller animated:true];
}
- (void)pushDetail:(id)data {
    [self.navigationController popToRootViewControllerAnimated:false];
    detail_controller = [[Detail_Controller alloc] initWithNibName:@"Detail+Controller"
                                                            bundle:nil
                                                              Data:data];
    [self.navigationController pushViewController:detail_controller animated:YES];
}
- (void)close {
    [App_Controller removeKeyboardListen:self];
}
- (void)setInitial {
    [self setMenuLayout];
    [self setLayout];
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
- (void)setMenuLayout {
    menu_view_list = [[NSMutableDictionary alloc] init];
    menu_list = [App_Controller getHomeMenuList:video_type];
    float max_width = 0;
    NSString *first_key;
    for(NSString *each in menu_list) {
        if(![Global_Controller isNotNull:first_key]) {
            first_key = each;
        }
        Menu_View *menu_view = [[Menu_View alloc] init];
        menu_view.delegate = self;
        [menu_view set:each];
        max_width += menu_view.frame.size.width;
        [menu_view_list setObject:menu_view forKey:each];
    }
    float width = 0;
    if(max_width < self.scv_menu.frame.size.width) {
        width = self.scv_menu.frame.size.width / [menu_list count];
    }
    float x = 0;
    float height = 0;
    for(NSString *each in menu_list) {
        Menu_View *menu_view = [menu_view_list objectForKey:each];
        height = menu_view.frame.size.height;
        if(width == 0) {
            menu_view.frame = CGRectMake(x, 0, menu_view.frame.size.width, menu_view.frame.size.height);
        }else {
            menu_view.frame = CGRectMake(x, 0, width, menu_view.frame.size.height);
        }
        [self.scv_menu addSubview:menu_view];
        x += menu_view.frame.size.width;
    }
    self.scv_menu.contentSize = CGSizeMake(x, height);
    [self setMenuSelected:first_key];
}
- (void)setSearchLayout {
    self.txt_search = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 24)];
    self.txt_search.delegate = self;
    self.txt_search.placeholder = @"Pencarian";
    self.txt_search.returnKeyType = UIReturnKeySearch;
    self.txt_search.font = [UIFont boldSystemFontOfSize:18];
    self.txt_search.textColor = [UIColor blackColor];
    self.txt_search.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *img_search = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-Search"]];
    img_search.frame = CGRectMake(0, 0, 24, 24);
    [self.txt_search setBackground:[UIImage imageNamed:@"Icon-Select"]];
    self.txt_search.leftView = img_search;
}
- (void)setLayout {
    CGSize size = self.scv_main.frame.size;
    float x = 0;
    view_list = [[NSMutableDictionary alloc] init];
    for(NSString *each in menu_list) {
        UIView *layout = [Layout_Menu_Controller getLayout:each
                                                CategoryID:category_id
                                                 VideoType:video_type
                                                     Width:size.width
                                                  Delegate:self];
        layout.frame = CGRectMake(x, 0, size.width, size.height);
        [self.scv_main addSubview:layout];
        if(layout != nil) {
            [view_list setObject:layout forKey:each];
        }
        x += size.width;
    }
    self.scv_main.contentSize = CGSizeMake(x, self.scv_main.frame.size.height);
}
- (void)closeFocus {
    self.navigationItem.titleView = nil;
    [Global_Controller setDefaultBacgroundWithLogo:self.navigationController];
    if([self.txt_search isFirstResponder]) {
        [self.txt_search resignFirstResponder];
    }
}
- (void)setMenuSelected:(NSString *)key {
    for(NSString *each in menu_view_list) {
        Menu_View *menu_view = [menu_view_list objectForKey:each];
        if([each isEqualToString:key]) {
            if(![menu_view isSelected]) {
                [menu_view setSelected:true];
            }
        }else {
            [menu_view setSelected:false];
        }
    }
}
- (void)scrollTo:(NSString *)key {
    NSInteger index = [menu_list indexOfObject:key];
    CGRect frame = self.scv_main.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    [self.scv_main scrollRectToVisible:frame animated:YES];
}
- (void)openDetail:(id)data {
    [self closeFocus];
    [self pushDetail:data];
}
@end