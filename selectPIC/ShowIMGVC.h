//
//  ShowIMGVC.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>


@interface ShowIMGVC : UIViewController

@property (nonatomic,strong)PHFetchResult *assetsFetchResult;
@property (nonatomic,strong)NSArray *selectedModel;


@end
