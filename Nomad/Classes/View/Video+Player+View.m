#import "Video+Player+View.h"
@implementation Video_Player_View
- (id)init {
    Video_Player_View *video_player_view = [[[NSBundle mainBundle] loadNibNamed:@"Video+Player+View" owner:nil options:nil] objectAtIndex:0];
    if([video_player_view isKindOfClass:[Video_Player_View class]]) {
        return video_player_view;
    }else {
        return nil;
    }
}
@end