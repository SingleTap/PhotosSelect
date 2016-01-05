//
//  selectMainVC.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/23.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnArrayBlock)(NSArray *array);

@interface selectMainVC : UIViewController
@property (nonatomic,copy)ReturnArrayBlock returnArrayBlock;

@property (nonatomic,strong)NSArray *selecIMG;

+ (selectMainVC *)shareSelectMainVC;
@end
