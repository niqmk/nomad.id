@protocol Home_Menu_View_Delegate
@optional
- (void)didHomeMenuViewPotraitSelected:(id)model;
- (void)didHomeMenuViewLandscapeSelected:(id)model;
@end
@interface Home_Menu_View : UIView
@property (nonatomic, assign) id<Home_Menu_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
- (void)show:(NSString *)key
  CategoryID:(long)category_id
   VideoType:(VideoType)video_type
       Width:(float)width;
@end