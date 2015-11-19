#import "Menu+Session.h"
#import "Category+Model.h"
@implementation Menu_Session
NSString *const menu_key = @"NoMAD_Menu";
- (void)saveMenu:(NSMutableArray *)menu_list {
    if(![self isSession]) {
        Category_Model *category_model = [Category_Model init:menu_list];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:category_model];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:menu_key];
        [defaults synchronize];
    }
}
- (void)deleteMenu {
    if([self isSession]) {
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:menu_key];
        [defaults synchronize];
    }
}
- (bool)isSession {
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:menu_key] == nil) {
        return NO;
    }else {
        return YES;
    }
}
- (NSMutableArray *)getMenuList {
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:menu_key];
    Category_Model *category_model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return category_model.category_list;
}
@end