#import "Menu+Logged+Controller.h"
#import "URL+Manager.h"
@implementation Menu_Logged_Controller {
@private
    NSMutableArray *menu_list;
    MenuState menu_state;
    Global_Variables *gb_variables;
    NSInteger index_selected;
    bool updated;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {
        gb_variables = [Global_Variables instance];
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(menu_state == MenuMaster) {
        return [menu_list count];
    }else if(menu_state == MenuDetail) {
        Menu_Model *menu_model = [menu_list objectAtIndex:index_selected];
        return [menu_model.categories count];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *menu_logged_list_id = @"MenuLoggedListID";
    Menu_Logged_Cell *cell = (Menu_Logged_Cell *)[tableView dequeueReusableCellWithIdentifier:menu_logged_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Menu+Logged+Cell" owner:self options:nil];
        cell = self.menu_logged_cell;
    }
    if(menu_state == MenuMaster) {
        Menu_Model *menu_model = [menu_list objectAtIndex:row];
        [cell set:menu_model];
    }else if(menu_state == MenuDetail) {
        Menu_Model *menu_model = [menu_list objectAtIndex:index_selected];
        Menu_Category_Model *menu_category_model = [menu_model.categories objectAtIndex:row];
        [cell set:menu_category_model];
    }
    [Global_Controller setSelectedCell:cell Color:[UIColor colorWithRed:66.0f/255.0f green:189.0f/255.0f blue:222.0f/255.0 alpha:1.0f]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if(menu_state == MenuMaster) {
        [tableView deselectRowAtIndexPath:indexPath animated:true];
    }
    [self setSelected:row];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    updated = false;
    [self setInitial];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(updated) {
        [self request:false];
    }else {
        if([gb_variables->menu_session isSession]) {
            menu_list = [gb_variables->menu_session getMenuList];
            [self.lst_menu reloadData];
            [self setLayoutList:[menu_list count]
                         Remove:false];
            updated = true;
            [self request:false];
        }else {
            [self request:true];
        }
    }
}
- (IBAction)doHome:(id)sender {
    [App_Controller openHome:self];
    [self doDiscover:self];
}
- (IBAction)doDownloadList:(id)sender {
    [App_Controller openDownloadList:self];
}
- (IBAction)doSettings:(id)sender {
    [App_Controller openPoint:self];
}
- (IBAction)doDiscover:(id)sender {
    if(menu_state == MenuMaster) {
        return;
    }
    menu_state = MenuMaster;
    [self.btn_submenu setTitle:text_blank forState:UIControlStateNormal];
    [self.lst_menu reloadData];
    [self setLayoutList:[menu_list count] Remove:false];
    [self request:false];
}
- (void)setInitial {
    menu_state = MenuMaster;
    [self.lst_menu setBackgroundColor:[UIColor whiteColor]];
}
- (void)setSelected:(NSInteger)index {
    if(menu_state == MenuMaster) {
        menu_state = MenuDetail;
        index_selected = index;
        Menu_Model *menu_model = [menu_list objectAtIndex:index_selected];
        [self setSubmenuText:menu_model.name];
        [self.lst_menu reloadData];
        [self setLayoutList:[menu_model.categories count] Remove:true];
    }else if(menu_state == MenuDetail) {
        Menu_Model *menu_model = [menu_list objectAtIndex:index_selected];
        Menu_Category_Model *menu_category_model = [menu_model.categories objectAtIndex:index];
        [App_Controller openHome:self
                       VideoType:menu_model.video_type_id
                              ID:menu_category_model.id];
    }
}
- (void)setLayoutList:(NSInteger)total
               Remove:(bool)remove {
    if(remove) {
        for(UIView *view in self.scv_menu.subviews) {
            [view removeFromSuperview];
        }
    }
    CGSize size = self.scv_menu.frame.size;
    float total_list_height = total * 40;
    self.lst_menu.frame = CGRectMake(0, 0, size.width, total_list_height);
    CGFloat scale = size.width / self.img_menu_footer.frame.size.width;
    CGFloat height = self.img_menu_footer.frame.size.height * scale;
    if(size.height < total_list_height + height) {
        self.img_menu_footer.frame = CGRectMake(0, total_list_height + 10, size.width, height);
    }else {
        self.img_menu_footer.frame = CGRectMake(0, size.height - height, size.width, height);
    }
    if(![self.scv_menu.subviews containsObject:self.lst_menu]) {
        [self.scv_menu addSubview:self.lst_menu];
    }
    if(![self.scv_menu.subviews containsObject:self.img_menu_footer]) {
        [self.scv_menu addSubview:self.img_menu_footer];
    }
    self.scv_menu.contentSize = CGSizeMake(size.width, self.img_menu_footer.frame.origin.y + self.img_menu_footer.frame.size.height);
    [self.scv_menu scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}
- (void)setSubmenuText:(NSString *)value {
    [self.btn_submenu setTitle:[NSString stringWithFormat:@"> %@", value] forState:UIControlStateNormal];
}
- (void)request:(bool)update_ui {
    if(update_ui) {
        [self setLoading:true];
    }
    [URL_Manager Menus:^(Menu_Model *menu_model) {
        menu_list = menu_model.menu_list;
        [gb_variables->menu_session saveMenu:menu_list];
        if(update_ui) {
            [self setLoading:false];
            [self.lst_menu reloadData];
            [self setLayoutList:[menu_list count] Remove:false];
            updated = true;
        }
    } Error:^(NSInteger status_code, NSDictionary *response) {
        if(update_ui) {
            [self request:update_ui];
        }
    }];
}

- (void)setLoading:(bool)show {
    [self.vw_loading setHidden:!show];
}
@end