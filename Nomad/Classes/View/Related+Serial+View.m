#import "Related+Serial+View.h"
#import "Potrait+View.h"
@interface Related_Serial_View() <Potrait_View_Delegate>
@end
@implementation Related_Serial_View {
@private
    Serial_Detail_Model *serial_detail_data;
    float super_width;
}
- (id)init {
    Related_Serial_View *related_serial_view = [[[NSBundle mainBundle] loadNibNamed:@"Related+Serial+View" owner:nil options:nil] objectAtIndex:0];
    if([related_serial_view isKindOfClass:[Related_Serial_View class]]) {
        return related_serial_view;
    }else {
        return nil;
    }
}
- (void)didPotraitViewSelected:(id)model {
    if(self.delegate != nil) {
        [self.delegate didRelatedSerialViewSelected:model];
    }
}
- (void)show:(Serial_Detail_Model *)serial_detail_model
       Width:(float)width {
    super_width = width;
    serial_detail_data = serial_detail_model;
    [self setLayout];
}
- (void)setLayout {
    [self setScrollView];
    int counter = 0;
    float y = 2;
    for(Serial_Related_Model *each in serial_detail_data.relateds) {
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
