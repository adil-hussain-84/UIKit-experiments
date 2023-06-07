//
//  CursorPositionCalculator.m
//  App1
//
//  Created by Adil Hussain on 07/06/2023.
//

#import "CursorPositionCalculator.h"

@implementation CursorPositionCalculator

+ (NSUInteger)calculateCursorPositionInFormattedText:(NSString *)formattedText
              givenOriginalTextUpToOldCursorPosition:(NSString *)originalText {
    
    NSUInteger indexInFormattedText = 0;
    NSUInteger indexInOriginalText = 0;
    
    while (indexInFormattedText < formattedText.length && indexInOriginalText < originalText.length) {
        unichar characterInFormattedText = [formattedText characterAtIndex:indexInFormattedText];
        unichar characterInOriginalText = [originalText characterAtIndex:indexInOriginalText];
        
        if (characterInFormattedText == characterInOriginalText) {
            indexInFormattedText++;
            indexInOriginalText++;
        } else if (characterInFormattedText == ' ') {
            indexInFormattedText++;
        } else if (characterInOriginalText == ' ') {
            indexInOriginalText++;
        }
    }
    
    return indexInFormattedText;
}

@end
