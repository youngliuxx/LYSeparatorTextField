//
//  LYSeparatorTextField+Private.h
//  SeparatorTextField
//
//  Created by youngliuxx on 2017/12/17.
//  Copyright © 2017年 youngliuxx. All rights reserved.
//

#import "LYSeparatorTextField.h"

typedef NS_ENUM(NSUInteger, LYSeparatorTextFieldSequence) {
    LYSeparatorTextFieldSequenceReverse,
    LYSeparatorTextFieldSequenceForward,
};

@interface LYSeparatorTextField (Private)

@property (nonatomic, copy) NSString *formatString;

- (NSUInteger)getSeparateLengthWithIndex:(NSInteger)preDeleteIndex sequence:(LYSeparatorTextFieldSequence)sequence;

@end
