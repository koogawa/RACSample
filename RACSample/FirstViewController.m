//
//  FirstViewController.m
//  RACSample
//
//  Created by Kosuke Ogawa on 2015/12/25.
//  Copyright © 2015年 koogawa. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *eMail;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.userName addTarget:self
                      action:@selector(updateButtonEnable:)
            forControlEvents:UIControlEventEditingChanged];
    [self.eMail addTarget:self
                   action:@selector(updateButtonEnable:)
         forControlEvents:UIControlEventEditingChanged];
    [self.password1 addTarget:self
                       action:@selector(updateButtonEnable:)
             forControlEvents:UIControlEventEditingChanged];
    [self.password2 addTarget:self
                       action:@selector(updateButtonEnable:)
             forControlEvents:UIControlEventEditingChanged];

    // Password message
    [self.password1 addTarget:self
                       action:@selector(updatePasswordMessage:)
             forControlEvents:UIControlEventEditingChanged];
    [self.password2 addTarget:self
                       action:@selector(updatePasswordMessage:)
             forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateButtonEnable:(UITextField *)field
{
    self.createButton.enabled =
    [self.userName.text length] > 0 &&
    [self.eMail.text length] > 0 &&
    [self.password1.text length] >= 8 &&
    [self.password1.text isEqual:self.password2.text];
    
}

-(void)updatePasswordMessage:(UITextField *)field
{
    NSString *message = @"";
    if( [self.password1.text length] < 8){
        message = @"need 8 char.";
    }
    if( ![self.password1.text isEqualToString:self.password2.text] ){
        message = @"need same password";
    }
    self.messageLabel.text = message;
}

@end
