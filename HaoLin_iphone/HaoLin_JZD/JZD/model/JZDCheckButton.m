//
//  JZDCheckButton.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDCheckButton.h"

@implementation JZDCheckButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setDelegate:(id)delegate
{
    _delegate = delegate;
    self.exclusiveTouch = YES;
//    [self setImage:[UIImage imageNamed:@"JZD_location.PNG"] forState:UIControlStateNormal];
//    [self setImage:[UIImage imageNamed:@"check_icon.png"] forState:UIControlStateSelected];
//    [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setChecked:(BOOL)checked {
    if (_Checked == checked) {
        return;
    }
    _Checked = checked;
    self.selected = checked;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)checkboxBtnChecked {
    //    self.selected = !self.selected;
    _Checked = self.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return _buttonImageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return _buttonTitleRect;
}

- (void)dealloc {
    _delegate = nil;
}

@end
