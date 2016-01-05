//
//  PreViewController.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/25.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ShowIMGModel.h"

typedef void(^SelectBlock)(NSMutableArray*array,ShowIMGModel *model,BOOL selected);

typedef void(^ReturnArrayBlock)(NSArray *array);

@interface PreViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *imgModelArray;

@property (nonatomic,strong)NSMutableArray *selectedArray;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,copy)SelectBlock selectBlock;

@property (nonatomic,copy)ReturnArrayBlock returnArrayBlock;
@end
