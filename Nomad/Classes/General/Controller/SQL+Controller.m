#import "SQL+Controller.h"
#import "Config.h"
@implementation SQL_Controller
- (void)openDatabase {
    [self copyWhenNotExists];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:sql_file];
    if(sqlite3_open([path UTF8String], &connection) == SQLITE_OK) {}
}
- (void)closeDatabase {
    sqlite3_close(connection);
}
- (void)copyWhenNotExists {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:sql_file];
#ifndef TARGET_IPHONE_SIMULATOR
    BOOL success = [fileManager fileExistsAtPath:path];
    if(success) return;
#else
    //NSLog(@"%@", path);
#endif
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:sql_file];
    NSError *error;
    [fileManager copyItemAtPath:defaultDBPath toPath:path error:&error];
}
@end