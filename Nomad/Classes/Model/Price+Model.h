@interface Price_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long price;
@property (nonatomic) long expiry_days;
@property (nonatomic, strong) NSMutableArray *price_list;
+ (Price_Model *)init:(NSDictionary *)data;
@end