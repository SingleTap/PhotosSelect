//
//  SelectMainCell.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "SelectMainCell.h"

@interface SelectMainCell ()


@end

@implementation SelectMainCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}

- (void)makeUI{
    self.headIMGV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.contentView addSubview:self.headIMGV];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, self.contentView.frame.size.width - 80, 50)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    
}

- (void)configCellWithHeadIMG:(UIImage *)IMG andTitle:(NSString *)TitleName andIMGCount:(NSString *)countStr{
    self.headIMGV.image = IMG;

    NSString *str = [NSString stringWithFormat:@"%@ (%@)",TitleName,countStr];
    
    self.titleLabel.text = str;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(TitleName.length+1, countStr.length+2)];
    self.titleLabel.attributedText = attributedStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
