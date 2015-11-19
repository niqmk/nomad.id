@interface Response_Model : NSObject
@property (nonatomic) int status;
@property (nonatomic, strong) NSDictionary *result;
@property (nonatomic, strong) NSString *message;
+ (Response_Model *)init:(NSDictionary *)data;
@end