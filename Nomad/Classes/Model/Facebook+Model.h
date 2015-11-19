@interface Facebook_Model : NSObject
@property (nonatomic, strong) NSString *fb_id;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *fullname;
+ (Facebook_Model *)init:(NSDictionary *)data;
@end