//
//  BackBtn.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/26.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "BackBtn.h"

@implementation BackBtn
+ (UIButton*)createBtnWithFram:(CGRect)rect
       WithTitle:(NSString*)title
  andSelectTitle:(NSString*)selecTitle
          andIMG:(NSString*)img
    andSelectIMG:(NSString*)selectIMG
   andTitleColor:(UIColor*)nomColor
  andSelectColor:(UIColor*)selectColor
       andTarget:(id)target
       andAction:(SEL)action{
    UIButton *btn = [BackBtn buttonWithType:UIButtonTypeCustom];
    btn.frame= rect;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selecTitle forState:UIControlStateSelected];
    if (img.length) {
        [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    }
    if (selectIMG.length) {
        [btn setImage:[UIImage imageNamed:selectIMG] forState:UIControlStateSelected];
    }
    [btn setTitleColor:nomColor forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   
    return btn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/

@end
