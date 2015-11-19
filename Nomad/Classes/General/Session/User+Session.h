#import "User+Model.h"
@interface User_Session : NSObject
- (void)openSession:(Login_Model *)login_model;
- (void)closeSession;
- (bool)isSession;
- (User_Model *)getUser;
- (void)updatePoint:(long)total_points;
@end