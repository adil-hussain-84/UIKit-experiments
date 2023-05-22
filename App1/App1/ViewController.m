//
//  ViewController.m
//  App1
//
//  Created by Adil Hussain on 17/05/2023.
//

#import "ViewController.h"
#import "CardNumberTextField.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CardNumberTextField *cardNumberTextField;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showCardNumberButtonTapped:(id)sender {
    NSString *cardNumber = self.cardNumberTextField.cardNumber;
    
    NSString *message;
    
    if (cardNumber.length > 0) {
        message = [NSString stringWithFormat:@"Your card number without spaces is %@.", cardNumber];
    } else {
        message = @"You have not entered a card number.";
    }
    
    [self displayAlertWithTitle:@"Card Number" message:message];
}

- (void)displayAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:dismissAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
