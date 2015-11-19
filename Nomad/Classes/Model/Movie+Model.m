#import "Movie+Model.h"
@implementation Movie_Model
+ (Movie_Model *)init:(NSDictionary *)data {
    Movie_Model *movie_model = [[Movie_Model alloc] init];
    if(data == nil) {
        return movie_model;
    }
    movie_model.movie_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Movie_Model *movie = [Movie_Model initObject:each];
        [movie_model.movie_list addObject:movie];
    }
    return movie_model;
}
+ (Movie_Model *)initRelated:(Movie_Related_Model *)movie_related_model {
    Movie_Model *movie_model = [[Movie_Model alloc] init];
    if(movie_related_model == nil) {
        return movie_model;
    }
    movie_model.id = movie_related_model.id;
    movie_model.video_id = movie_related_model.video_id;
    movie_model.title = movie_related_model.title;
    movie_model.images = movie_related_model.images;
    return movie_model;
}
+ (Movie_Model *)initSearched:(Search_Model *)search_model {
    Movie_Model *movie_model = [[Movie_Model alloc] init];
    if(search_model == nil) {
        return movie_model;
    }
    movie_model.id = search_model.id;
    movie_model.video_id = search_model.video_id;
    movie_model.title = search_model.title;
    movie_model.images = nil;
    return movie_model;
}
+ (Movie_Model *)initObject:(NSDictionary *)data {
    Movie_Model *movie_model = [[Movie_Model alloc] init];
    if(data == nil) {
        return movie_model;
    }
    movie_model.id = [[data objectForKey:@"id"] longValue];
    movie_model.video_id = [[data objectForKey:@"video_id"] longValue];
    movie_model.title = [data objectForKey:@"title"];
    movie_model.images = [data valueForKey:@"images"];
    return movie_model;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.id = [decoder decodeIntegerForKey:@"id"];
        self.video_id = [decoder decodeIntegerForKey:@"video_id"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.images = [decoder decodeObjectForKey:@"images"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:self.id forKey:@"id"];
    [encoder encodeInteger:self.video_id forKey:@"video_id"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.images forKey:@"images"];
}
@end