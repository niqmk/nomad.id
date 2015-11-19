#import "Free+Point+Model.h"
@implementation Free_Point_Model
+ (Free_Point_Model *)init:(NSDictionary *)data {
    Free_Point_Model *free_point_model = [[Free_Point_Model alloc] init];
    if(data == nil) {
        return free_point_model;
    }
    free_point_model.free_point_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Free_Point_Model *free_point = [Free_Point_Model initObject:each];
        [free_point_model.free_point_list addObject:free_point];
    }
    return free_point_model;
}
+ (Free_Point_Model *)initObject:(NSDictionary *)data {
    Free_Point_Model *free_point_model = [[Free_Point_Model alloc] init];
    if(data == nil) {
        return free_point_model;
    }
    free_point_model.id = [[data objectForKey:@"id"] longValue];
    free_point_model.name = [data objectForKey:@"name"];
    free_point_model.point = [[data objectForKey:@"point"] longValue];
    return free_point_model;
}
@end