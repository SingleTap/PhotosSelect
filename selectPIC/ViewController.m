//
//  ViewController.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/23.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "ViewController.h"

#import "selectMainVC.h"

#import "CovertPhotoMethod.h"

@interface IMGCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iiimage;

@end

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (strong,nonatomic)NSArray *imgDataArray;
@property (strong,nonatomic)NSArray *selectModelArray;

- (IBAction)btnClick:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collection registerClass:[IMGCell class] forCellWithReuseIdentifier:@"IMGCell"];
    self.collection.dataSource = self;
    self.collection.delegate = self;
    
    // 修改导航栏背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.89 green:0.13 blue:0.25 alpha:1]];
    
    // 修改标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgDataArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IMGCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IMGCell" forIndexPath:indexPath];

//    [cell.iiimage setImage:self.imgDataArray[indexPath.row]];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
    im.image = self.imgDataArray[indexPath.row];
    [cell.contentView addSubview:im];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton *)sender {
    
    __weak __typeof(self)weakSelf = self;
    
    selectMainVC *mainVC = [selectMainVC shareSelectMainVC];
    mainVC.selecIMG = self.selectModelArray;
    mainVC.returnArrayBlock= nil;
    mainVC.returnArrayBlock= ^(NSArray *array){
        
        CovertPhotoMethod *cover = [[CovertPhotoMethod alloc]init];
        [cover covertPhotoMethodWithModelArray:array WithReturnBlock:^(NSArray *dataArray) {
            
            weakSelf.imgDataArray =dataArray;
            weakSelf.selectModelArray = array;
            [weakSelf.collection reloadData];
            
            
        }];
        

        
    };
    [self.navigationController pushViewController:mainVC animated:YES];
    
    
}


@end

@implementation IMGCell



@end