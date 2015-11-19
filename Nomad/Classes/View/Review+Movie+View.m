#import "Review+Movie+View.h"
@implementation Review_Movie_View {
@private
    NSMutableArray *review_list;
    Movie_Detail_Model *movie_detail_data;
    float super_width;
    NSMutableArray *height_list;
}
- (id)init {
    Review_Movie_View *review_movie_view = [[[NSBundle mainBundle] loadNibNamed:@"Review+Movie+View" owner:nil options:nil] objectAtIndex:0];
    if([review_movie_view isKindOfClass:[Review_Movie_View class]]) {
        return review_movie_view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    return [[height_list objectAtIndex:row] floatValue];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [review_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *review_list_id = @"ReviewMovieListID";
    Review_Movie_Cell *cell = (Review_Movie_Cell *)[tableView dequeueReusableCellWithIdentifier:review_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Review+Movie+Cell" owner:self options:nil];
        cell = self.review_movie_cell;
    }
    bool user_rated = false;
    if(row == 0) {
        if(movie_detail_data.log_on_member != nil) {
            if(movie_detail_data.log_on_member.comment != nil) {
                user_rated = true;
            }
        }
    }
    Member_Comment_Model *member_comment_model = [review_list objectAtIndex:row];
    [Global_Controller setSelectedCell:cell Color:[cell set:member_comment_model UserRated:user_rated]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [self setSelected:row];
}
- (IBAction)doWriteReview:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didReviewMovieViewWriteReview)]) {
            [self.delegate didReviewMovieViewWriteReview];
        }
    }
}
- (void)show:(Movie_Detail_Model *)movie_detail_model
       Width:(float)width {
    [self.btn_write_review rounded];
    [self.btn_write_review stroke];
    movie_detail_data = movie_detail_model;
    review_list = [[NSMutableArray alloc] initWithArray:movie_detail_data.reviews];
    if(movie_detail_data.log_on_member != nil) {
        if(movie_detail_data.log_on_member.comment != nil) {
            [review_list insertObject:movie_detail_data.log_on_member.comment
                              atIndex:0];
            [self.btn_write_review setHidden:true];
            self.lst_review.frame = self.bounds;
        }
    }
    super_width = width;
    [self setLayout];
}
- (void)setLayout {
    [self.lst_review setBackgroundColor:[UIColor whiteColor]];
    if([review_list count] > 0) {
        [self setNoResult:false];
    }
    height_list = [[NSMutableArray alloc] init];
    for(Member_Comment_Model *member_comment_model in review_list) {
        [self.lbl_sample setText:member_comment_model.desc];
        [self.lbl_sample sizeToFit];
        [height_list addObject:[NSNumber numberWithFloat:self.lbl_sample.frame.size.height + 70]];
    }
}
- (void)setSelected:(NSInteger)index {
    Member_Comment_Model *member_comment_model = [review_list objectAtIndex:index];
    if(movie_detail_data.log_on_member != nil) {
        if(movie_detail_data.log_on_member.comment != nil) {
            if(movie_detail_data.log_on_member.comment == member_comment_model) {
                if(self.delegate != nil) {
                    if([(NSObject *)self.delegate respondsToSelector:@selector(didReviewMovieViewEditReview:)]) {
                        [self.delegate didReviewMovieViewEditReview:member_comment_model];
                    }
                }
            }
        }
    }
}
- (void)setNoResult:(bool)show {
    [self.vw_no_result setHidden:!show];
}
@end