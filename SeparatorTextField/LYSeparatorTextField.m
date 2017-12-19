//
//  LYSeparatorTextField.m
//  SeparatorTextField
//
//  Created by youngliuxx on 13/12/2017.
//  Copyright © 2017 youngliuxx. All rights reserved.
//

#import "LYSeparatorTextField.h"
#import "LYSeparatorTextField+Private.h"

typedef NS_ENUM(NSUInteger, LYSeparatorTextFieldFormat) {
    LYSeparatorTextFieldFormatRegular = 0,
    LYSeparatorTextFieldFormatFlexible = 1,
};

@interface LYSeparatorTextField()<UITextFieldDelegate>

@property (nonatomic, assign) NSUInteger gapNumber;
@property (nonatomic, assign) LYSeparatorTextFieldFormat formatType;
@property (nonatomic, copy) NSString *separator;
@property (nonatomic, copy) NSString *formatString;

@end

@implementation LYSeparatorTextField

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame gapNumber:(NSUInteger)number separator:(NSString *)separator
{
    return [self initWithFrame:frame
                     gapNumber:number
                     separator:separator
                  formatString:@""];
}

- (instancetype)initWithFrame:(CGRect)frame format:(NSString *)formatString
{
    return [self initWithFrame:frame
                     gapNumber:0
                     separator:@""
                  formatString:formatString];
}

- (instancetype)initWithFrame:(CGRect)frame gapNumber:(NSUInteger)number separator:(NSString *)separator formatString:(NSString *)formatString
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        _formatType = formatString.length > 0 ? LYSeparatorTextFieldFormatFlexible : LYSeparatorTextFieldFormatRegular;
        _gapNumber = number;
        _separator = separator;
        _formatString = formatString;
    }
    return self;
}

#pragma mark - textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = textField.text.length - range.length + string.length;
    NSUInteger preDeleteIndex = textField.text.length - range.length;
    NSUInteger preAddIndex = textField.text.length + string.length;
    NSString *finalString = textField.text;
    
    switch (_formatType) {
        case LYSeparatorTextFieldFormatRegular: {
            // Limit
            if (_limitCount > 0 && newLength >= _limitCount + newLength / _gapNumber) {
                return NO;
            }
            
            // Delete
            if ([string isEqualToString:@""]) {
                if ((preDeleteIndex) % (_gapNumber + 1) == 0) {
                    finalString = [textField.text substringToIndex:preDeleteIndex];
                }
            }
            // Add
            else if (preAddIndex >= _gapNumber && (preAddIndex) % (_gapNumber + 1) == 0){
                finalString = [[NSString alloc] initWithFormat:@"%@%@", textField.text, _separator];
            }
            break;
        }
        case LYSeparatorTextFieldFormatFlexible:{
            // Delete
            if ([string isEqualToString:@""]) {
                if ((range.location - 1) > 0 ) {
                    NSUInteger separateLength = [self getSeparateLengthWithIndex:preDeleteIndex sequence:LYSeparatorTextFieldSequenceReverse];
                    finalString = [textField.text substringToIndex:preDeleteIndex - separateLength];
                    textField.text = finalString;
                    return NO;
                }
            }
            // Add
            else {
                NSUInteger currentIndex = textField.text.length;
                // Limit
                if (currentIndex >= _formatString.length) {
                    return NO;
                }
                NSUInteger preAddLength = preAddLength;
                NSString *preAddChar = string;
                NSString *formatChar = [_formatString substringWithRange:NSMakeRange(currentIndex, 1)];
                if ([self isPlaceholdCharacter:formatChar]) {
                    finalString = [finalString stringByAppendingString:preAddChar];
                }
                else {
                    NSInteger preCurrentIndex = currentIndex - 1;
                    NSUInteger separateLength = [self getSeparateLengthWithIndex:preCurrentIndex sequence:LYSeparatorTextFieldSequenceForward];
                    for (NSUInteger i = 0; i < separateLength; i++) {
                        NSString *formatChar = [_formatString substringWithRange:NSMakeRange(currentIndex + i, 1)];
                        finalString = [finalString stringByAppendingString:formatChar];
                    }
                    finalString = [finalString stringByAppendingString:preAddChar];
                }
                textField.text = finalString;
                return NO;
            }
            break;
        }
        default:
            break;
    }
    textField.text = finalString;
    return YES;
}

#pragma mark - private methods

/*
 * getSeparateLength
 * formatString: ^^^^-^^--^
 * input index: 9
 * output: 2
 */
- (NSUInteger)getSeparateLengthWithIndex:(NSInteger)preOperationIndex sequence:(LYSeparatorTextFieldSequence)sequence
{
    NSUInteger finalSeparateLength = 0;
    switch (sequence) {
        case LYSeparatorTextFieldSequenceReverse: {
            for (NSInteger i = 1; i <= preOperationIndex; i++) {
                NSString *preDeleteFormatStr = [self.formatString substringWithRange:NSMakeRange(preOperationIndex - i, 1)];
                // 是分隔符
                if (![preDeleteFormatStr isEqualToString:PLACEHOLDER_CHAR]) {
                    finalSeparateLength = i;
                }
                // 不是分隔符直接返回
                else {
                    return finalSeparateLength;
                }
            }
            break;
        }
        case LYSeparatorTextFieldSequenceForward: {
            NSInteger formatStringLength = self.formatString.length;
            for (NSInteger i = preOperationIndex; i < formatStringLength; i++) {
                NSString *preAddFormatStr = [self.formatString substringWithRange:NSMakeRange(i + 1, 1)];
                // 是分隔符
                if (![preAddFormatStr isEqualToString:PLACEHOLDER_CHAR]) {
                    finalSeparateLength = i - preOperationIndex + 1;
                }
                // 不是分隔符直接返回
                else {
                    return finalSeparateLength;
                }
            }
            break;
        }
        default:
            break;
    }
    return finalSeparateLength;
}

- (BOOL)isPlaceholdCharacter:(NSString *)aCharacter
{
    return [aCharacter isEqualToString:PLACEHOLDER_CHAR];
}

- (void)dealloc
{
    self.delegate = nil;
}

#pragma mark - public methods

- (NSString *)getInputText
{
    return [super.text stringByReplacingOccurrencesOfString:_separator withString:@""];
}

@end
