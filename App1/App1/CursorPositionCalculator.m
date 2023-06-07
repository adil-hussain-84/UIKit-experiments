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
    
    NSUInteger indexInOriginalText = 0;
    NSUInteger indexInFormattedText = 0;
    
    while (indexInOriginalText < originalText.length && indexInFormattedText < formattedText.length) {
        unichar characterInOriginalText = [originalText characterAtIndex:indexInOriginalText];
        unichar characterInFormattedText = [formattedText characterAtIndex:indexInFormattedText];
        
        if (characterInOriginalText == characterInFormattedText) {
            indexInOriginalText++;
            indexInFormattedText++;
        } else if (characterInOriginalText == ' ') {
            indexInOriginalText++;
        } else if (characterInFormattedText == ' ') {
            indexInFormattedText++;
        }
    }
    
    return indexInFormattedText;
}

@end
