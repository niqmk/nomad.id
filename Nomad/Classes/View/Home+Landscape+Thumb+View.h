@protocol Home_Landscape_Thumb_View_Delegate <NSObject>
@optional
- (void)didHomeLandscapeThumbViewSelected:(id)model;
@end
@interface Home_Landscape_Thumb_View : UIView {
@private
    id data;
}
@property (nonatomic, assign) id<Home_Landscape_Thumb_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIImageView *image;
- (void)set:(id)model;
@end