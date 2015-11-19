@interface Movie_Cast_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSMutableArray *movie_cast_list;
+ (Movie_Cast_Model *)init:(NSDictionary *)data;
@end