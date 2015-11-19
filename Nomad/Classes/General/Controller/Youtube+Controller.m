#import "Youtube+Controller.h"
@implementation Youtube_Controller
- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch(state) {
        case kYTPlayerStateUnstarted:
            break;
        case kYTPlayerStatePlaying:
            break;
        case kYTPlayerStatePaused:
            break;
        case kYTPlayerStateEnded:
            break;
        default:
            break;
    }
}
- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView {
    [playerView playVideo];
}
- (void)open:(NSString *)youtube_id
        View:(UIView *)view {
    self.vw_youtube = [[YTPlayerView alloc] init];
    self.vw_youtube.delegate = self;
    NSDictionary *vars = @{
                           @"controls" : @1,
                           @"playsinline" : @1,
                           };
    [self.vw_youtube loadWithVideoId:youtube_id playerVars:vars];
    self.vw_youtube.frame = view.bounds;
    [view addSubview:self.vw_youtube];
}
- (void)close {
    [self.vw_youtube stopVideo];
    [self.vw_youtube removeFromSuperview];
}
- (void)play:(NSString *)id {
    [self.vw_youtube playVideo];
}
@end