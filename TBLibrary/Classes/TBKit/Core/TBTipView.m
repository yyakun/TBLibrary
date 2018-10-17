//
//  TBTipView.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBTipView.h"
#import "TBKit.h"

@interface TBTipView ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation TBTipView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self setupLayout];
}

#pragma mark - getter
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        [_label useAutoLayout];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = UIFont(15);
        _label.textColor = UIColorFromHex(0x999999);
    }
    return _label;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.label];
}

- (void)setupLayout {
    [_label autoAlignInSuperview:TBAutoLayoutAlignTop constant:100];
    [_label autoAlignInSuperview:TBAutoLayoutAlignCenterX];
}

@end
