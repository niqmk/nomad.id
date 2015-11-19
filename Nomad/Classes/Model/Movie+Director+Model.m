#import "Movie+Director+Model.h"
@implementation Movie_Director_Model
+ (Movie_Director_Model *)init:(NSDictionary *)data {
    Movie_Director_Model *movie_director_model = [[Movie_Director_Model alloc] init];
    if(data == nil) {
        return movie_director_model;
    }
    movie_director_model.movie_director_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Movie_Director_Model *movie_director = [Movie_Director_Model initObject:each];
        [movie_director_model.movie_director_list addObject:movie_director];
    }
    return movie_director_model;
}
+ (Movie_Director_Model *)initObject:(NSDictionary *)data {
    Movie_Director_Model *movie_director_model = [[Movie_Director_Model alloc] init];
    if(data == nil) {
        return movie_director_model;
    }
    movie_director_model.id = [[data objectForKey:@"id"] longValue];
    movie_director_model.name = [data objectForKey:@"name"];
    return movie_director_model;
}
@end