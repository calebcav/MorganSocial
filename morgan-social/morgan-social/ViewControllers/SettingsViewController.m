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
@import Parse;
@interface SettingsViewController ()

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) IBOutlet PFImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UITextField *profileFirstName;
@property (strong, nonatomic) IBOutlet UITextField *profileLastName;
@property (strong, nonatomic) IBOutlet UITextField *profileMajor;
@property (strong, nonatomic) IBOutlet UITextField *profileClass;
@property (strong, nonatomic) UIPickerView *majorPickerView;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = PFUser.currentUser;
    self.profileFirstName.text = self.user[@"firstName"];
    self.profileLastName.text = self.user[@"lastName"];
    self.profileClass.text = self.user[@"classification"];
    self.profileMajor.text = self.user[@"major"];
    self.majorPickerView.delegate = self;
    self.majorPickerView.dataSource = self;
    
    // Do any additional setup after loading the view.
}

- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error){
        SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        sceneDelegate.window.rootViewController = loginViewController;
    }];
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
