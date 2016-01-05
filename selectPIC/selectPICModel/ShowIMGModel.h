//
//  ShowIMGModel.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Photos/Photos.h>

@interface ShowIMGModel : NSObject

@property (nonatomic,strong)PHAsset *phAsset;

@property (nonatomic,assign)BOOL    selected;

@property (nonatomic,strong)UIImage *tempIMG;

- (NSMutableArray*)createWithPHFetchResult:(PHFetchResult*)result WithSelectArray:(NSArray*)selectArray;

+ (NSMutableArray*)modelWithPHFetchResult:(PHFetchResult*)result WithSelectArray:(NSArray*)selectArray;


@end
