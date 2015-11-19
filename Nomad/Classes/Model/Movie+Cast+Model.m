#import "Movie+Cast+Model.h"
@implementation Movie_Cast_Model
+ (Movie_Cast_Model *)init:(NSDictionary *)data {
    Movie_Cast_Model *movie_cast_model = [[Movie_Cast_Model alloc] init];
    if(data == nil) {
        return movie_cast_model;
    }
    movie_cast_model.movie_cast_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Movie_Cast_Model *movie_cast = [Movie_Cast_Model initObject:each];
        [movie_cast_model.movie_cast_list addObject:movie_cast];
    }
    return movie_cast_model;
}
+ (Movie_Cast_Model *)initObject:(NSDictionary *)data {
    Movie_Cast_Model *movie_cast_model = [[Movie_Cast_Model alloc] init];
    if(data == nil) {
        return movie_cast_model;
    }
    movie_cast_model.id = [[data objectForKey:@"id"] longValue];
    movie_cast_model.name = [data objectForKey:@"name"];
    movie_cast_model.desc = [data objectForKey:@"description"];
    return movie_cast_model;
}
@end