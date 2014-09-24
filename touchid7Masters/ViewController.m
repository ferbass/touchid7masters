//
//  ViewController.m
//  touchid7Masters
//
//  Created by Fernando Ribeiro on 9/24/14.
//  Copyright (c) 2014 Fernando Bass. All rights reserved.
//

#import "ViewController.h"

@import LocalAuthentication;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *touchIDStatus;
@property (weak, nonatomic) IBOutlet UIButton *unlockButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
   
    BOOL success = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (success) {
        self.touchIDStatus.text = @"TOUCH ID DISPONIVEL";
        self.unlockButton.enabled = YES;
    } else {
        self.touchIDStatus.text = @"DEVICE SEM TOUCH ID";
        self.unlockButton.enabled = NO;
    }
    
    [super viewDidLoad];
}


- (IBAction)unlock:(id)sender {
    
    LAContext *context = [[LAContext alloc] init];
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Autenticação por TouchID" reply:
     ^(BOOL success, NSError *authenticationError) {
         if (success) {
             [self performSegueWithIdentifier:@"unlockSegue" sender:nil];
         } else {
             NSLog(@"FALHA AO AUTENTICAR");
         }
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
