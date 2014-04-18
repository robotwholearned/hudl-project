//
//  UsernameViewController.m
//  hudl
//
//  Created by Cassandra Sandquist on 2014-04-17.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "UsernameViewController.h"

@interface UsernameViewController ()

@end

@implementation UsernameViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    usernameTextfield.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    ProfileViewController* profileViewController = [segue destinationViewController];

    if ([usernameTextfield.text isEqualToString:@""]) {
        profileViewController.username = @"robotwholearned";
        [[[UIAlertView alloc] initWithTitle:@"Oh Boy"
                                    message:@"Next time try typing in a twitter handle, you can use mine for now :)"
                                   delegate:self
                          cancelButtonTitle:@"Okay!"
                          otherButtonTitles:nil] show];
    } else {
        profileViewController.username = usernameTextfield.text;
    }

    //[profileViewController setUsername:usernameTextfield.text];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches
              withEvent:event];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    NSLog(@"textFieldShouldBeginEditing");
    textField.backgroundColor = [UIColor colorWithRed:220.0f / 255.0f
                                                green:220.0f / 255.0f
                                                 blue:220.0f / 255.0f
                                                alpha:1.0f];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField*)textField
{
    NSLog(@"textFieldShouldEndEditing");
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
