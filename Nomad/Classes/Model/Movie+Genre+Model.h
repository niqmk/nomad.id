@interface Movie_Genre_Model : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *movie_genre_list;
+ (Movie_Genre_Model *)init:(NSDictionary *)data;
@end