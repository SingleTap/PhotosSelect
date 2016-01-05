//
//  ShowIMGModel.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "ShowIMGModel.h"


@implementation ShowIMGModel

- (NSMutableArray*)createWithPHFetchResult:(PHFetchResult*)result WithSelectArray:(NSArray *)selectArray{

    NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:0];
    
    for (PHAsset *asset in result) {
        
        ShowIMGModel *modle = [[ShowIMGModel alloc]init];
        modle.phAsset = asset;
        
        if ([selectArray containsObject:modle.phAsset]) {
            modle.selected = YES;
        }else{
            modle.selected = NO;
        }
        
        [muArray addObject:modle];
    }
    
    return muArray;

}

+ (NSMutableArray*)modelWithPHFetchResult:(PHFetchResult*)result WithSelectArray:(NSArray *)selectArray{

   return [[ShowIMGModel alloc]createWithPHFetchResult:result WithSelectArray:selectArray];
}



@end
