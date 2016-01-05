//
//  ShowIMGCollectionCell.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "ShowIMGCollectionCell.h"

#define WIDTH_PIC       self.bounds.size.width
#define HEIGHT_PIC      self.bounds.size.height

@interface ShowIMGCollectionCell ()
@property (nonatomic,strong)UIButton       *showIMGBtn;
@property (nonatomic,strong)UIButton        *selectedBtn;

@end

@implementation ShowIMGCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{

    self.showIMGBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showIMGBtn.frame = CGRectMake(3, 3, WIDTH_PIC-6, WIDTH_PIC-6);
    [self.showIMGBtn addTarget:self action:@selector(showBigIMGClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.showIMGBtn];
    
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectedBtn.frame = CGRectMake(WIDTH_PIC-36, 6,30,30);

    [self.selectedBtn setImage:[UIImage imageNamed:@"picSelect_UNSelectPIC"] forState:UIControlStateNormal];
    [self.selectedBtn setImage:[UIImage imageNamed:@"picSelect_SelectPIC"] forState:UIControlStateSelected];
    self.selectedBtn.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
//    self.selectedBtn.imageView.contentMode = UIViewContentModeCenter;
    [self.selectedBtn addTarget:self action:@selector(imgSelectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectedBtn];
    
    
    
    
}
- (void)showBigIMGClick{
    NSLog(@"查看大图");
    self.previewBlock();
}
-(void)imgSelectClick{
    if (self.selectedBtn.selected) {
        self.selectedBtn.selected = NO;
        self.selectedBlock(NO);
    }else{
        self.selectedBtn.selected = YES;
        
        [UIView animateWithDuration:0.1 animations:^{
            self.selectedBtn.frame = CGRectMake(WIDTH_PIC-38, 4, 34, 34);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.selectedBtn.frame = CGRectMake(WIDTH_PIC-36, 6, 30, 30);
            }];
        }];
        self.selectedBlock(YES);
    }
}

- (void)configWithModel:(ShowIMGModel *)model{
 
        // 在资源的集合中获取第一个集合，并获取其中的图片
        PHImageManager *imageManager = [PHImageManager defaultManager];
        [imageManager requestImageForAsset:model.phAsset
                                    targetSize:CGSizeMake(200, 200)
                                   contentMode:PHImageContentModeAspectFill
                                       options:nil
                                 resultHandler:^(UIImage *result, NSDictionary *info) {
                                     [self.showIMGBtn setBackgroundImage:result forState:UIControlStateNormal];
                                 }];

        if (model.selected) {
        self.selectedBtn.selected = YES;
    }else{
        self.selectedBtn.selected = NO;
    }
}
@end
