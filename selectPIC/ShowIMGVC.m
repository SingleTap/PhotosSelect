//
//  ShowIMGVC.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "ShowIMGVC.h"
#import "ShowIMGCollectionCell.h"
#import "ShowIMGModel.h"
#import "PreViewController.h"
#import "selectMainVC.h"
#define WIDTH_PIC self.view.frame.size.width
#define HEIGHT_PIC    self.view.frame.size.height

@interface ShowIMGVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *selectedArray;

@property (nonatomic,assign)CGFloat collectionCellWidth;

@property (nonatomic,strong)UIButton *toolBarLeftBtn;
@property (nonatomic,strong)UIButton *toolBarRightBtn;


@end

@implementation ShowIMGVC



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionCellWidth  = WIDTH_PIC/4;
    
    [self createBar];
    [self createCollectionView];
    [self loadData];


}

- (void)createBar{

    UIView *toolBarBGView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_PIC-44, WIDTH_PIC, 44)];
    toolBarBGView.backgroundColor = [UIColor colorWithRed:0.97 green:0.98 blue:1 alpha:1];
    [self.view addSubview:toolBarBGView];
    
    self.toolBarLeftBtn = [self createBtnWithTitle:@"预览" andBackIMG:nil andTitleColor:[UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1] andSelectedTitleColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1] andTarget:@selector(toolBarLeftBtnClick) andFram:CGRectMake(5, 0, 80, 44)];
    self.toolBarLeftBtn.selected  = YES;
    [toolBarBGView addSubview:self.toolBarLeftBtn];
    
    self.toolBarRightBtn = [self createBtnWithTitle:@"确定" andBackIMG:nil andTitleColor:[UIColor whiteColor] andSelectedTitleColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1] andTarget:@selector(toolBarightBtnClick) andFram:CGRectMake(WIDTH_PIC - 70, 7, 60, 30)];
    if (self.selectedModel.count) {
        [self.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
    }else{
        [self.toolBarRightBtn setTitle:@"确定" forState:UIControlStateSelected];

    }
    self.toolBarRightBtn.layer.cornerRadius     = 3;
    self.toolBarRightBtn.layer.masksToBounds    = YES;
    self.toolBarRightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.toolBarRightBtn.selected = YES;
    self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];
    [toolBarBGView addSubview:self.toolBarRightBtn];
    
    
}
- (void)toolBarightBtnClick{
    [selectMainVC shareSelectMainVC].returnArrayBlock(self.selectedArray);
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)toolBarLeftBtnClick{
    NSLog(@"预览");
    PreViewController *pre = [[PreViewController alloc]init];
    pre.imgModelArray = self.selectedArray;
    pre.pageNum       = 0;
    pre.selectedArray = [NSMutableArray arrayWithArray:self.selectedArray];
    
    __weak ShowIMGVC *WeakSelf = self;
    pre.selectBlock = ^(NSMutableArray *array,ShowIMGModel *model,BOOL selected){
        
        WeakSelf.selectedArray = [NSMutableArray arrayWithArray:array];
        model.selected = selected;
        
        if (WeakSelf.selectedArray.count) {
            WeakSelf.toolBarRightBtn.selected = NO;
            WeakSelf.toolBarLeftBtn.selected  = NO;
            [WeakSelf.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
            WeakSelf.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
        }else{
            WeakSelf.toolBarRightBtn.selected = YES;
            WeakSelf.toolBarLeftBtn.selected  = YES;
            WeakSelf.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];
            
        }
        [WeakSelf.collectionView reloadData];
        
    };
    [self.navigationController pushViewController:pre animated:YES];

}

- (UIButton*)createBtnWithTitle:(NSString*)title andBackIMG:(NSString*)name andTitleColor:(UIColor*)color andSelectedTitleColor:(UIColor*)selectTitleColor andTarget:(SEL)clickAction andFram:(CGRect)rect{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn addTarget:self action:clickAction forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:selectTitleColor forState:UIControlStateSelected];
    
    return btn;
    
}

- (void)loadData{
    
    


    self.selectedArray = [NSMutableArray arrayWithCapacity:0];
    self.dataArray = [ShowIMGModel modelWithPHFetchResult:self.assetsFetchResult WithSelectArray:self.selectedModel];
    
    for (ShowIMGModel *model in self.dataArray) {
        if ([self.selectedModel containsObject:model.phAsset]) {
            model.selected = YES;
            [self.selectedArray addObject:model];
            
            if (self.selectedArray.count) {
                self.toolBarRightBtn.selected = NO;
                self.toolBarLeftBtn.selected  = NO;
                [self.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
                self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
            }else{
                self.toolBarRightBtn.selected = YES;
                self.toolBarLeftBtn.selected  = YES;
                self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];
                
            }
            
        }
    }
    
    [self.collectionView reloadData];
    
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;
    flowLayout.itemSize                = CGSizeMake(WIDTH_PIC, HEIGHT_PIC);

    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH_PIC, HEIGHT_PIC - 44 - 64) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentSize = CGSizeMake(WIDTH_PIC, HEIGHT_PIC);
    [self.collectionView registerClass:[ShowIMGCollectionCell class] forCellWithReuseIdentifier:@"showView"];
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.assetsFetchResult.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    CGSize collectionSize = {self.collectionCellWidth,self.collectionCellWidth};
    return collectionSize;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowIMGCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"showView" forIndexPath:indexPath];

    ShowIMGModel *model =self.dataArray[indexPath.row];

    
    __weak ShowIMGVC *WeakSelf = self;
    cell.selectedBlock = ^(BOOL select){
        model.selected = select;
        if (select) {
        [WeakSelf.selectedArray addObject:model];
        }else{
        [WeakSelf.selectedArray removeObject:model];
        }
        if (WeakSelf.selectedArray.count) {
            WeakSelf.toolBarRightBtn.selected = NO;
            WeakSelf.toolBarLeftBtn.selected  = NO;
            [WeakSelf.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
            WeakSelf.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
        }else{
            WeakSelf.toolBarRightBtn.selected = YES;
            WeakSelf.toolBarLeftBtn.selected  = YES;
                self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];

        }
    };
    
    cell.previewBlock = ^(){
        PreViewController *pre = [[PreViewController alloc]init];
        pre.imgModelArray = [NSMutableArray arrayWithArray:self.dataArray];
        pre.pageNum       = indexPath.row;
        pre.selectedArray = [NSMutableArray arrayWithArray:self.selectedArray];
        pre.selectBlock = ^(NSMutableArray *array,ShowIMGModel *model,BOOL selected){
            WeakSelf.selectedArray = [NSMutableArray arrayWithArray:array];

            model.selected = selected;

            if (WeakSelf.selectedArray.count) {
                WeakSelf.toolBarRightBtn.selected = NO;
                WeakSelf.toolBarLeftBtn.selected  = NO;
                [WeakSelf.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
                WeakSelf.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
            }else{
                WeakSelf.toolBarRightBtn.selected = YES;
                WeakSelf.toolBarLeftBtn.selected  = YES;
                WeakSelf.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];
                
            }
            [WeakSelf.collectionView reloadData];

        };
        [WeakSelf.navigationController pushViewController:pre animated:YES];
    };
    
    [cell configWithModel:model];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
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
