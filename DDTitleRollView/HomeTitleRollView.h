//
//  HomeTitleRollView.h
//  Decoration
//
//  Created by DD on 2018/8/31.
//  Copyright © 2018年 shangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTitleRollView : UIView
/** 标题的字体 默认为14 */
@property(nonatomic)UIFont *titleFont;
/**标题的颜色 默认红色*/
@property(nonatomic)UIColor *titleColor;
/**存放titles的数组 和初始化的数组一致*/
@property(nonatomic)NSArray *titleArr;
//回调
@property(nonatomic,copy)void(^handlerTitleClickCallBack)(NSInteger index);

#pragma mark - init Methods
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)titles;
@end
