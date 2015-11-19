#import "Movie+Genre+Model.h"
@implementation Movie_Genre_Model
+ (Movie_Genre_Model *)init:(NSDictionary *)data {
    Movie_Genre_Model *movie_genre_model = [[Movie_Genre_Model alloc] init];
    if(data == nil) {
        return movie_genre_model;
    }
    movie_genre_model.movie_genre_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Movie_Genre_Model *movie_genre = [Movie_Genre_Model initObject:each];
        [movie_genre_model.movie_genre_list addObject:movie_genre];
    }
    return movie_genre_model;
}
+ (Movie_Genre_Model *)initObject:(NSDictionary *)data {
    Movie_Genre_Model *movie_genre_model = [[Movie_Genre_Model alloc] init];
    if(data == nil) {
        return movie_genre_model;
    }
    movie_genre_model.name = [data objectForKey:@"name"];
    return movie_genre_model;
}
@end