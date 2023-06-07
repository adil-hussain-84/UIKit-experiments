//
//  CursorPositionCalculator.h
//  App1
//
//  Created by Adil Hussain on 07/06/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CursorPositionCalculator : NSObject

+ (NSUInteger)calculateCursorPositionInFormattedText:(NSString *)formattedText
              givenOriginalTextUpToOldCursorPosition:(NSString *)originalText;

@end

NS_ASSUME_NONNULL_END
