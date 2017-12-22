//
//  LYSeparatorTextField.h
//  SeparatorTextField
//
//  Created by youngliuxx on 13/11/2017.
//  Copyright © 2017 youngliuxx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PLACEHOLDER_CHAR @"^"

@interface LYSeparatorTextField : UITextField

/// Default 0, means off, not include separator
@property (nonatomic, assign) NSUInteger limitCount;

- (instancetype)initWithFrame:(CGRect)frame gapNumber:(NSUInteger)number separator:(NSString *)separator;

/// Input format:^^^^-^^-^^, Output:2017-12-17
- (instancetype)initWithFrame:(CGRect)frame format:(NSString *)formatString;

- (NSString *)getInputText;

@end
