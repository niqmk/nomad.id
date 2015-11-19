@interface Me_Model : NSObject
@property (nonatomic, strong) NSString *fb_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *full_name;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic) long total_points;
+ (Me_Model *)init:(NSDictionary *)data;
@end