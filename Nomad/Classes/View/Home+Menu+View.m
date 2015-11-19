#import "Home+Menu+View.h"
#import "URL+Manager.h"
#import "Layout+Menu+Controller.h"
@interface Home_Menu_View() <Layout_Menu_Controller_Delegate>
@end
@implementation Home_Menu_View {
@private
    VideoType type;
    NSString *key_layout;
    long _category_id;
    float super_width;
    float y;
}
- (id)init {
    Home_Menu_View *home_menu_view = [[[NSBundle mainBundle] loadNibNamed:@"Home+Menu+View" owner:nil options:nil] objectAtIndex:0];
    if([home_menu_view isKindOfClass:[Home_Menu_View class]]) {
        return home_menu_view;
    }else {
        return nil;
    }
}
- (void)didLayoutMenuPotraitSelected:(id)model {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didHomeMenuViewPotraitSelected:)]) {
            [self.delegate didHomeMenuViewPotraitSelected:model];
        }
    }
}
- (void)didLayoutMenuLandscapeSelected:(id)model {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didHomeMenuViewLandscapeSelected:)]) {
            [self.delegate didHomeMenuViewLandscapeSelected:model];
        }
    }
}
- (void)show:(NSString *)key
  CategoryID:(long)category_id
   VideoType:(VideoType)video_type
       Width:(float)width {
    key_layout = key;
    _category_id = category_id;
    type = video_type;
    super_width = width;
    y = 0;
    [self setLayout];
}
- (void)setLayout {
    Layout_Menu_Controller *layout_menu_controller = [[Layout_Menu_Controller alloc] init];
    NSMutableArray *layout_list = [layout_menu_controller getHomeLayout:key_layout
                                                             CategoryID:_category_id
                                                              VideoType:type
                                                                  Width:super_width
                                                               Delegate:self];
    if(layout_list == nil) {
        return;
    }
    for(UIView *each in layout_list) {
        float height = each.frame.size.height;
        each.frame = CGRectMake(0, y, super_width, height);
        [self.scv_main addSubview:each];
        y += height + 10;
    }
    CGSize size = self.scv_main.frame.size;
    float scale_main = super_width / size.width;
    float height_main = size.height * scale_main;
    CGFloat scale = super_width / 320;
    CGFloat height_footer = 223 * scale;
    UIImageView *img_footer;
    if(height_main < y + height_footer) {
        img_footer = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, super_width, height_footer)];
        y += height_footer;
    }else {
        img_footer = [[UIImageView alloc] initWithFrame:CGRectMake(0, height_main - height_footer, super_width, height_footer)];
    }
    [img_footer setImage:[UIImage imageNamed:@"Bg-Footer"]];
    [self.scv_main addSubview:img_footer];
    self.scv_main.contentSize = CGSizeMake(super_width, y);
}
@end