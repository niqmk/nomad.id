@interface Movie_Director_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *movie_director_list;
+ (Movie_Director_Model *)init:(NSDictionary *)data;
@end