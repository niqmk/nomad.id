@interface Login_Model : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *fb_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *full_name;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic) int total_points;
@property (nonatomic, strong) NSString *auth_token;
+ (Login_Model *)init:(NSDictionary *)data;
@end