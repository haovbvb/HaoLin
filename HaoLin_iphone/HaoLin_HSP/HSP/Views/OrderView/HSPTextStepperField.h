//
//  HSPTextStepperField.h
//  HaoLin
//
//  Created by PING on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TextStepperFieldChangeKindNegative = -1, // event means one step down
    TextStepperFieldChangeKindPositive = 1 // event means one step up
} TextStepperFieldChangeKind;

@interface HSPTextStepperField : UIControl
{
}

/** 
 Describes kind of change.
 If value is BFStepperChangeKindNegative - "minus" button was pressed.
 If value is BFStepperChangeKindPositive - "plus" button was pressed.
 */
@property (nonatomic, assign, readonly) TextStepperFieldChangeKind TypeChange;

//curren value
@property (nonatomic,assign) float Current;

//number of decimals places to display
@property (nonatomic,assign) int NumDecimals;

// increase when using + or -
@property (nonatomic,assign) float Step;

// maximum value
@property (nonatomic,assign) float Maximum;

// minimum value
@property (nonatomic,assign) float Minimum;

// set editable TextField
@property (nonatomic,assign) BOOL IsEditableTextField;

@property (nonatomic, retain, readonly) UITextField  *textField;

@end
