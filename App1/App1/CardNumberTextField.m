//
//  CardNumberTextView.m
//  App1
//
//  Created by Adil Hussain on 17/05/2023.
//

#import "CardNumberTextField.h"

@interface CardNumberTextField () <UITextFieldDelegate>

@property(nonnull, nonatomic) UITextField *textField;

@end

@implementation CardNumberTextField

- (NSString *)cardNumber {
    return [self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

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
    self.textField = [[UITextField alloc] init];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.delegate = self;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.placeholder = @"Enter your card number here";
    
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

- (CGSize)intrinsicContentSize {
    return [_textField intrinsicContentSize];
}

# pragma mark - UITextFieldDelegate methods

// TODO: Limit the input to 16 digits maximum
- (BOOL)            textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)string {
    
    NSString *modifiedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *modifiedTextWithoutSpaces = [modifiedText stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *formattedText = [self formatCreditCardNumber:modifiedTextWithoutSpaces];
    
    if ([modifiedText isEqualToString:formattedText]) {
        return YES;
    } else {
        textField.text = formattedText;
        return NO;
    }
}

# pragma mark - Private methods

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

@end
