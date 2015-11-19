@interface Menu_Session : NSObject
- (void)saveMenu:(NSMutableArray *)menu_list;
- (void)deleteMenu;
- (bool)isSession;
- (NSMutableArray *)getMenuList;
@end