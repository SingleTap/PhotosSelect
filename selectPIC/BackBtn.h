//
//  BackBtn.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/26.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackBtn : UIButton
+ (UIButton*)createBtnWithFram:(CGRect)rect
                     WithTitle:(NSString*)title
                andSelectTitle:(NSString*)selecTitle
                        andIMG:(NSString*)img
                  andSelectIMG:(NSString*)selectIMG
                 andTitleColor:(UIColor*)nomColor
                andSelectColor:(UIColor*)selectColor
                     andTarget:(id)target
                     andAction:(SEL)action;
@end
