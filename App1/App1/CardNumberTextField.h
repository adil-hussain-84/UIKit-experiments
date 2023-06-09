//
//  CardNumberTextView.h
//  App1
//
//  Created by Adil Hussain on 17/05/2023.
//

@import UIKit;

/// A custom view for users to enter payment card numbers into.
///
/// This view looks like a `UITextField` but formats the text entered into it by the user
/// such that a space is shown after every fourth digit and the input is limited to 16 digits.
@interface CardNumberTextField : UIView

/// The digits entered into the view by the user
/// (i.e. without the spaces that the view may have added to itself automatically for display purposes).
@property(nonnull, nonatomic, readonly, copy) NSString *cardNumber;

@end
