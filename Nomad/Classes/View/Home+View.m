#import "Home+View.h"
#import "URL+Manager.h"
#import "Layout+Controller.h"
#import "Layout+Config.h"
@interface Home_View()
<Slider_View_Delegate,
Layout_Controller_Delegate>
@end
@implementation Home_View {
@private
    NSTimer *tmr_slider;
    NSTimer *tmr_wait;
    NSMutableArray *slider_list;
    NSString *key_layout;
    float super_width;
    float y;
}
- (id)init {
    Home_View *home_view = [[[NSBundle mainBundle] loadNibNamed:@"Home+View" owner:nil options:nil] objectAtIndex:0];
    if([home_view isKindOfClass:[Home_View class]]) {
        return home_view;
    }else {
        return nil;
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self stopSliderTimer];
    [self startWaitTimer];
}
- (void)didSliderViewClicked:(Slider_Model *)slider_model {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didHomeViewSliderSelected:)]) {
            [self.delegate didHomeViewSliderSelected:slider_model];
        }
    }
}
- (void)didLayoutPotraitSelected:(id)model {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didHomeViewPotraitSelected:)]) {
            [self.delegate didHomeViewPotraitSelected:model];
        }
    }
}
- (void)didLayoutLandscapeSelected:(id)model {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didHomeViewLandscapeSelected:)]) {
            [self.delegate didHomeViewLandscapeSelected:model];
        }
    }
}
- (void)show:(float)width {
    key_layout = home_popular;
    super_width = width;
    CGSize size = self.scv_slider.frame.size;
    CGFloat scale = super_width / size.width;
    CGFloat height = size.height * scale;
    y = height;
    Global_Variables *gb_variables = [Global_Variables instance];
    if([gb_variables->home_session isCached:url_slider]) {
        slider_list = [gb_variables->home_session get:url_slider];
        [self setSliderLayout:height];
        [self setSliderRequest:false
                        Height:height];
    }else {
        [self setSliderRequest:true
                        Height:height];
    }
    [self setLayout];
}
- (void)showWoSlider:(NSString *)key
               Width:(float)width {
    key_layout = key;
    super_width = width;
    [self.scv_slider setHidden:true];
    y = 0;
    [self setLayout];
}
- (void)setSliderRequest:(bool)update_ui
                  Height:(float)height {
    [URL_Manager Slider:^(Slider_Model *slider_model) {
        slider_list = slider_model.slider_list;
        [App_Controller setSessionHome:url_slider
                                  List:slider_list];
        if(update_ui) {
            [self setSliderLayout:height];
        }
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [self setSliderRequest:update_ui
                        Height:height];
    }];
}
- (void)setSliderLayout:(float)height {
    self.scv_slider.frame = CGRectMake(0, 0, super_width, height);
    float x = 0;
    for(Slider_Model *slider_model in slider_list) {
        Slider_View *slider_view = [[Slider_View alloc] init];
        slider_view.delegate = self;
        [slider_view set:slider_model Width:super_width Height:height];
        slider_view.frame = CGRectMake(x, 0, super_width, height);
        [self.scv_slider addSubview:slider_view];
        x += super_width;
    }
    self.scv_slider.contentSize = CGSizeMake(super_width * [slider_list count], height);
    [self startSliderTimer];
}
- (void)setLayout {
    Layout_Controller *layout_controller = [[Layout_Controller alloc] init];
    NSMutableArray *layout_list = [layout_controller getHomeLayout:key_layout
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
- (void)slide {
    int slide_page = 1;
    CGFloat page_width = self.scv_slider.frame.size.width;
    int page = floor((self.scv_slider.contentOffset.x - page_width / 2 ) / page_width) + 1;
    if(page != [slider_list count] - 1) {
        slide_page = page + 2;
    }
    CGRect frame = self.scv_slider.frame;
    frame.origin.x = frame.size.width * (slide_page - 1);
    frame.origin.y = 0;
    [self.scv_slider scrollRectToVisible:frame animated:true];
}
- (void)startSliderTimer {
    [self stopSliderTimer];
    [self stopWaitTimer];
    tmr_slider = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                  target:self
                                                selector:@selector(slide)
                                                userInfo:nil
                                                 repeats:YES];
}
- (void)stopSliderTimer {
    if(tmr_slider == nil) {
        return;
    }
    [tmr_slider invalidate];
    tmr_slider = nil;
}
- (void)startWaitTimer {
    [self stopWaitTimer];
    tmr_wait = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                target:self
                                              selector:@selector(startSliderTimer)
                                              userInfo:nil
                                               repeats:NO];
}
- (void)stopWaitTimer {
    if(tmr_wait == nil) {
        return;
    }
    [tmr_wait invalidate];
    tmr_wait = nil;
}
@end