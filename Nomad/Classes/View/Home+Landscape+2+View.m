#import "Home+Landscape+2+View.h"
#import "Home+Landscape+Thumb+View.h"
#import "URL+Manager.h"
#import "Movie+Model.h"
#import "Serial+Model.h"
@interface Home_Landscape_2_View() <Home_Landscape_Thumb_View_Delegate>
@end
@implementation Home_Landscape_2_View {
@private
    VideoType _video_type;
    NSString *_url;
}
- (id)init {
    Home_Landscape_2_View *home_landscape_2_view = [[[NSBundle mainBundle] loadNibNamed:@"Home+Landscape+2+View" owner:nil options:nil] objectAtIndex:0];
    if([home_landscape_2_view isKindOfClass:[Home_Landscape_2_View class]]) {
        return home_landscape_2_view;
    }else {
        return nil;
    }
}
- (void)didHomeLandscapeThumbViewSelected:(id)model {
    if(self.layout_controller_delegate != nil) {
        if([(NSObject *)self.layout_controller_delegate respondsToSelector:@selector(didLayoutLandscapeSelected:)]) {
            [self.layout_controller_delegate didLayoutLandscapeSelected:model];
        }
    }
}
- (IBAction)doRefresh:(id)sender {
    [self setRefresh:true];
    [self request:_url
        VideoType:_video_type
         UpdateUI:true];
}
- (void)show:(NSString *)title
         Url:(NSString *)url
   VideoType:(VideoType)video_type {
    [self.lbl_title setText:title];
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
            _video_type = video_type;
            _url = url;
            [self setRefresh:true];
        }
    } Error:^(NSInteger status_code, NSDictionary *response) {
        if(update_ui) {
            _video_type = video_type;
            _url = url;
            [self setRefresh:true];
        }
    }];
}
- (void)setLayout:(NSMutableArray *)list {
    float x = 0;
    float y = 0;
    float width = 0;
    for(int counter = 0; counter < [list count]; counter++) {
        id model = [list objectAtIndex:counter];
        Home_Landscape_Thumb_View *home_landscape_thumb_view = [[Home_Landscape_Thumb_View alloc] init];
        home_landscape_thumb_view.delegate = self;
        width = home_landscape_thumb_view.frame.size.width;
        if(counter % 2 == 0) {
            y = 0;
        }else {
            x = (width + 8) * (counter / 2);
            y += home_landscape_thumb_view.frame.size.height + 8;
        }
        home_landscape_thumb_view.frame = CGRectMake(x, y, width, home_landscape_thumb_view.frame.size.height);
        [home_landscape_thumb_view set:model];
        [self.scv_main addSubview:home_landscape_thumb_view];
        x += home_landscape_thumb_view.frame.size.width + 8;
    }
    self.scv_main.contentSize = CGSizeMake(x, self.scv_main.frame.size.height);
}
- (void)setRefresh:(bool)show {
    [self.btn_refresh setHidden:!show];
}
@end