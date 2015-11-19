#import "Login+Model.h"
@interface User_Model : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *auth_token;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *fb_id;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *full_name;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic) long total_points;
+ (User_Model *)init:(Login_Model *)login_model;
@end