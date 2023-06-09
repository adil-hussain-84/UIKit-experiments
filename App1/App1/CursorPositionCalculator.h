//
//  CursorPositionCalculator.h
//  App1
//
//  Created by Adil Hussain on 07/06/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CursorPositionCalculator : NSObject

/// Calculates where the cursor should be placed within `formattedText` taking into account `originalText`.
///
/// This function assumes that:
///
/// 1. The non-space characters in `originalText` are a subset of the non-space characters in `formattedText`.
///
/// 2. The non-space characters in `originalText` are in the same exact order as the non-space characters in `formattedText`.
///
/// - Parameters:
///   - formattedText: The formatted text which may have spaces in different places than the original (i.e. pre-formatted) text.
///   - originalText: The original (i.e. pre-formatted) text up to where the cursor was prior to formatting.
/// - Returns: The position (i.e. index) where the cursor should be placed within `formattedText`.
+ (NSUInteger)calculateCursorPositionInFormattedText:(NSString *)formattedText
              givenOriginalTextUpToOldCursorPosition:(NSString *)originalText;

@end

NS_ASSUME_NONNULL_END
