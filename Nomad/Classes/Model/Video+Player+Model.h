#import "VideoType.h"
@interface Video_Player_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) VideoType video_type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *url;
+ (Video_Player_Model *)init:(long)id
                   VideoType:(VideoType)video_type
                       Title:(NSString *)title
                        Path:(NSString *)path
                    Filename:(NSString *)filename
                         URL:(NSString *)url;
@end