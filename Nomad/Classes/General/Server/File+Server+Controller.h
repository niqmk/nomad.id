@interface File_Server_Controller : NSObject
@property (nonatomic, strong) Video_Player_Model *video_player_data;
- (id)initListen:(Video_Player_Model *)video_player_model;
- (void)start:(void(^)(NSURL *url))completeHandler;
- (void)stop;
@end