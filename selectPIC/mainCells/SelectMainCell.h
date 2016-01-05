//
//  SelectMainCell.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectMainCell : UITableViewCell
@property (nonatomic,strong)UIImageView *headIMGV;
@property (nonatomic,strong)UILabel *titleLabel;


- (void)configCellWithHeadIMG:(UIImage*)IMG andTitle:(NSString*)TitleName andIMGCount:(NSString*)countStr;
@end
