#import "Search+Model.h"
@implementation Search_Model
+ (Search_Model *)init:(NSDictionary *)data {
    Search_Model *search_model = [[Search_Model alloc] init];
    if(data == nil) {
        return search_model;
    }
    search_model.search_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Search_Model *search = [Search_Model initObject:each];
        [search_model.search_list addObject:search];
    }
    return search_model;
}
+ (Search_Model *)initObject:(NSDictionary *)data {
    Search_Model *search_model = [[Search_Model alloc] init];
    if(data == nil) {
        return search_model;
    }
    search_model.id = [[data objectForKey:@"id"] longValue];
    search_model.type = [data objectForKey:@"type"];
    search_model.video_type_id = [[data objectForKey:@"video_type_id"] longValue];
    search_model.video_id = [[data objectForKey:@"video_id"] longValue];
    if([data objectForKey:@"serial_id"] != nil) {
        search_model.serial_id = [[data objectForKey:@"serial_id"] longValue];
    }
    search_model.title = [data objectForKey:@"title"];
    return search_model;
}
@end