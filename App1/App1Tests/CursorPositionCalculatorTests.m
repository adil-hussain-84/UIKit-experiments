//
//  CursorPositionCalculatorTests.m
//  App1Tests
//
//  Created by Adil Hussain on 07/06/2023.
//

@import XCTest;

#import "CursorPositionCalculator.h"

@interface CursorPositionCalculatorTests : XCTestCase
@end

@implementation CursorPositionCalculatorTests

- (void)test {
    NSArray *testData = @[
        @{@"FormattedText": @"", @"OriginalTextUpToCursor": @"", @"Expected": @0},
        @{@"FormattedText": @"1234", @"OriginalTextUpToCursor": @"1", @"Expected": @1},
        @{@"FormattedText": @"1234", @"OriginalTextUpToCursor": @"1234", @"Expected": @4},
        @{@"FormattedText": @"1234", @"OriginalTextUpToCursor": @"1234 ", @"Expected": @4},
        @{@"FormattedText": @"1234", @"OriginalTextUpToCursor": @"12 34", @"Expected": @4},
        @{@"FormattedText": @"1234", @"OriginalTextUpToCursor": @"12  34", @"Expected": @4},
        @{@"FormattedText": @"1234 5678", @"OriginalTextUpToCursor": @"", @"Expected": @0},
        @{@"FormattedText": @"1234 5678", @"OriginalTextUpToCursor": @"1", @"Expected": @1},
        @{@"FormattedText": @"1234 5678", @"OriginalTextUpToCursor": @"1234", @"Expected": @4},
        @{@"FormattedText": @"1234 5678", @"OriginalTextUpToCursor": @"1234 ", @"Expected": @5},
        @{@"FormattedText": @"1234 5678", @"OriginalTextUpToCursor": @"12 34", @"Expected": @4},
        @{@"FormattedText": @"1234 5678", @"OriginalTextUpToCursor": @"12  34", @"Expected": @4},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"", @"Expected": @0},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"1", @"Expected": @1},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"1234", @"Expected": @4},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"1234 ", @"Expected": @5},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"1234  ", @"Expected": @6},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"12 34", @"Expected": @4},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"12 34 ", @"Expected": @5},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"12  34  ", @"Expected": @6},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"12345", @"Expected": @7},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"12 34 5", @"Expected": @7},
        @{@"FormattedText": @"1234  5678", @"OriginalTextUpToCursor": @"12  34  5", @"Expected": @7},
    ];
    
    for (int i = 0; i < testData.count; i++) {
        // Given.
        NSString *formattedText = testData[i][@"FormattedText"];
        NSString *originalTextUpToCursor = testData[i][@"OriginalTextUpToCursor"];
        NSNumber *expected = testData[i][@"Expected"];
        
        // When.
        NSUInteger actual = [CursorPositionCalculator calculateCursorPositionInFormattedText:formattedText
                                                      givenOriginalTextUpToOldCursorPosition:originalTextUpToCursor];
        
        // Then.
        XCTAssertEqual(expected.unsignedLongValue, actual, @"FormattedText = '%@'; OriginalTextUpToCursor = '%@'", formattedText, originalTextUpToCursor);
    }
}

@end
