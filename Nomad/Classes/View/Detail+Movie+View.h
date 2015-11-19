#import <MRProgress/MRCircularProgressView.h>
#import "Movie+Detail+Model.h"
@protocol Detail_Movie_View_Delegate
@optional
- (void)didDetailMovieViewLike:(bool)selected;
- (void)didDetailMovieViewRate;
- (void)didDetailMovieViewPlay;
- (void)didDetailMovieViewPauseDownload;
- (void)didDetailMovieViewPlayVideo;
- (void)didDetailMovieViewPauseVideo;
- (void)didDetailMovieViewSeekVideo:(float)time;
@end
@interface Detail_Movie_View : UIView
@property (nonatomic, assign) id<Detail_Movie_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIImageView *img_background;
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UIView *vw_player;
@property (nonatomic, strong) IBOutlet UIView *vw_command;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *pgb_loading;
@property (nonatomic, strong) IBOutlet UIButton *btn_pause;
@property (nonatomic, strong) IBOutlet UISlider *sld_player;
@property (nonatomic, strong) IBOutlet MRCircularProgressView *cgv_download;
@property (nonatomic, strong) IBOutlet UILabel *lbl_title;
@property (nonatomic, strong) IBOutlet UIButton *btn_like;
@property (nonatomic, strong) IBOutlet UIButton *btn_rate;
@property (nonatomic, strong) IBOutlet UIButton *btn_play;
@property (nonatomic, strong) IBOutlet UILabel *lbl_rate;
@property (nonatomic, strong) IBOutlet UILabel *lbl_description;
@property (nonatomic, strong) IBOutlet UIButton *btn_more;
@property (nonatomic, strong) IBOutlet UIView *vw_info;
- (void)show:(Movie_Detail_Model *)model
       Width:(float)width;
- (void)setDownload:(bool)show;
- (void)setDownloadProgressing:(float)percentage;
- (void)setPlayerView:(bool)show;
- (void)setPlayFulltime:(bool)show;
- (void)setLoading:(bool)show;
- (void)setSliderValue:(float)time;
- (void)setSliderDuration:(float)duration;
@end