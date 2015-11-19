@interface Purchased_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long video_id;
@property (nonatomic) VideoType video_type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *url;
@property (nonatomic) long log;
@property (nonatomic) long expiry;
+ (Purchased_Model *)init:(long)video_id
                VideoType:(VideoType)video_type
                    Title:(NSString *)title
                 Filename:(NSString *)filename
                      URL:(NSString *)url
                      Log:(long)log
                   Expiry:(long)expiry;
@end