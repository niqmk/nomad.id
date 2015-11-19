#import "Video+Player+Controller.h"
#import "Video+Controller.h"
#import "File+Controller.h"
#import "Secure+Controller.h"
@interface Video_Player_Controller() <Video_Delegate>
@end
@implementation Video_Player_Controller {
@private
    Video_Controller *video_controller;
    Video_Player_Model *video_player_data;
    NSTimer *tmr_view;
    NSTimer *tmr_tap;
    bool init;
    bool trigger;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                Video:(Video_Player_Model *)video_player_model {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {
        video_player_data = video_player_model;
        video_controller = [[Video_Controller alloc] init];
        video_controller.delegate = self;
    }
    return self;
}
- (void)didVideoPlayed {
    [self.btn_action setSelected:true];
    [self.pgb_loading stopAnimating];
}
- (void)didVideoError {
    [self.pgb_loading stopAnimating];
    [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                      Message:[App_Controller getError:@"error_video_playback"]
                     Delegate:nil];
}
- (void)didVideoStopped {}
- (void)didVideoPlayedTime:(float)time {
    self.sld_player.value = time;
}
- (void)didVideoReceivedDuration:(float)duration {
    if(isnan(duration)) {
        return;
    }
    self.sld_player.maximumValue = duration;
    self.sld_player.value = 0.0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    init = true;
    self.sld_player.maximumValue = 0.0;
    self.sld_player.value = 0.0;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(init) {
        init = false;
        [self playVideo];
        trigger = true;
        [self startViewTimer];
    }
}
- (BOOL)shouldAutorotate {
    return true;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}
- (IBAction)doBack:(id)sender {
    trigger = false;
    [self stopViewTimer];
    [self stopVideo];
    [App_Controller closeVideoPlayer:nil];
}
- (IBAction)doTap:(id)sender {
    if(tmr_tap == nil) {
        [self startTapTimer];
    }else {
        [self stopTapTimer:true];
    }
}
- (IBAction)doAction:(id)sender {
    trigger = false;
    [self stopViewTimer];
    if([self.btn_action isSelected]) {
        [self.btn_action setSelected:false];
        [video_controller pause];
        trigger = true;
        [self startViewTimer];
    }else {
        [self.btn_action setSelected:true];
        [video_controller play];
        trigger = true;
        [self startViewTimer];
    }
}
- (IBAction)changeSlider:(id)sender {
    trigger = false;
    [self stopViewTimer];
    [self.btn_action setSelected:false];
    [video_controller pause];
}
- (IBAction)changeTopSlider:(id)sender {
    [video_controller seek:self.sld_player.value];
    [video_controller play];
    [self.btn_action setSelected:true];
    trigger = true;
    [self startViewTimer];
}
- (void)startViewTimer {
    tmr_view = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                                target:self
                                              selector:@selector(stopViewTimer)
                                              userInfo:nil
                                               repeats:NO];
}
- (void)stopViewTimer {
    if(tmr_view == nil) {
        return;
    }
    [tmr_view invalidate];
    tmr_view = nil;
    if(trigger) {
        trigger = false;
        [self setCommand:false];
    }
}
- (void)startTapTimer {
    tmr_tap = [NSTimer scheduledTimerWithTimeInterval:0.7f
                                               target:self
                                             selector:@selector(stopTapTimer:)
                                             userInfo:nil
                                              repeats:NO];
}
- (void)stopTapTimer:(bool)double_tap {
    if(tmr_tap == nil) {
        return;
    }
    [tmr_tap invalidate];
    tmr_tap = nil;
    if(double_tap) {
        [video_controller toogleRatio];
    }else {
        [self setCommand:true];
        trigger = true;
        [self startViewTimer];
    }
}
- (void)setCommand:(bool)show {
    CGSize size = self.view.frame.size;
    if(show) {
        [self.vw_command setAlpha:0.0f];
        self.vw_command.frame = CGRectMake(0, size.height, self.vw_command.frame.size.width, self.vw_command.frame.size.height);
        [UIView animateWithDuration:0.5f animations:^{
            [self.vw_command setAlpha:0.7f];
            self.vw_command.frame = CGRectMake(0, size.height - self.vw_command.frame.size.height, self.vw_command.frame.size.width, self.vw_command.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f animations:^{
                [self.btn_back setAlpha:1.0f];
            }];
        }];
    }else {
        [self.vw_command setAlpha:1.0f];
        [UIView animateWithDuration:0.5f animations:^{
            [self.vw_command setAlpha:0.3f];
            self.vw_command.frame = CGRectMake(0, size.height, self.vw_command.frame.size.width, self.vw_command.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f animations:^{
                [self.btn_back setAlpha:0.0f];
            }];
        }];
    }
}
- (void)playVideo {
    if([File_Controller isFileExist:video_player_data.filename]) {
        [video_controller startServer:video_player_data
                                 View:self.vw_player];
    }else {
        [video_controller open:[Secure_Controller decrypt:video_player_data.url]
                        ToView:self.vw_player];
    }
}
- (void)stopVideo {
    if(video_controller != nil) {
        [video_controller stopServer];
    }
}
@end