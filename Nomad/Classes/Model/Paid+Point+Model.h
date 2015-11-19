@interface Paid_Point_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long price_in_idr;
@property (nonatomic) long point;
@property (nonatomic, strong) NSMutableArray *paid_point_list;
+ (Paid_Point_Model *)init:(NSDictionary *)data;
@end