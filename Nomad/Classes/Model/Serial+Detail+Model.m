#import "Serial+Detail+Model.h"
#import "Serial+Episode+Model.h"
@implementation Serial_Detail_Model
+ (Serial_Detail_Model *)init:(NSDictionary *)data {
    Serial_Detail_Model *serial_detail_model = [[Serial_Detail_Model alloc] init];
    if(data == nil) {
        return serial_detail_model;
    }
    serial_detail_model.id = [[data objectForKey:@"id"] longValue];
    serial_detail_model.video_id = [[data objectForKey:@"video_id"] longValue];
    serial_detail_model.serial_id = [[data objectForKey:@"serial_id"] longValue];
    serial_detail_model.url_type_id = [[data objectForKey:@"url_type_id"] intValue];
    if([data objectForKey:@"video_url"] != nil) {
        serial_detail_model.video_url = [data objectForKey:@"video_url"];
    }
    serial_detail_model.title = [data objectForKey:@"title"];
    serial_detail_model.desc = [data objectForKey:@"description"];
    serial_detail_model.season = [[data objectForKey:@"season"] intValue];
    serial_detail_model.episode = [[data objectForKey:@"episode"] intValue];
    serial_detail_model.play_count = [[data objectForKey:@"play_count"] longValue];
    serial_detail_model.view_count = [[data objectForKey:@"view_count"] longValue];
    serial_detail_model.images = [data objectForKey:@"images"];
    Price_Model *price_model = [Price_Model init:[data objectForKey:@"prices"]];
    serial_detail_model.prices = price_model.price_list;
    serial_detail_model.show_title = [data objectForKey:@"show_title"];
    serial_detail_model.total_likes = [[data objectForKey:@"total_likes"] longValue];
    if([data objectForKey:@"episodes"] != nil) {
        Serial_Episode_Model *serial_episode_model = [Serial_Episode_Model init:[data objectForKey:@"episodes"]];
        serial_detail_model.episodes = serial_episode_model.serial_episode_list;
    }
    Member_Comment_Model *movie_comment_model = [Member_Comment_Model init:[data objectForKey:@"comments"]];
    serial_detail_model.comments = movie_comment_model.member_comment_list;
    Serial_Related_Model *serial_related_model = [Serial_Related_Model init:[data objectForKey:@"relateds"]];
    serial_detail_model.relateds = serial_related_model.serial_related_list;
    if([data objectForKey:@"videos"] != nil) {
        serial_detail_model.videos = [data objectForKey:@"videos"];
    }
    if([data objectForKey:@"log_on_member"] != nil) {
        serial_detail_model.log_on_member = [Member_Model init:[data objectForKey:@"log_on_member"]];
    }
    return serial_detail_model;
}
+ (Serial_Detail_Model *)initDetail:(NSDictionary *)data {
    Serial_Detail_Model *serial_detail_model = [[Serial_Detail_Model alloc] init];
    if(data == nil) {
        return serial_detail_model;
    }
    Price_Model *price_model = [Price_Model init:[data objectForKey:@"prices"]];
    serial_detail_model.prices = price_model.price_list;
    Member_Comment_Model *movie_comment_model = [Member_Comment_Model init:[data objectForKey:@"comments"]];
    serial_detail_model.comments = movie_comment_model.member_comment_list;
    if([data objectForKey:@"videos"] != nil) {
        serial_detail_model.videos = [data objectForKey:@"videos"];
    }
    if([data objectForKey:@"log_on_member"] != nil) {
        serial_detail_model.log_on_member = [Member_Model init:[data objectForKey:@"log_on_member"]];
    }
    return serial_detail_model;
}
+ (Serial_Detail_Model *)combine:(Serial_Detail_Model *)source
                            With:(Serial_Detail_Model *)other {
    Serial_Detail_Model *serial_detail_model = source;
    serial_detail_model.prices = other.prices;
    serial_detail_model.comments = other.comments;
    serial_detail_model.videos = other.videos;
    serial_detail_model.log_on_member = other.log_on_member;
    return serial_detail_model;
}
@end