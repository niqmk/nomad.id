#import <MRProgress/MRCircularProgressView.h>
#import "Serial+Episode+Cell.h"
@protocol Detail_Serial_View_Delegate
@optional
- (void)didDetailSerialViewLike:(bool)selected;
- (void)didDetailSerialViewPlay;
- (void)didDetailSerialViewPauseDownload;
- (void)didDetailSerialViewPlayVideo;
- (void)didDetailSerialViewPauseVideo;
- (void)didDetailSerialViewSeekVideo:(float)time;
- (void)didDetailSerialViewChangeEpisode:(Serial_Detail_Model *)serial_detail_model;
@end
@interface Detail_Serial_View : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<Detail_Serial_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UIView *vw_player;
@property (nonatomic, strong) IBOutlet UIView *vw_command;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *pgb_loading;
@property (nonatomic, strong) IBOutlet UIButton *btn_pause;
@property (nonatomic, strong) IBOutlet UISlider *sld_player;
@property (nonatomic, strong) IBOutlet MRCircularProgressView *cgv_download;
@property (nonatomic, strong) IBOutlet UIView *vw_action;
@property (nonatomic, strong) IBOutlet UILabel *lbl_title;
@property (nonatomic, strong) IBOutlet UIButton *btn_like;
@property (nonatomic, strong) IBOutlet UIButton *btn_play;
@property (nonatomic, strong) IBOutlet UITableView *lst_episodes;
@property (nonatomic, strong) IBOutlet Serial_Episode_Cell *serial_episode_cell;
- (void)show:(Serial_Detail_Model *)serial_detail_model
       Width:(float)width;
- (void)setDownload:(bool)show;
- (void)setDownloadProgressing:(float)percentage;
- (void)setPlayerView:(bool)show;
- (void)setPlayFulltime:(bool)show;
- (void)setLoading:(bool)show;
- (void)setSliderValue:(float)time;
- (void)setSliderDuration:(float)duration;
- (void)rollback;
@end