@interface Home_Session : NSObject
- (void)set:(NSString *)url
       List:(NSMutableArray *)list;
- (bool)isCached:(NSString *)url;
- (NSMutableArray *)get:(NSString *)url;
@end