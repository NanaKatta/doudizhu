//
//  CardView.m
//  card
//
//  Created by tmachc on 15/9/11.
//  Copyright (c) 2015年 tmachc. All rights reserved.
//

#import "CardView.h"
#import "Masonry.h"
#import "PlayingCard.h"
#import "SingleUserViewController.h"

@implementation CardView

- (instancetype)initWithPlayingCard:(PlayingCard *)card
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        UILabel *contentLab = [UILabel new];
        contentLab.text = card.contents;
        if ([card.suit isEqualToString:@"♥︎"] || [card.suit isEqualToString:@"♦︎"] || card.rank > [PlayingCard maxRank] + 1) {
            contentLab.textColor = [UIColor redColor];
        }
        contentLab.textAlignment = NSTextAlignmentCenter;
        contentLab.font = [UIFont boldSystemFontOfSize:15];
        contentLab.numberOfLines = 0;
        [self addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(3);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(45);
        }];
        
//        UIButton *btn = [UIButton new];
        self.tag = card.rank;
        [self addTarget:(SingleUserViewController *)[self findNearestViewController:self] action:@selector(outCard:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.width.height.mas_equalTo(self);
//        }];
    }
    return self;
}

//找到最近的上一级 ViewController
- (UIViewController *)findNearestViewController:(UIView *)view
{
    UIViewController *viewController = nil;
    for (UIView *next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)nextResponder;
            break;
        }
    }
    return viewController;
}

@end
