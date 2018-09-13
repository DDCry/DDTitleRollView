//
//  HomeTitleRollView.m
//  Decoration
//
//  Created by DD on 2018/8/31.
//  Copyright © 2018年 shangshuai. All rights reserved.
//

#import "HomeTitleRollView.h"


@interface HomeTitleRollView()
@property(assign, nonatomic)int titleIndex;
@property(assign, nonatomic)int index;
@property (nonatomic) NSMutableArray *titles;
/**第一个*/
@property(nonatomic)UIButton *firstBtn;
/**更多个*/
@property(nonatomic)UIButton *moreBtn;
@end
@implementation HomeTitleRollView

#pragma mark - init Methods
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)titles{

    if (self = [super initWithFrame:frame]) {
        _titleArr  = titles;
        self.titleColor = [UIColor blackColor];
        self.titleFont =  [UIFont systemFontOfSize:14];
        self.clipsToBounds = YES;

        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, (self.frame.size.height - 15 )/2, 15, 15)];
        icon.image = [UIImage imageNamed:@"home_notice"];
        [self addSubview:icon];


        NSMutableArray *MutableTitles = [NSMutableArray arrayWithArray:titles];
        NSString *str = @"";
        self.titles = MutableTitles;
        [self.titles addObject:str]; //加一个空的,防止数组为空奔溃
        self.index = 1;
        self.firstBtn = [self btnframe:CGRectMake(CGRectGetMaxX(icon.frame), 0, [UIScreen mainScreen].bounds.size.width - 2 *30, self.bounds.size.height)  titleColor:_titleColor action:@selector(clickBtn:)];
        self.firstBtn .tag = self.index;
//        [self.firstBtn  setTitle:self.titles[0] forState:UIControlStateNormal];
        [self.firstBtn setAttributedTitle:[self getAttributeStr:self.titles[0]] forState:UIControlStateNormal];
        [self addSubview:self.firstBtn];
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextAd) userInfo:nil repeats:YES];

    }

    return self;
}

#pragma mark - SEL Methods
-(void)nextAd{
    UIButton *firstBtn = [self viewWithTag:self.index];
    self.moreBtn = [self btnframe: CGRectMake(30, self.bounds.size.height,[UIScreen mainScreen].bounds.size.width -2 *30, self.bounds.size.height)  titleColor:_titleColor action:@selector(clickBtn:)];
    self.moreBtn.tag = self.index + 1;
    if ([self.titles[self.titleIndex+1] isEqualToString:@""]) {
        self.titleIndex = -1;
        self.index = 0;
    }
    if (self.moreBtn.tag == self.titles.count) {

        self.moreBtn.tag = 1;
    }
//    [self.moreBtn setTitle:self.titles[self.titleIndex+1] forState:UIControlStateNormal];
    [self.moreBtn setAttributedTitle:[self getAttributeStr:self.titles[self.titleIndex+1]] forState:UIControlStateNormal];
    [self addSubview:self.moreBtn];

    [UIView animateWithDuration:0.25 animations:^{
        firstBtn.y = -self.bounds.size.height;
        self.moreBtn.y = 0;

    } completion:^(BOOL finished) {
        [firstBtn removeFromSuperview];

    } ];
    self.index++;
    self.titleIndex++;
}
-(void)clickBtn:(UIButton *)btn{

    if (self.handlerTitleClickCallBack) {
        self.handlerTitleClickCallBack(btn.tag);
    }
}

#pragma mark - Custom Methods

- (NSMutableAttributedString *)getAttributeStr:(NSString *)str {

    NSArray *strArr = [str componentsSeparatedByString:@","];
    if (strArr.count != 3) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        return attStr;
    }else{
        NSString * allStr = [NSString stringWithFormat:@"%@%@%@",strArr[0],strArr[1],strArr[2]];
        NSRange range = [allStr rangeOfString:strArr[1]];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:allStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:COLOR_HEX_STR(@"#01C5DA", 1) range:range];
        return attStr;
    }

}
- (UIButton *)btnframe:(CGRect)frame  titleColor:(UIColor *)titleColor action:(SEL)action{

    UIButton *btn = [[UIButton alloc]init];
    btn.frame = frame;
    btn.titleLabel.font = _titleFont;
    //靠左 不居中显示
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;////文字多出部分 在右侧显示点点
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}
#pragma mark - Setter && Getter Methods
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self.firstBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:titleColor forState:UIControlStateNormal];

}
- (void)setTitleFont:(UIFont *)titleFont{

    _titleFont = titleFont;
    self.firstBtn.titleLabel.font = titleFont;
    self.moreBtn.titleLabel.font = titleFont;

}

@end
