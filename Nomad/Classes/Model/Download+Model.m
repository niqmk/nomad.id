#import "Download+Model.h"
@implementation Download_Model
+ (Download_Model *)init:(NSString *)id
                 VideoID:(long)video_id
               VideoType:(VideoType)video_type
                   Title:(NSString *)title
                Filename:(NSString *)filename
                     URL:(NSString *)url
                     Log:(long)log
                  Expiry:(long)expiry {
    Download_Model *download_model = [[Download_Model alloc] init];
    download_model.id = id;
    download_model.video_id = video_id;
    download_model.video_type = video_type;
    download_model.title = title;
    download_model.filename = filename;
    download_model.url = url;
    download_model.log = log;
    download_model.expiry = expiry;
    return download_model;
}
@end