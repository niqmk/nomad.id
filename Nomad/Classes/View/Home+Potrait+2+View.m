#import "Home+Potrait+2+View.h"
#import "Potrait+View.h"
#import "URL+Manager.h"
#import "Movie+Model.h"
#import "Serial+Model.h"
@interface Home_Potrait_2_View() <Potrait_View_Delegate>
@end
@implementation Home_Potrait_2_View {
@private
    VideoType _video_type;
    NSString *_url;
    float super_width;
}
- (id)init {
    Home_Potrait_2_View *home_potrait_2_view = [[[NSBundle mainBundle] loadNibNamed:@"Home+Potrait+2+View" owner:nil options:nil] objectAtIndex:0];
    if([home_potrait_2_view isKindOfClass:[Home_Potrait_2_View class]]) {
        return home_potrait_2_view;
    }else {
        return nil;
    }
}
- (void)didPotraitViewSelected:(id)model {
    if(self.layout_menu_controller_delegate != nil) {
        if([(NSObject *)self.layout_menu_controller_delegate respondsToSelector:@selector(didLayoutMenuPotraitSelected:)]) {
            [self.layout_menu_controller_delegate didLayoutMenuPotraitSelected:model];
        }
    }
}
- (IBAction)doRefresh:(id)sender {
    [self setRefresh:false];
    [self request:_url
        VideoType:_video_type
         UpdateUI:true];
}
- (void)show:(NSString *)key
  CategoryID:(long)category_id
         URL:(NSString *)url
   VideoType:(VideoType)video_type
       Width:(float)width {
    super_width = width;
    url = [NSString stringWithFormat:url, category_id];
    if([App_Controller isSessionHome:url]) {
        _video_type = video_type;
        _url = url;
        NSMutableArray *list = [App_Controller getSessionHome:url];
        [self setLayout:list];
        [self request:url
            VideoType:video_type
             UpdateUI:false];
    }else {
        [self request:url
            VideoType:video_type
             UpdateUI:true];
    }
}
- (void)request:(NSString *)url
      VideoType:(VideoType)video_type
       UpdateUI:(bool)update_ui {
    if(update_ui) {
        [self setLoading:true];
    }
    [URL_Manager Get:url
             Headers:nil
    Complete:^(NSDictionary *response) {
        NSMutableArray *list = nil;
        if(video_type == MovieVideoType) {
            Movie_Model *movie_model = [Movie_Model init:[response objectForKey:@"data"]];
            list = movie_model.movie_list;
        }else if(video_type == SerialVideoType) {
            Serial_Model *serial_model = [Serial_Model init:[response objectForKey:@"data"]];
            list = serial_model.serial_list;
        }
        if(list != nil) {
            [App_Controller setSessionHome:url
                                      List:list];
            if(update_ui) {
                [self setLayout:list];
            }
        }
    } Failed:^(NSString *message) {
        if(update_ui) {
            [self setLoading:false];
            _video_type = video_type;
            _url = url;
            [self setRefresh:true];
        }
    } Error:^(NSInteger status_code, NSDictionary *response) {
        if(update_ui) {
            [self setLoading:false];
            _video_type = video_type;
            _url = url;
            [self setRefresh:true];
        }
    }];
}
- (void)setLayout:(NSMutableArray *)list {
    [self setScrollView];
    int counter = 0;
    float y = 2;
    for(id model in list) {
        counter++;
        Potrait_View *potrait_view = [[Potrait_View alloc] init];
        potrait_view.delegate = self;
        float width = (super_width / 2) - 4;
        float scale = width / potrait_view.frame.size.width;
        float height = potrait_view.frame.size.height * scale;
        if(counter % 2 == 0) {
            potrait_view.frame = CGRectMake(width + 4, y, width, height);
            y += height + 2;
        }else {
            potrait_view.frame = CGRectMake(2, y, width, height);
        }
        [potrait_view set:model];
        [self.scv_main addSubview:potrait_view];
    }
    self.frame = CGRectMake(0, 0, super_width, y);
    self.scv_main.contentSize = CGSizeMake(super_width, y);
    [self setLoading:false];
}
- (void)setScrollView {
    float scale = super_width / self.scv_main.frame.size.width;
    float height = self.scv_main.frame.size.height * scale;
    self.scv_main.frame = CGRectMake(0, 0, super_width, height - 10);
}
- (void)setRefresh:(bool)show {
    [self.btn_refresh setHidden:!show];
}
- (void)setLoading:(bool)show {
    [self.vw_loading setHidden:!show];
}
@end