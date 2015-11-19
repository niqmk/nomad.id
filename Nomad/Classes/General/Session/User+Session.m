#import "User+Session.h"
@implementation User_Session
- (void)openSession:(Login_Model *)login_model {
    User_Model *user_model = [User_Model init:login_model];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user_model];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:session_user];
    [defaults synchronize];
}
- (void)closeSession {
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:session_user];
    [defaults synchronize];
}
- (bool)isSession {
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:session_user] == nil) {
        return NO;
    }else {
        return YES;
    }
}
- (User_Model *)getUser {
    User_Model *user_model = [self getFromSession:session_user];
    return user_model;
}
- (User_Model *)getFromSession:(NSString *)id {
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:id];
    User_Model *user_model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user_model;
}
- (void)updatePoint:(long)total_points {
    User_Model *user_model = [self getFromSession:session_user];
    if(user_model.total_points == total_points) {
        return;
    }
    user_model.total_points = total_points;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user_model];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:session_user];
    [defaults synchronize];
}
@end