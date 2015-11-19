#import "Global+Variables.h"
static Global_Variables *instance = nil;
@implementation Global_Variables
+ (Global_Variables *)instance {
    if(instance == nil) {
        instance = [[[self class] alloc] init];
    }
    return instance;
}
- (void)initial {
    sql_controller = [[SQL_Controller alloc] init];
    [sql_controller openDatabase];
    user_session = [[User_Session alloc] init];
    menu_session = [[Menu_Session alloc] init];
    home_session = [[Home_Session alloc] init];
    app_plist = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"App" ofType:@"plist"]];
    menu_plist = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"]];
    layout_plist = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Layout" ofType:@"plist"]];
}
@end