//
//  selectMainVC.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/23.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "selectMainVC.h"

#import <Photos/Photos.h>

#import "SelectMainCell.h"

#import "ShowIMGVC.h"

#import "ShowIMGModel.h"

@interface selectMainVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *groupNames;

@end
static selectMainVC *singleView = nil;

@implementation selectMainVC
+ (selectMainVC *)shareSelectMainVC{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleView = [[selectMainVC alloc]init];
    });
    return singleView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"相册";
    
    [self loadIMGData];
    
    [self createTableView];
    
    
}

- (void)loadIMGData{
    self.groupNames = [NSMutableArray arrayWithCapacity:0];
    
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 列出所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    
    [smartAlbums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHAssetCollection *assetCollection = obj;
        NSString *tempStr = assetCollection.localizedTitle;
        
        /**
         All Photos:        所有照片
         Bursts:            连拍快照
         Favorites:         收藏
         Selfies:           自拍
         Screenshots:       屏幕快照
         Recently Added:    最近添加
         */
        if ([tempStr isEqualToString:@"All Photos"]||[tempStr isEqualToString:@"Favorites"]||[tempStr isEqualToString:@"Screenshots"]||[tempStr isEqualToString:@"Selfies"]||[tempStr isEqualToString:@"Recently Added"]||[tempStr isEqualToString:@"Bursts"]||[tempStr isEqualToString:@"Recently Deleted"]||[tempStr isEqualToString:@"Camera Roll"]) {
            
            [self.groupNames addObject:obj];
            
        }
        
    }];
    
    [topLevelUserCollections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.groupNames addObject:obj];
    }];
    
    
    
    for (NSInteger i =0; i < self.groupNames.count; i++) {
        
        PHAssetCollection *assetCollection = self.groupNames[i];
        
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        
        NSLog(@"sub album title is %@, count is %ld", assetCollection.localizedTitle, assetsFetchResult.count);
        
        if (!assetsFetchResult.count >0) {
            [self.groupNames removeObject:assetCollection];
            i--;
        }
        
        //        if (assetsFetchResult.count > 0) {
        //            for (PHAsset *asset in assetsFetchResult) {
        //                NSLog(@"%@",asset);
        //            }
        //        }
    }
    
    [self.tableView reloadData];
}



- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame
                                                 style:UITableViewStylePlain];
    self.tableView.dataSource       = self;
    self.tableView.delegate         = self;
    self.tableView.tableFooterView  = [[UIView alloc]init];
    [self.view addSubview:self.tableView];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupNames.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SelectMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Select"];
    
    if (!cell) {
        cell = [[SelectMainCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Select"];
    }
    PHAssetCollection *assetCollection = self.groupNames[indexPath.row];
    PHFetchResult   *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    if (assetsFetchResult.count > 0) {

        PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
        
        [imageManager requestImageForAsset:assetsFetchResult[assetsFetchResult.count-1]
                                targetSize:CGSizeMake(50, 50)
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info) {

                                 /**
                                  All Photos:        所有照片
                                  Bursts:            连拍快照
                                  Favorites:         收藏
                                  Selfies:           自拍
                                  Screenshots:       屏幕快照
                                  Recently Added:    最近添加
                                  */
                                 
                                 NSString *titleStr = nil;
                                 if ([assetCollection.localizedTitle isEqualToString:@"All Photos"]) {
                                     titleStr = @"所有照片";
                                 }else if ([assetCollection.localizedTitle isEqualToString:@"Bursts"]){
                                     titleStr = @"连拍快照";
                                 }else if ([assetCollection.localizedTitle isEqualToString:@"Favorites"]){
                                     titleStr = @"收藏";
                                 }else if ([assetCollection.localizedTitle isEqualToString:@"Selfies"]){
                                     titleStr = @"自拍";
                                 }else if ([assetCollection.localizedTitle isEqualToString:@"Screenshots"]){
                                     titleStr = @"屏幕快照";
                                 }else if ([assetCollection.localizedTitle isEqualToString:@"Recently Added"]){
                                     titleStr = @"最近添加";
                                 }else if ([assetCollection.localizedTitle isEqualToString:@"Recently Deleted"]){
                                     titleStr = @"最近删除";
                                 }else if ([assetCollection.localizedTitle isEqualToString:@"Camera Roll"]){
                                     titleStr = @"所有照片";
                                 }else{
                                     titleStr = assetCollection.localizedTitle;
                                 }
                                 
                                 [cell configCellWithHeadIMG:result andTitle:titleStr andIMGCount:[NSString stringWithFormat:@"%lu",(unsigned long)assetsFetchResult.count]];
                                 
                             }];
    }


    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        PHAssetCollection *assetCollection = self.groupNames[indexPath.row];
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
        
        NSLog(@"sub album title is %@, count is %ld", assetCollection.localizedTitle, (unsigned long)assetsFetchResult.count);
    
    
        NSMutableArray *mutaArray = [NSMutableArray arrayWithCapacity:0];
    
        ShowIMGVC *showView = [[ShowIMGVC alloc] init];
        for (ShowIMGModel *model in self.selecIMG) {
            [mutaArray addObject:model.phAsset];
        }
    
        showView.selectedModel = mutaArray;
        showView.assetsFetchResult = assetsFetchResult;
        SelectMainCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        showView.title =cell.titleLabel.text;
        [self.navigationController pushViewController:showView animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
