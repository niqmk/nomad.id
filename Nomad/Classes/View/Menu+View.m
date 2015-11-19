#import "Menu+View.h"
@implementation Menu_View
- (id)init {
    Menu_View *menu_view = [[[NSBundle mainBundle] loadNibNamed:@"Menu+View" owner:nil options:nil] objectAtIndex:0];
    if([menu_view isKindOfClass:[Menu_View class]]) {
        return menu_view;
    }else {
        return nil;
    }
}
- (IBAction)doSelect:(id)sender {
    [self.btn_menu setSelected:true];
    if(self.delegate != nil) {
        [self.delegate didMenuViewSelected:key_view];
    }
}
- (BOOL)isSelected {
    return [self.btn_menu isSelected];
}
- (void)setSelected:(bool)selected {
    [self.btn_menu setSelected:selected];
}
- (void)set:(NSString *)key {
    key_view = key;
    [self.btn_menu setTitle:key forState:UIControlStateNormal];
    CGRect bounds = self.btn_menu.bounds;
    [self.btn_menu sizeToFit];
    if(self.btn_menu.frame.size.width < bounds.size.width) {
        self.btn_menu.frame = CGRectMake(0, 0, bounds.size.width, self.frame.size.height);
    }else {
        self.btn_menu.frame = CGRectMake(0, 0, self.btn_menu.frame.size.width, self.frame.size.height);
    }
    self.frame = self.btn_menu.bounds;
}
@end