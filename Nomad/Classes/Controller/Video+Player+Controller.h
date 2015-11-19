@interface Video_Player_Controller : UIViewController
@property (nonatomic, strong) IBOutlet UIView *vw_player;
@property (nonatomic, strong) IBOutlet UIView *vw_command;
@property (nonatomic, strong) IBOutlet UIButton *btn_action;
@property (nonatomic, strong) IBOutlet UISlider *sld_player;
@property (nonatomic, strong) IBOutlet UIButton *btn_back;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *pgb_loading;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                Video:(Video_Player_Model *)video_player_model;
@end