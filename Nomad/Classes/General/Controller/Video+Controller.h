#import <AVFoundation/AVFoundation.h>
@protocol Video_Delegate <NSObject>
@required
- (void)didVideoPlayed;
- (void)didVideoError;
- (void)didVideoStopped;
@optional
- (void)didVideoPlayedTime:(float)time;
- (void)didVideoReceivedDuration:(float)duration;
@end
@interface Video_Controller : NSObject
@property (nonatomic, assign) id<Video_Delegate> delegate;
@property (nonatomic, strong) AVPlayer *player;
+ (NSTimeInterval)getDuration:(NSString *)url;
- (void)open:(NSString *)url
      ToView:(UIView *)view;
- (void)openURL:(NSURL *)url
         ToView:(UIView *)view;
- (void)stop;
- (void)startServer:(Video_Player_Model *)video_player_model
               View:(UIView *)view;
- (void)stopServer;
- (void)play:(NSString *)url;
- (void)play;
- (void)pause;
- (void)toogleRatio;
- (void)seek:(float)time;
- (void)changeView:(UIView *)view;
@end