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

- (CGSize)intrinsicContentSize {
    return [_textField intrinsicContentSize];
}

# pragma mark - UITextFieldDelegate methods

- (BOOL)            textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)string {
    
    NSString *modifiedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *modifiedTextWithoutSpaces = [modifiedText stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (modifiedTextWithoutSpaces.length <= 16) {
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
    
    self.textField.text = formattedText;
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

@end
