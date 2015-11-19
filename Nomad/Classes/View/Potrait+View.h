@protocol Potrait_View_Delegate <NSObject>
@required
- (void)didPotraitViewSelected:(id)model;
@end
@interface Potrait_View : UIView {
@private
    id data;
}
@property (nonatomic, assign) id<Potrait_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIImageView *image;
- (void)set:(id)model;
@end