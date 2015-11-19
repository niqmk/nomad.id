#import "Movie+Detail+Model.h"
@implementation Movie_Detail_Model
+ (Movie_Detail_Model *)init:(NSDictionary *)data {
    Movie_Detail_Model *movie_detail_model = [[Movie_Detail_Model alloc] init];
    if(data == nil) {
        return movie_detail_model;
    }
    movie_detail_model.id = [[data objectForKey:@"id"] longValue];
    movie_detail_model.video_id = [[data objectForKey:@"video_id"] longValue];
    movie_detail_model.title = [data objectForKey:@"title"];
    movie_detail_model.desc = [data objectForKey:@"description"];
    movie_detail_model.release_date = [data objectForKey:@"release_date"];
    movie_detail_model.languages = [data objectForKey:@"languages"];
    movie_detail_model.subtitles = [data objectForKey:@"subtitles"];
    movie_detail_model.play_count = [[data objectForKey:@"play_count"] longValue];
    movie_detail_model.view_count = [[data objectForKey:@"view_count"] longValue];
    movie_detail_model.run_time_in_minute = [[data objectForKey:@"run_time_in_minute"] longValue];
    movie_detail_model.video_url = [data objectForKey:@"video_url"];
    Price_Model *price_model = [Price_Model init:[data objectForKey:@"prices"]];
    movie_detail_model.prices = price_model.price_list;
    movie_detail_model.images = [data objectForKey:@"images"];
    movie_detail_model.total_likes = [[data objectForKey:@"total_likes"] longValue];
    movie_detail_model.overall_rating = [[data objectForKey:@"overall_rating"] doubleValue];
    Movie_Cast_Model *movie_cast_model = [Movie_Cast_Model init:[data objectForKey:@"casts"]];
    movie_detail_model.casts = movie_cast_model.movie_cast_list;
    Movie_Director_Model *movie_director_model = [Movie_Director_Model init:[data objectForKey:@"directors"]];
    movie_detail_model.directors = movie_director_model.movie_director_list;
    Movie_Genre_Model *movie_genre_model = [Movie_Genre_Model init:[data objectForKey:@"genres"]];
    movie_detail_model.genres = movie_genre_model.movie_genre_list;
    Member_Comment_Model *movie_comment_model = [Member_Comment_Model init:[data objectForKey:@"reviews"]];
    movie_detail_model.reviews = movie_comment_model.member_comment_list;
    Movie_Related_Model *movie_related_model = [Movie_Related_Model init:[data objectForKey:@"relateds"]];
    movie_detail_model.relateds = movie_related_model.movie_related_list;
    if([data objectForKey:@"videos"] != nil) {
        movie_detail_model.videos = [data objectForKey:@"videos"];
    }
    if([data objectForKey:@"log_on_member"] != nil) {
        movie_detail_model.log_on_member = [Member_Model init:[data objectForKey:@"log_on_member"]];
    }
    return movie_detail_model;
}
@end