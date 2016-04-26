//
//  JZDNavgationBar.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDNavgationBar.h"

@interface JZDNavgationBar ()

@property (nonatomic,strong) CALayer *colorLayer;

@end

@implementation JZDNavgationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setBarImageString:(NSString *)barImageString
{
    _barImageString=barImageString;
}
//可以设置导航条的图片

#if 0
-(void)drawRect:(CGRect)rect
{
    self.frame=CGRectMake(0, 0, 320, 64);
    self.backgroundColor=[UIColor orangeColor];
    if (_barImageString) {
        [[UIImage imageNamed:_barImageString] drawInRect:rect];
    }
}
#endif

//没实现drawRect时修改导航条的颜色
- (void)setBarTintColor:(UIColor *)barTintColor{
    [super setBarTintColor:barTintColor];
    [self.layer addSublayer:self.colorLayer];
    self.colorLayer.backgroundColor=barTintColor.CGColor;
}

@end

@implementation JZDNAvgationItem

- (void)dealloc {
    self.target = nil;
    self.selector = nil;
}

- (id)initWithType:(NavBarButtonItemType)itemType
{
    self = [super init];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button  = button;
        self.itemType = itemType;
        button.titleLabel.font  = [UIFont systemFontOfSize:ItemTextFont];
        [button setTitleColor:ItemTextNormalColot forState:UIControlStateNormal];
        [button setTitleColor:ItemTextSelectedColot forState:UIControlStateHighlighted];
        [button setTitleColor:ItemTextSelectedColot forState:UIControlStateSelected];
        button.frame =CGRectMake(0, 0, ItemWidth, ItemHeight);
    }
    return self;
}

+ (id)defauleItemWithTarget:(id)target taction:(SEL)action title:(NSString *)title
{
    JZDNAvgationItem *item = [[JZDNAvgationItem alloc] initWithType:NavBarButtonItemTypeDefault];
    item.title = title;
    [item setTarget:target withAction:action];
    return item;
}

+ (id)defauleItemWithTarget:(id)target action:(SEL)action image:(NSString *)image
{
    JZDNAvgationItem *item = [[JZDNAvgationItem alloc]initWithType:NavBarButtonItemTypeDefault];
    item.image = image;
    [item setTarget:target withAction:action];
    return item;
}

+ (id)defauleItemWithTarget:(id)target
                     action:(SEL)action
                      title:(NSString *)title
{
    JZDNAvgationItem *item = [[JZDNAvgationItem alloc]initWithType:NavBarButtonItemTypeDefault];
    item.title = title;
    [item setTarget:target withAction:action];
    return item;
}

+ (id)backItemWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    JZDNAvgationItem *item = [[JZDNAvgationItem alloc]initWithType:NavBarButtonItemTypeBack];
    item.title = title;
    [item setTarget:target withAction:action];
    return item;
}

-(id)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [_button setImage:image forState:UIControlStateNormal];
    [_button setImage:selectedImage forState:UIControlStateHighlighted];
    return self;
}

+(JZDNAvgationItem *)barItemWithImage:(UIImage*)image selectedImage:(UIImage*)selectedImage target:(id)target action:(SEL)action
{
    return [[JZDNAvgationItem alloc] initWithImage:image selectedImage:selectedImage target:target action:action];
}
#pragma mark --在这里修改1
- (void)setItemType:(NavBarButtonItemType)itemType
{
    _itemType = itemType;
    UIImage *image;
    UIImage *image_s;
    switch (itemType) {
        case NavBarButtonItemTypeBack:
        {
            image = [UIImage imageNamed:BackItemImage];
            image_s = [UIImage imageNamed:BackItemSelectedImage];
        }
            break;
        case NavBarButtonItemTypeDefault:
        {
            image = [UIImage imageNamed:ItemImage];
            image_s = [UIImage imageNamed:ItemSelectedImage];
        }
            break;
        default:
            break;
    }
    [_button setBackgroundImage:image forState:UIControlStateNormal];
    [_button setBackgroundImage:image_s forState:UIControlStateHighlighted];
    [_button setBackgroundImage:image_s forState:UIControlStateSelected];
    [self  titleOffsetWithType];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_button setTitle:title forState:UIControlStateNormal];
    [_button setTitle:title forState:UIControlStateHighlighted];
    [_button setTitle:title forState:UIControlStateSelected];
    [self  titleOffsetWithType];
}
#pragma mark  --修改3
- (void)setImage:(NSString *)image
{
    _image = image;
    UIImage *image_ = [UIImage imageNamed:image];
    [_button setImage:image_  forState:UIControlStateNormal];
    [_button setImage:image_ forState:UIControlStateHighlighted];
    [_button setImage:image_ forState:UIControlStateSelected];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [_button.titleLabel setFont:font];
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    [_button setTitleColor:normalColor forState:UIControlStateNormal];
}
#pragma mark --按钮的颜色
- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    [_button setTitleColor:selectedColor forState:UIControlStateHighlighted];
    [_button setTitleColor:selectedColor forState:UIControlStateSelected];
}

- (void)setTarget:(id)target withAction:(SEL)action
{
    [_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}


- (void)titleOffsetWithType
{
    switch (_itemType) {
        case NavBarButtonItemTypeBack:
        {
            [_button setContentEdgeInsets:BackItemOffset];
        }
            break;
        case NavBarButtonItemTypeDefault:
        {
            [_button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
            break;
        default:
            break;
    }
}
#pragma mark  --在这里修改2
- (void)setHighlightedWhileSwitch:(BOOL)highlightedWhileSwitch
{
    UIImage *image;
    if (!highlightedWhileSwitch) {
        
        switch (_itemType) {
            case NavBarButtonItemTypeBack:
            {
                image = [UIImage imageNamed:BackItemImage];
            }
                break;
            case NavBarButtonItemTypeDefault:
            {
                image = [UIImage imageNamed:ItemImage];
                
            }
                break;
            default:
                break;
        }
    }else
    {
        switch (_itemType) {
            case NavBarButtonItemTypeBack:
            {
                image = [UIImage imageNamed:BackItemSelectedImage];
            }
                break;
            case NavBarButtonItemTypeDefault:
            {
                image = [UIImage imageNamed:ItemSelectedImage];
                
            }
                break;
            default:
                break;
        }
    }
    [_button setBackgroundImage:image forState:UIControlStateNormal];
    [_button setBackgroundImage:image forState:UIControlStateHighlighted];
    [_button setBackgroundImage:image forState:UIControlStateSelected];
}

@end

@implementation UINavigationItem (CustomBarButtonItem)
//标题文字
- (void)setTitle:(NSString *)title withTitleColor:(UIColor *)color withFont:(UIFont *)fontText
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 15, 180, 20);
    label.backgroundColor = [UIColor clearColor];
    label.font =fontText;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    self.titleView = label;
}
//设置标题图片
- (void)setNewTitleImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    CGRect bounds = imageView.bounds;
    bounds.size  =  image.size;
    imageView.bounds = bounds;
    self.titleView = imageView;
}
//左侧按钮及文字
- (void)setLeftItemWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    JZDNAvgationItem *buttonItem = [JZDNAvgationItem defauleItemWithTarget:target action:action title:title];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
}
//左侧按钮及图片
- (void)setLeftItemWithTarget:(id)target action:(SEL)action image:(NSString *)image
{
    JZDNAvgationItem *buttonItem = [JZDNAvgationItem defauleItemWithTarget:target action:action image:image];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
}

//左侧按钮
-(void)setLeftItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    JZDNAvgationItem *buttonItem=[JZDNAvgationItem barItemWithImage:image selectedImage:selectedImage target:target action:action];
    self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
}

- (void)setLeftItemWithButtonItem:(JZDNAvgationItem *)item
{
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item.button];
}
//右侧按钮及文字
- (void)setRightItemWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    JZDNAvgationItem *buttonItem = [JZDNAvgationItem defauleItemWithTarget:target action:action title:title];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
}
//右侧按钮及图片
- (void)setRightItemWithTarget:(id)target action:(SEL)action image:(NSString *)image
{
    JZDNAvgationItem *buttonItem = [JZDNAvgationItem defauleItemWithTarget:target action:action image:image];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
}

- (void)setRightItemWithButtonItem:(JZDNAvgationItem *)item
{
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item.button];
}
//设置返回按钮
- (void)setBackItemWithTarget:(id)target action:(SEL)action
{
    JZDNAvgationItem *buttonItem = [JZDNAvgationItem backItemWithTarget:target action:action title:@"返回"];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
}
//返回按钮
- (void)setBackItemWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    JZDNAvgationItem *buttonItem = [JZDNAvgationItem backItemWithTarget:target action:action title:title];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
}

@end
