//
//  SettingsViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/15/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//
#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>
#import <MaterialSnackbar.h>
@import Parse;
@interface SettingsViewController ()

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) IBOutlet PFImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UITextField *profileFirstName;
@property (strong, nonatomic) IBOutlet UITextField *profileLastName;
@property (strong, nonatomic) IBOutlet UITextField *profileMajor;
@property (strong, nonatomic) NSArray *majorList;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedClasses;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = PFUser.currentUser;
    self.profileFirstName.text = self.user[@"firstName"];
    self.profileLastName.text = self.user[@"lastName"];
    self.profileMajor.text = self.user[@"major"];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.hidden = true;
    self.profileMajor.delegate = self;
    self.profilePicture.file = self.user[@"picture"];
    [self.profilePicture loadInBackground];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2.2;
    self.profilePicture.clipsToBounds = YES;
    [self defaultClass];
    self.majorList = @[@"Accounting", @"Acturial Science", @"Applied Liberal Studies", @"Architecture and Environmental Design", @"Biology", @"Business Administration",
                       @"Chemistry", @"Cloud Computing", @"Computer Science", @"Construction Management", @"Economics", @"Elementary Education", @"English",
                       @"Entrepreneurship", @"Civil Engineering", @"Electrical and Computering Engineering", @"Industrial Engineering", @"Transportation Systems Engineering",
                    @"Family Consumer Sciences", @"Finance", @"Fine Arts", @"Foreign Languages", @"History and Georgraphy", @"Hospitality Management", @"Information Systems",
                    @"Interior Design", @"Management", @"Marketing", @"Mathematics", @"Medical Technology", @"Military Science", @"Music", @"Multimedia Journalism", @"Multi-Platform Production", @"Nursing", @"Nutritional Science", @"Philosophy and Religious Studies", @"Physics and Engineering Physics", @"Political Science",
                    @"Psychology", @"Screenwriting & Animation", @"Services and Supply Chain Management", @"Social Work", @"Sociology and Anthropology", @"Strategic and Communication",
                    @"Theater Arts", @"Transportation Systems", @"Visual Arts"];
    [self.profileFirstName addTarget:self action:@selector(snackBarSavePopUp) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view.
}

- (void)defaultClass {
    NSArray *class = @[@"Freshman", @"Sophomore", @"Junior", @"Senior"];
    for (int i = 0; i < class.count; i ++){
        if ([self.user[@"classification"] isEqualToString:class[i]]) {
            self.segmentedClasses.selectedSegmentIndex = i;
        }
    }
}

- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error){
        SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        sceneDelegate.window.rootViewController = loginViewController;
    }];
}

- (void)snackBarSavePopUp {
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
    MDCSnackbarMessage *answerMessage = [[MDCSnackbarMessage alloc] init];
    answerMessage.text = @"A lot";
    [MDCSnackbarManager showMessage:answerMessage];
    action.title = @"Answer";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.majorList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.majorList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.profileMajor.text = self.majorList[row];
    self.pickerView.hidden = true;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.pickerView.hidden = false;
    return false;
}

@end
