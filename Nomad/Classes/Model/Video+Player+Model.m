#import "Video+Player+Model.h"
@implementation Video_Player_Model
+ (Video_Player_Model *)init:(long)id
                   VideoType:(VideoType)video_type
                       Title:(NSString *)title
                        Path:(NSString *)path
                    Filename:(NSString *)filename
                         URL:(NSString *)url {
    Video_Player_Model *video_player_model = [[Video_Player_Model alloc] init];
    video_player_model.id = id;
    video_player_model.video_type = video_type;
    video_player_model.title = title;
    video_player_model.path = path;
    video_player_model.filename = filename;
    video_player_model.url = url;
    return video_player_model;
}
@end