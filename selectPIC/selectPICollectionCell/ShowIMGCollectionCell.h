//
//  ShowIMGCollectionCell.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ShowIMGModel.h"

typedef void(^SelectedBlock)(BOOL select);
typedef void(^PreViewBlock)();


@interface ShowIMGCollectionCell : UICollectionViewCell

@property (nonatomic,strong)SelectedBlock selectedBlock;
@property (nonatomic,strong)PreViewBlock previewBlock;

- (void)configWithModel:(ShowIMGModel*)model;
@end
