#import "Related+Movie+View.h"
#import "Potrait+View.h"
@interface Related_Movie_View() <Potrait_View_Delegate>
@end
@implementation Related_Movie_View {
@private
    Movie_Detail_Model *movie_detail_data;
    float super_width;
}
- (id)init {
    Related_Movie_View *related_movie_view = [[[NSBundle mainBundle] loadNibNamed:@"Related+Movie+View" owner:nil options:nil] objectAtIndex:0];
    if([related_movie_view isKindOfClass:[Related_Movie_View class]]) {
        return related_movie_view;
    }else {
        return nil;
    }
}
- (void)didPotraitViewSelected:(id)model {
    if(self.delegate != nil) {
        [self.delegate didRelatedMovieViewSelected:model];
    }
}
- (void)show:(Movie_Detail_Model *)movie_detail_model
       Width:(float)width {
    super_width = width;
    movie_detail_data = movie_detail_model;
    [self setLayout];
}
- (void)setLayout {
    [self setScrollView];
    int counter = 0;
    float y = 2;
    for(Movie_Related_Model *each in movie_detail_data.relateds) {
        counter++;
        Potrait_View *potrait_view = [[Potrait_View alloc] init];
        potrait_view.delegate = self;
        float width = (super_width / 2) - 4;
        float scale = width / potrait_view.frame.size.width;
        float height = potrait_view.frame.size.height * scale;
        if(counter % 2 == 0) {
            potrait_view.frame = CGRectMake(width + 4, y, width, height);
            y += height + 2;
        }else {
            potrait_view.frame = CGRectMake(2, y, width, height);
        }
        [potrait_view set:each];
        [self.scv_main addSubview:potrait_view];
    }
    self.scv_main.contentSize = CGSizeMake(super_width, y);
}
- (void)setScrollView {
    float scale = super_width / self.scv_main.frame.size.width;
    float height = self.scv_main.frame.size.height * scale;
    self.scv_main.frame = CGRectMake(0, 0, super_width, height - 10);
}
@end
