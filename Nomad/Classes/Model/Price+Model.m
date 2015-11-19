#import "Price+Model.h"
@implementation Price_Model
+ (Price_Model *)init:(NSDictionary *)data {
    Price_Model *price_model = [[Price_Model alloc] init];
    if(data == nil) {
        return price_model;
    }
    price_model.price_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Price_Model *price = [Price_Model initObject:each];
        [price_model.price_list addObject:price];
    }
    return price_model;
}
+ (Price_Model *)initObject:(NSDictionary *)data {
    Price_Model *price_model = [[Price_Model alloc] init];
    if(data == nil) {
        return price_model;
    }
    price_model.id = [[data objectForKey:@"id"] longValue];
    price_model.price = [[data objectForKey:@"price"] longValue];
    price_model.expiry_days = [[data objectForKey:@"expiry_days"] longValue];
    return price_model;
}
@end