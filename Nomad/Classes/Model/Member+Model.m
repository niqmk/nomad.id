#import "Member+Model.h"
@implementation Member_Purchase_Model
+ (Member_Purchase_Model *)init:(NSDictionary *)data {
    Member_Purchase_Model *member_purchase_model = [[Member_Purchase_Model alloc] init];
    if(data == nil) {
        return member_purchase_model;
    }
    member_purchase_model.is_purchased = [[data objectForKey:@"is_purchased"] boolValue];
    member_purchase_model.expired_at = [[data objectForKey:@"expired_at"] longValue];
    return member_purchase_model;
}
@end
@implementation Member_Comment_Model
+ (Member_Comment_Model *)init:(NSDictionary *)data {
    Member_Comment_Model *member_comment_model = [[Member_Comment_Model alloc] init];
    if(data == nil) {
        return member_comment_model;
    }
    member_comment_model.member_comment_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Member_Comment_Model *member_comment = [Member_Comment_Model initObject:each];
        [member_comment_model.member_comment_list addObject:member_comment];
    }
    return member_comment_model;
}
+ (Member_Comment_Model *)initObject:(NSDictionary *)data {
    Member_Comment_Model *member_comment_model = [[Member_Comment_Model alloc] init];
    if(data == nil) {
        return member_comment_model;
    }
    member_comment_model.id = [[data objectForKey:@"id"] longValue];
    if([data objectForKey:@"movie_id"] != nil) {
        member_comment_model.movie_id = [[data objectForKey:@"movie_id"] longValue];
    }
    if([data objectForKey:@"serial_id"] != nil) {
        member_comment_model.serial_id = [[data objectForKey:@"serial_id"] longValue];
    }
    member_comment_model.desc = [data objectForKey:@"description"];
    member_comment_model.rate = [[data objectForKey:@"rate"] longValue];
    member_comment_model.created_at = [[data objectForKey:@"created_at"] longValue];
    member_comment_model.updated_at = [[data objectForKey:@"upated_at"] longValue];
    member_comment_model.member_username = [data objectForKey:@"member_username"];
    return member_comment_model;
}
@end
@implementation Member_Model
+ (Member_Model *)init:(NSDictionary *)data {
    Member_Model *member_model = [[Member_Model alloc] init];
    if(data == nil) {
        return member_model;
    }
    Member_Purchase_Model *member_purchase_model = [Member_Purchase_Model init:[data objectForKey:@"purchase"]];
    member_model.purchase = member_purchase_model;
    if([data objectForKey:@"comment"] != nil) {
        Member_Comment_Model *member_comment_model = [Member_Comment_Model initObject:[data objectForKey:@"comment"]];
        member_model.comment = member_comment_model;
    }
    member_model.is_liked = [[data objectForKey:@"is_liked"] boolValue];
    member_model.is_watched = [[data objectForKey:@"is_watched"] boolValue];
    member_model.is_watchlisted = [[data objectForKey:@"is_watchlisted"] boolValue];
    return member_model;
}
@end