#import "Purchased+Model.h"
@implementation Purchased_Model
+ (Purchased_Model *)init:(long)video_id
                VideoType:(VideoType)video_type
                    Title:(NSString *)title
                 Filename:(NSString *)filename
                      URL:(NSString *)url
                      Log:(long)log
                   Expiry:(long)expiry {
    Purchased_Model *purchased_model = [[Purchased_Model alloc] init];
    purchased_model.video_id = video_id;
    purchased_model.video_type = video_type;
    purchased_model.title = title;
    purchased_model.filename = filename;
    purchased_model.url = url;
    purchased_model.log = log;
    purchased_model.expiry = expiry;
    return purchased_model;
}
@end