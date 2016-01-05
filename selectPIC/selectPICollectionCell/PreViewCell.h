//
//  PreViewCell.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/25.
//  Copyright © 2015年 7Color. All rights reserved.
//
typedef void(^HiddenNAVBlock)();

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PreViewCell : UICollectionViewCell

@property (nonatomic,strong)HiddenNAVBlock hiddenNAVBlock;

- (void)configWith:(PHAsset*)phasset;

@end
