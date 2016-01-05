//
//  CovertPhotoMethod.h
//  selectPIC
//
//  Created by colorful-ios on 16/1/5.
//  Copyright © 2016年 7Color. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReturnIMGBlock)(NSArray *dataArray);

@interface CovertPhotoMethod : NSObject

@property (nonatomic,copy)ReturnIMGBlock returnIMGBlock;

- (void)covertPhotoMethodWithModelArray:(NSArray*)array;
- (void)covertPhotoMethodWithModelArray:(NSArray*)array WithReturnBlock:(ReturnIMGBlock)returnBlock;


@end
