#import "Serial+Episode+Model.h"
#import "Serial+Detail+Model.h"
@implementation Serial_Episode_Model
+ (Serial_Episode_Model *)init:(NSDictionary *)data {
    Serial_Episode_Model *serial_episode_model = [[Serial_Episode_Model alloc] init];
    if(data == nil) {
        return serial_episode_model;
    }
    serial_episode_model.serial_episode_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Serial_Episode_Model *serial_episode = [Serial_Episode_Model initObject:each];
        [serial_episode_model.serial_episode_list addObject:serial_episode];
    }
    return serial_episode_model;
}
+ (Serial_Episode_Model *)initObject:(NSDictionary *)data {
    Serial_Episode_Model *serial_episode_model = [[Serial_Episode_Model alloc] init];
    if(data == nil) {
        return serial_episode_model;
    }
    serial_episode_model.title = [data objectForKey:@"title"];
    serial_episode_model.data = [[NSMutableArray alloc] init];
    NSMutableArray *data_list = [data valueForKey:@"data"];
    for(NSDictionary *each in data_list) {
        Serial_Detail_Model *serial_detail_model = [Serial_Detail_Model init:each];
        [serial_episode_model.data addObject:serial_detail_model];
    }
    return serial_episode_model;
}
@end