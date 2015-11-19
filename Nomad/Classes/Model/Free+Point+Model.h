@interface Free_Point_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) long point;
@property (nonatomic, strong) NSMutableArray *free_point_list;
+ (Free_Point_Model *)init:(NSDictionary *)data;
@end