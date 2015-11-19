#import "Movie+Related+Model.h"
@implementation Movie_Related_Model
+ (Movie_Related_Model *)init:(NSDictionary *)data {
    Movie_Related_Model *movie_related_model = [[Movie_Related_Model alloc] init];
    if(data == nil) {
        return movie_related_model;
    }
    movie_related_model.movie_related_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Movie_Related_Model *movie_related = [Movie_Related_Model initObject:each];
        [movie_related_model.movie_related_list addObject:movie_related];
    }
    return movie_related_model;
}
+ (Movie_Related_Model *)initObject:(NSDictionary *)data {
    Movie_Related_Model *movie_related_model = [[Movie_Related_Model alloc] init];
    if(data == nil) {
        return movie_related_model;
    }
    movie_related_model.id = [[data objectForKey:@"id"] longValue];
    movie_related_model.video_id = [[data objectForKey:@"video_id"] longValue];
    movie_related_model.title = [data objectForKey:@"title"];
    movie_related_model.images = [data objectForKey:@"images"];
    return movie_related_model;
}
@end