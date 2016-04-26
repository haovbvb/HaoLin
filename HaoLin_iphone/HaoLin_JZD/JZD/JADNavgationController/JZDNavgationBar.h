//
//  JZDNavgationBar.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDNavgationBar : UINavigationBar

@property (nonatomic,strong) NSString *barImageString;

@end


#define TitleFont 18
#define TitleColor [UIColor whiteColor]

#define BackgroundImage @""
#define BackItemImage @"HSP_back_nom"
#define ItemImage @"bar_button_item.png"
#define BackItemSelectedImage @"back_bar_button_s.png"
#define ItemSelectedImage @"bar_button_item_s.png"

#define BackItemOffset UIEdgeInsetsMake(0, 5, 0, 0)
#define ItemLeftMargin 10
#define ItemWidth 44
#define ItemHeight 44
#define ItemTextFont 12
#define ItemTextNormalColot [UIColor whiteColor]
#define ItemTextSelectedColot [UIColor colorWithWhite:0.7 alpha:1]

typedef enum {
    NavBarButtonItemTypeDefault = 0,
    NavBarButtonItemTypeBack = 1
}NavBarButtonItemType;

@interface JZDNAvgationItem : NSObject

@property (nonatomic,assign)NavBarButtonItemType itemType;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)UIFont *font;
@property (nonatomic,strong)UIColor *normalColor;
@property (nonatomic,strong)UIColor *selectedColor;
@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL selector;
@property (nonatomic,assign)BOOL highlightedWhileSwitch;

- (id)initWithType:(NavBarButtonItemType)itemType;

+ (id)defauleItemWithTarget:(id)target
                     action:(SEL)action
                      title:(NSString *)title;
+ (id)defauleItemWithTarget:(id)target
                     action:(SEL)action
                      image:(NSString *)image;
+ (id)backItemWithTarget:(id)target
                  action:(SEL)action
                   title:(NSString *)title;

- (void)setTarget:(id)target withAction:(SEL)action;

@end

@interface UINavigationItem(CustomBarButtonItem)
- (void)setTitle:(NSString *)title withTitleColor:(UIColor *)color withFont:(UIFont *)fontText;
- (void)setNewTitleImage:(UIImage *)image;

- (void)setLeftItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;
- (void)setLeftItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;
- (void)setLeftItemWithButtonItem:(JZDNAvgationItem *)item;

- (void)setRightItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;
- (void)setRightItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;
- (void)setRightItemWithButtonItem:(JZDNAvgationItem *)item;

- (void)setBackItemWithTarget:(id)target action:(SEL)action;
- (void)setBackItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;
-(void)setLeftItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;

@end