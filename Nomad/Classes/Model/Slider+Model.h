@interface Slider_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long video_id;
@property (nonatomic) long serial_id;
@property (nonatomic) long first_episode_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *link_url;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic) VideoType video_type_id;
@property (nonatomic, strong) NSMutableArray *slider_list;
+ (Slider_Model *)init:(NSDictionary *)data;
@end