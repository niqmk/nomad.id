#import "Serial+Related+Model.h"
@implementation Serial_Related_Model
+ (Serial_Related_Model *)init:(NSDictionary *)data {
    Serial_Related_Model *serial_related_model = [[Serial_Related_Model alloc] init];
    if(data == nil) {
        return serial_related_model;
    }
    serial_related_model.serial_related_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Serial_Related_Model *serial_related = [Serial_Related_Model initObject:each];
        [serial_related_model.serial_related_list addObject:serial_related];
    }
    return serial_related_model;
}
+ (Serial_Related_Model *)initObject:(NSDictionary *)data {
    Serial_Related_Model *serial_related_model = [[Serial_Related_Model alloc] init];
    if(data == nil) {
        return serial_related_model;
    }
    serial_related_model.id = [[data objectForKey:@"id"] longValue];
    serial_related_model.video_id = [[data objectForKey:@"video_id"] longValue];
    serial_related_model.title = [data objectForKey:@"title"];
    serial_related_model.images = [data objectForKey:@"images"];
    return serial_related_model;
}
@end