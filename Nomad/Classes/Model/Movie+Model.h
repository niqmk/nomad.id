#import "Movie+Related+Model.h"
#import "Search+Model.h"
@interface Movie_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long video_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, strong) NSMutableArray *movie_list;
+ (Movie_Model *)init:(NSDictionary *)data;
+ (Movie_Model *)initRelated:(Movie_Related_Model *)movie_related_model;
+ (Movie_Model *)initSearched:(Search_Model *)search_model;
@end