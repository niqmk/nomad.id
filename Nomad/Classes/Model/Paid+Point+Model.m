#import "Paid+Point+Model.h"
@implementation Paid_Point_Model
+ (Paid_Point_Model *)init:(NSDictionary *)data {
    Paid_Point_Model *paid_point_model = [[Paid_Point_Model alloc] init];
    if(data == nil) {
        return paid_point_model;
    }
    paid_point_model.paid_point_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Paid_Point_Model *paid_point = [Paid_Point_Model initObject:each];
        [paid_point_model.paid_point_list addObject:paid_point];
    }
    return paid_point_model;
}
+ (Paid_Point_Model *)initObject:(NSDictionary *)data {
    Paid_Point_Model *paid_point_model = [[Paid_Point_Model alloc] init];
    if(data == nil) {
        return paid_point_model;
    }
    paid_point_model.id = [[data objectForKey:@"id"] longValue];
    paid_point_model.price_in_idr = [[data objectForKey:@"price_in_idr"] longValue];
    paid_point_model.point = [[data objectForKey:@"point"] longValue];
    return paid_point_model;
}
@end