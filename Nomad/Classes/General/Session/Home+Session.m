#import "Home+Session.h"
@implementation Home_Session
- (void)set:(NSString *)url
       List:(NSMutableArray *)list {
    if(![self isCached:url]) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:list];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:url];
        [defaults synchronize];
    }
}
- (bool)isCached:(NSString *)url {
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:url] == nil) {
        return NO;
    }else {
        return YES;
    }
}
- (NSMutableArray *)get:(NSString *)url {
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:url];
    NSMutableArray *list = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return list;
}
@end