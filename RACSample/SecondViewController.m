//
//  SecondViewController.m
//  RACSample
//
//  Created by Kosuke Ogawa on 2015/12/25.
//  Copyright © 2015年 koogawa. All rights reserved.
//

#import "SecondViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *eMail;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    RACSignal *samePasswordSignal =
    [RACSignal combineLatest:@[ self.password1.rac_textSignal,
                                self.password2.rac_textSignal]
                      reduce:^(NSString *password,
                               NSString *passwordVerification) {
                          return @([password isEqual:passwordVerification]);
                      }];
    
    RACSignal *passwordLengthSignal =
    [RACSignal combineLatest:@[ self.password1.rac_textSignal]
                      reduce:^(NSString *password) {
                          return @([password length] >= 8);
                      }];

    RACSignal *formValidSignal =
    [RACSignal combineLatest:@[ self.userName.rac_textSignal,
                                self.eMail.rac_textSignal,
                                samePasswordSignal,
                                passwordLengthSignal]
                      reduce:^(NSString *username,
                               NSString *email,
                               NSNumber *samePassword,
                               NSNumber *passwordLength) {
                          NSLog( @"%@,%@,%@,%@",
                                username,
                                email,
                                samePassword,
                                passwordLength);
                          
                          return @([username length] > 0 &&
                          [email length] > 0 &&
                          [samePassword boolValue] &&
                          [passwordLength boolValue]);
                      }];
    
    RAC(self.createButton, enabled) = formValidSignal;
    
    RACSignal *passwordValidSignal =
    [RACSignal combineLatest:@[ samePasswordSignal,
                                passwordLengthSignal]
                      reduce:^(NSNumber *samePassword,
                               NSNumber *passwordLength) {
                          NSString *message = @"";
                          if( ![passwordLength boolValue]){
                              message = @"need 8 char.";
                          }
                          if( ![samePassword boolValue] ){
                              message = @"need same password";
                          }
                          return message;
                      }];
    RAC(self.messageLabel,text) = passwordValidSignal;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
