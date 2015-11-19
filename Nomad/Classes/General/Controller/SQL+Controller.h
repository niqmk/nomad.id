#import <sqlite3.h>
@interface SQL_Controller : NSObject {
@public
    sqlite3 *connection;
}
- (void)openDatabase;
- (void)closeDatabase;
@end