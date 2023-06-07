//
//  CardNumberTextView.m
//  App1
//
//  Created by Adil Hussain on 17/05/2023.
//

#import "CardNumberTextField.h"
#import "CursorPositionCalculator.h"

@interface CardNumberTextField () <UITextFieldDelegate>

@property(nonnull, nonatomic) UITextField *textField;

@property(nonnull, nonatomic, copy) NSCharacterSet *allowedCharacterSet;
@property(nonatomic) int maxLength;

@end

@implementation CardNumberTextField

# pragma mark - Public methods

- (NSString *)cardNumber {
    return [self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

# pragma mark - Initialisation methods

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialiseViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self initialiseViews];
    }
    return self;
}

- (void)initialiseViews {
    self.allowedCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789 "];
    self.maxLength = 16;
    
    self.textField = [[UITextField alloc] init];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.delegate = self;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.placeholder = @"Enter your card number here";
    
    [self.textField addTarget:self action:@selector(editingChanged) forControlEvents:UIControlEventEditingChanged];
    
    [self addSubview:self.textField];
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    self.textField.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.topAnchor constraintEqualToAnchor:self.textField.topAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.textField.bottomAnchor],
        [self.leadingAnchor constraintEqualToAnchor:self.textField.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.textField.trailingAnchor]
    ]];
}

# pragma mark - UIView methods

- (CGSize)intrinsicContentSize {
    return [_textField intrinsicContentSize];
}

# pragma mark - UITextFieldDelegate methods

- (BOOL)            textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)string {
    
    if (![self textContainsDigitsOnly:string]) {
        return NO;
    }
    
    NSString *modifiedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *modifiedTextWithoutSpaces = [modifiedText stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (modifiedTextWithoutSpaces.length <= self.maxLength) {
        return YES;
    } else {
        return NO;
    }
}

# pragma mark - Private methods

- (void)editingChanged {
    NSString *text = self.textField.text;
    NSString *textWithoutSpaces = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *formattedText = [self formatCreditCardNumber:textWithoutSpaces];
    
    if ([text isEqualToString:formattedText]) {
        // nothing do; keep the text as it is
        return;
    }
    
    UITextPosition *beginningOfDocument = self.textField.beginningOfDocument;
    UITextRange *selectedTextRange = self.textField.selectedTextRange;
    
    NSInteger cursorPositionBefore = [self.textField offsetFromPosition:beginningOfDocument
                                                             toPosition:selectedTextRange.start];
    
    self.textField.text = formattedText; // change the text
    
    NSString *originalTextUpToCursor = [text substringToIndex:cursorPositionBefore];
    
    NSUInteger cursorPositionAfter = [CursorPositionCalculator calculateCursorPositionInFormattedText:formattedText
                                                               givenOriginalTextUpToOldCursorPosition:originalTextUpToCursor];
    
    UITextPosition *textPosition = [self.textField positionFromPosition:beginningOfDocument offset:cursorPositionAfter];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // set the 'selectedTextRange' value on the next UI cycle or otherwise it will have no effect
        self.textField.selectedTextRange = [self.textField textRangeFromPosition:textPosition toPosition:textPosition];
    });
}

- (NSString *)formatCreditCardNumber:(NSString *) cardNumber {
    NSMutableString *mutableString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < [cardNumber length]; i++) {
        if (i > 0 && i % 4 == 0) {
            [mutableString appendString:@" "];
        }
        unichar c = [cardNumber characterAtIndex:i];
        [mutableString appendString:[[NSString alloc] initWithCharacters:&c length:1]];
    }
    
    return mutableString;
}

- (BOOL)textContainsDigitsOnly:(NSString *)text {
    for (int i = 0; i < text.length; i++) {
        unichar c = [text characterAtIndex:i];
        if (![self.allowedCharacterSet characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

@end
