#import "Video+Controller.h"
#import "File+Server+Controller.h"
#import "Server+Config.h"
@implementation Video_Controller {
@private
    AVPlayerLayer *layer;
    AVPlayerItem *item;
    UIView *v;
    File_Server_Controller *file_server_controller;
    NSString *string;
}
+ (NSTimeInterval)getDuration:(NSString *)url {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:url] options:nil];
    NSTimeInterval duration_in_seconds = 0.0;
    if(asset)
        duration_in_seconds = CMTimeGetSeconds(asset.duration);
    return duration_in_seconds;
}
- (void)open:(NSString *)url
      ToView:(UIView *)view {
    [self openURL:[NSURL URLWithString:url]
           ToView:view];
}
- (void)openURL:(NSURL *)url
         ToView:(UIView *)view {
    v = view;
    self.player = [AVPlayer playerWithURL:url];
    if(self.player != nil) {
        item = [self.player currentItem];
        [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
        [item addObserver:self forKeyPath:@"error" options:0 context:nil];
    }
    layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [v.layer addSublayer:layer];
    [layer setFrame:CGRectMake(0, 0, v.frame.size.width, v.frame.size.height)];
}
- (void)stop {
    if(self.player == nil) {
        return;
    }
    [self.player pause];
    [self.player removeObserver:self forKeyPath:@"status"];
    [item removeObserver:self forKeyPath:@"error"];
    v.layer.sublayers = nil;
}
- (void)startServer:(Video_Player_Model *)video_player_model
               View:(UIView *)view {
    if(file_server_controller == nil) {
        file_server_controller = [[File_Server_Controller alloc] initListen:video_player_model];
    }
    [file_server_controller start:^(NSURL *url) {
        [self openURL:url
               ToView:view];
    }];
}
- (void)stopServer {
    [self stop];
    if(file_server_controller != nil) {
        [file_server_controller stop];
        file_server_controller = nil;
    }
}
- (void)play:(NSString *)url {
    [self playURL:[NSURL URLWithString:url]];
}
- (void)playURL:(NSURL *)url {
    [self stop];
    self.player = [AVPlayer playerWithURL:url];
    if(self.player != nil) {
        item = [self.player currentItem];
        [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
        [item addObserver:self forKeyPath:@"error" options:0 context:nil];
    }
    layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [v.layer addSublayer:layer];
    [layer setFrame:CGRectMake(0, 0, v.frame.size.width, v.frame.size.height)];
    [self.player play];
}
- (void)play {
    if(self.player != nil) {
        [self.player play];
    }
}
- (void)pause {
    if(self.player != nil) {
        [self.player pause];
    }
}
- (void)playVideo {
    if(self.player != nil) {
        [self.player play];
    }
}
- (void)toogleRatio {
    if([layer.videoGravity isEqualToString:AVLayerVideoGravityResizeAspect]) {
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }else {
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
    }
}
- (void)seek:(float)time {
    if(self.player == nil) {
        return;
    }
    CMTime target_time = CMTimeMakeWithSeconds(time, NSEC_PER_SEC);
    [self.player seekToTime:target_time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
- (void)changeView:(UIView *)view {
    [self pause];
    v.layer.sublayers = nil;
    v = view;
    [v.layer addSublayer:layer];
    [layer setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [self playVideo];
}
- (void)listenPlayedTime {
    if(self.player == nil) {
        return;
    }
    __weak Video_Controller *weakSelf = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if(weakSelf.delegate != nil) {
            if([weakSelf.delegate respondsToSelector:@selector(didVideoPlayedTime:)]) {
                [weakSelf.delegate didVideoPlayedTime:CMTimeGetSeconds(weakSelf.player.currentItem.currentTime)];
            }
        }
    }];
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if(object == self.player && [keyPath isEqualToString:@"status"]) {
        if(self.player.status == AVPlayerStatusReadyToPlay) {
            [self playVideo];
            if(self.delegate != nil) {
                [self.delegate didVideoPlayed];
                if([self.delegate respondsToSelector:@selector(didVideoReceivedDuration:)]) {
                    [self.delegate didVideoReceivedDuration:CMTimeGetSeconds(self.player.currentItem.asset.duration)];
                }
            }
            [self listenPlayedTime];
        }else if(self.player.status == AVPlayerStatusFailed) {
            if(self.delegate != nil) {
                [self.delegate didVideoError];
            }
        }
    }else if(object == self.player.currentItem && [keyPath isEqualToString:@"error"]) {
        if(self.delegate != nil) {
            [self.delegate didVideoError];
        }
    }else if(context == 0) {
        if(self.player.rate == 0.0) {
            if(self.delegate != nil) {
                [self.delegate didVideoStopped];
            }
        }
    }
}
@end