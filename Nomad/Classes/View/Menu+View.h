@protocol Menu_View_Delegate <NSObject>
@required
- (void)didMenuViewSelected:(NSString *)key;
@end
@interface Menu_View : UIView {
@private
    NSString *key_view;
}
@property (nonatomic, assign) id<Menu_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *btn_menu;
- (void)set:(NSString *)key;
- (BOOL)isSelected;
- (void)setSelected:(bool)selected;
@end