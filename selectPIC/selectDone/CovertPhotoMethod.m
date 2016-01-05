//
//  CovertPhotoMethod.m
//  selectPIC
//
//  Created by colorful-ios on 16/1/5.
//  Copyright © 2016年 7Color. All rights reserved.
//

#import "CovertPhotoMethod.h"
#import "ShowIMGModel.h"

@implementation CovertPhotoMethod

- (void)covertPhotoMethodWithModelArray:(NSArray *)array{
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:0];
    
    for (ShowIMGModel *model in array) {
        
        __block UIImage *tempIMG = nil;
        
        PHImageManager *imageManager = [PHImageManager defaultManager];
        [imageManager requestImageForAsset:model.phAsset
                                targetSize:CGSizeMake(50, 50)
                               contentMode:PHImageContentModeDefault
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 tempIMG = result;
                                 [mutableArray addObject:tempIMG];
                             }];
    }
    
    if (array.count==mutableArray.count) {
        self.returnIMGBlock(mutableArray);
    }

}

- (void)covertPhotoMethodWithModelArray:(NSArray *)array WithReturnBlock:(ReturnIMGBlock)returnBlock{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:0];
    
    for (ShowIMGModel *model in array) {
        
        __block UIImage *tempIMG = nil;
        
        PHImageManager *imageManager = [PHImageManager defaultManager];
        [imageManager requestImageForAsset:model.phAsset
                                targetSize:CGSizeMake(80, 80)
                               contentMode:PHImageContentModeDefault
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 tempIMG = result;
                                 [mutableArray addObject:tempIMG];
                                 if (mutableArray.count==array.count) {
                                     returnBlock(mutableArray);
                                 }
                             }];
    }
    

}

@end
