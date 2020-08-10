//
//  SignupViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>
#import <MaterialSnackbar.h>
@interface SignupViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *majorField;
@property (strong, nonatomic) IBOutlet UIPickerView *majorPickerView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedClass;
@property (strong, nonatomic) NSArray *majorList;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.majorPickerView.delegate = self;
    self.majorPickerView.dataSource = self;
    self.majorField.delegate = self;
    self.majorPickerView.hidden = true;
    self.majorList = @[@"Accounting", @"Acturial Science", @"Applied Liberal Studies", @"Architecture and Environmental Design", @"Biology", @"Business Administration",
       @"Chemistry", @"Cloud Computing", @"Computer Science", @"Construction Management", @"Economics", @"Elementary Education", @"English",
       @"Entrepreneurship", @"Civil Engineering", @"Electrical and Computering Engineering", @"Industrial Engineering", @"Transportation Systems Engineering",
    @"Family Consumer Sciences", @"Finance", @"Fine Arts", @"Foreign Languages", @"History and Georgraphy", @"Hospitality Management", @"Information Systems",
    @"Interior Design", @"Management", @"Marketing", @"Mathematics", @"Medical Technology", @"Military Science", @"Music", @"Multimedia Journalism", @"Multi-Platform Production", @"Nursing", @"Nutritional Science", @"Philosophy and Religious Studies", @"Physics and Engineering Physics", @"Political Science",
    @"Psychology", @"Screenwriting & Animation", @"Services and Supply Chain Management", @"Social Work", @"Sociology and Anthropology", @"Strategic and Communication",
    @"Theater Arts", @"Transportation Systems", @"Visual Arts"];
    
    // Do any additional setup after loading the view.
}

//calebc@morgan.edu

- (IBAction)signupButton:(id)sender {
    NSArray *class = @[@"Freshman", @"Sophomore", @"Junior", @"Senior"];
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    newUser.email = self.emailField.text;
    newUser[@"firstName"] = self.firstNameField.text;
    newUser[@"lastName"] = self.lastNameField.text;
    newUser[@"major"] = self.majorField.text;
    newUser[@"classification"] = class[self.segmentedClass.selectedSegmentIndex];
    if ([self checkAllFields]){
        long lengthOfEmail = self.emailField.text.length - 11;
        if ([[self.emailField.text substringFromIndex:lengthOfEmail] isEqualToString:@"@morgan.edu"]){
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                if (error != nil) {
                    NSLog(@"Error: %@", error.localizedDescription);
                } else {
                    NSLog(@"User registered successfully");
                    [self dismissViewControllerAnimated:true completion:nil];
                }
            }];
        } else {
            MDCSnackbarMessage *message = [MDCSnackbarMessage new];
            message.text = @"The email you are using is not a Morgan.edu email address";
            [MDCSnackbarManager showMessage:message];
        }
        
    } else {
        MDCSnackbarMessage *message = [MDCSnackbarMessage new];
        message.text = @"All of the fields' haven't been filled";
        [MDCSnackbarManager showMessage:message];
    }
    
}

- (Boolean)checkAllFields {
    if ([self.usernameField.text isEqualToString:@""]){
        return false;
    }
    if ([self.passwordField.text isEqualToString:@""]){
        return false;
    }
    if ([self.emailField.text isEqualToString:@""]){
        return false;
    }
    if ([self.firstNameField.text isEqualToString:@""]){
        return false;
    }
    if ([self.majorField.text isEqualToString:@""]){
        return false;
    }
    return true;
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.majorList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.majorList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.majorField.text = self.majorList[row];
    self.majorPickerView.hidden = true;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.majorPickerView.hidden = false;
    return false;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
