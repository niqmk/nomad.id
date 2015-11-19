#import "SQL+Controller.h"
#import "User+Session.h"
#import "Menu+Session.h"
#import "Home+Session.h"
@interface Global_Variables : NSObject {
@public
    SQL_Controller *sql_controller;
    User_Session *user_session;
    Menu_Session *menu_session;
    Home_Session *home_session;
    NSMutableDictionary *app_plist;
    NSMutableDictionary *menu_plist;
    NSMutableDictionary *layout_plist;
}
+ (Global_Variables *)instance;
- (void)initial;
@end