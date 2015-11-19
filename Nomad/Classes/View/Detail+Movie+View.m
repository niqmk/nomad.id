#import "Detail+Movie+View.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Layout+Controller.h"
@implementation Detail_Movie_View {
@private
    Movie_Detail_Model *movie_detail_data;
    float super_width;
    bool expanded;
    bool init_play_from_downloading;
}
float const default_min_desc = 100.0f;
- (id)init {
    Detail_Movie_View *detail_movie_view = [[[NSBundle mainBundle] loadNibNamed:@"Detail+Movie+View" owner:nil options:nil] objectAtIndex:0];
    if([detail_movie_view isKindOfClass:[Detail_Movie_View class]]) {
        return detail_movie_view;
    }else {
        return nil;
    }
}
- (IBAction)doLike:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailMovieViewLike:)]) {
            [self.delegate didDetailMovieViewLike:[self.btn_like isSelected]];
        }
    }
}
- (IBAction)doRate:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailMovieViewRate)]) {
            [self.delegate didDetailMovieViewRate];
        }
    }
}
- (IBAction)doPlay:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailMovieViewPlay)]) {
            [self.delegate didDetailMovieViewPlay];
        }
    }
}
- (IBAction)doPauseDownload:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailMovieViewPauseDownload)]) {
            [self.delegate didDetailMovieViewPauseDownload];
        }
    }
    [self setDownload:false];
}
- (IBAction)doPause:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailMovieViewPauseVideo)]) {
            [self.delegate didDetailMovieViewPauseVideo];
        }
    }
}
- (IBAction)changeSlider:(id)sender {
    [self doPause:self];
}
- (IBAction)changeTopSlider:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailMovieViewSeekVideo:)]) {
            [self.delegate didDetailMovieViewSeekVideo:self.sld_player.value];
        }
    }
}
- (IBAction)doMore:(id)sender {
    expanded = !expanded;
    [self setDescLayout:false];
}
- (void)show:(Movie_Detail_Model *)movie_detail_model
       Width:(float)width {
    super_width = width;
    movie_detail_data = movie_detail_model;
    [self setLayout];
}
- (void)setDownload:(bool)show {
    [self.cgv_download setHidden:!show];
    [self.btn_play setHidden:show];
    init_play_from_downloading = false;
}
- (void)setDownloadProgressing:(float)percentage {
    [self.cgv_download setProgress:percentage
                          animated:true];
    if(percentage > 0.1f && percentage < 1.0f) {
        [self.cgv_download.valueLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10.0f]];
    }else if(percentage >= 1.0f) {
        [self.cgv_download.valueLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:8.0f]];
    }
    if(percentage == INFINITY) {
        return;
    }
    if(percentage >= default_min_percentage_play_video) {
        if(!init_play_from_downloading) {
            init_play_from_downloading = true;
            if(self.delegate != nil) {
                if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailMovieViewPlayVideo)]) {
                    [self.delegate didDetailMovieViewPlayVideo];
                }
            }
        }
    }
}
- (void)setPlayerView:(bool)show {
    [self.vw_player setHidden:!show];
}
- (void)setPlayFulltime:(bool)show {
    [self.vw_player setHidden:!show];
    [self.cgv_download setHidden:show];
    [self.btn_play setHidden:show];
    [self.vw_command setHidden:!show];
    [self setLoading:show];
}
- (void)setLoading:(bool)show {
    if(show) {
        [self.pgb_loading startAnimating];
    }else {
        [self.pgb_loading stopAnimating];
    }
}
- (void)setSliderValue:(float)time {
    self.sld_player.value = time;
}
- (void)setSliderDuration:(float)duration {
    if(isnan(duration)) {
        return;
    }
    self.sld_player.maximumValue = duration;
    self.sld_player.value = 0.0;
}
- (void)setLayout {
    [self setImageBackground];
    [self.cgv_download.valueLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12.0f]];
    [self.cgv_download setBackgroundColor:[UIColor whiteColor]];
    [self.lbl_title setText:movie_detail_data.title];
    self.sld_player.maximumValue = 0.0;
    self.sld_player.value = 0.0;
    [self.lbl_rate setText:[NSString stringWithFormat:@"%.f", movie_detail_data.overall_rating]];
    if(movie_detail_data.log_on_member != nil) {
        [self.btn_like setSelected:movie_detail_data.log_on_member.is_liked];
        [self.btn_rate setSelected:(movie_detail_data.log_on_member.comment != nil)];
    }
    [self setDescLayout:true];
}
- (void)setDescLayout:(bool)create {
    CGPoint point = self.lbl_description.frame.origin;
    CGSize size = self.lbl_description.frame.size;
    float y = 0;
    self.lbl_description.frame = CGRectMake(point.x, point.y, size.width, 0);
    [self.lbl_description setText:movie_detail_data.desc];
    [self.lbl_description sizeToFit];
    [self.lbl_description setTextAlignment:NSTextAlignmentJustified];
    if(expanded) {
        self.lbl_description.frame = CGRectMake(point.x, point.y, size.width, self.lbl_description.frame.size.height);
        [self.btn_more setTitle:@"Less..." forState:UIControlStateNormal];
    }else {
        self.lbl_description.frame = CGRectMake(point.x, point.y, size.width, default_min_desc);
        [self.btn_more setTitle:@"More..." forState:UIControlStateNormal];
    }
    y = self.lbl_description.frame.origin.y + self.lbl_description.frame.size.height;
    self.btn_more.frame = CGRectMake(super_width - self.btn_more.frame.size.width - 5, y + 5, self.btn_more.frame.size.width, self.btn_more.frame.size.height);
    y = self.btn_more.frame.origin.y + self.btn_more.frame.size.height + 8;
    [self setInfoLayout:y
                 Create:create];
}
- (void)setInfoLayout:(float)y
               Create:(bool)create {
    if(create) {
        UIView *view = [Layout_Controller getInfoLayout:movie_detail_data
                                                  Width:super_width
                                                   Font:self.lbl_description.font];
        view.frame = CGRectMake(0, 38, super_width, view.frame.size.height);
        [self.vw_info addSubview:view];
        self.vw_info.frame = CGRectMake(0, y, super_width, view.frame.size.height + 45);
        [self.scv_main addSubview:self.vw_info];
    }else {
        self.vw_info.frame = CGRectMake(0, y, super_width, self.vw_info.frame.size.height);
    }
    y += self.vw_info.frame.size.height;
    self.scv_main.contentSize = CGSizeMake(super_width, y);
}
- (void)setImageBackground {
    NSString *image_preload = text_blank;
    if([Global_Controller isNotNull:[movie_detail_data.images objectForKey:@"by_width"]]) {
        image_preload = [[movie_detail_data.images objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", 10.0f]];
    }
    [self.img_background sd_setImageWithURL:[NSURL URLWithString:image_preload] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image == nil) {
            return;
        }
        NSString *image_url = text_blank;
        if([Global_Controller isNotNull:[movie_detail_data.images objectForKey:@"by_width"]]) {
            image_url = [[movie_detail_data.images objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", self.frame.size.width]];;
        }
        [self.image sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:image options:SDWebImageRetryFailed];
    }];
}
@end