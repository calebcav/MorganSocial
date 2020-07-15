//
//  SettingsViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/15/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "SettingsViewController.h"
#import <Parse/Parse.h>
@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *majorField;
@property (strong, nonatomic) IBOutlet UITextField *classificationField;
@property (strong, nonatomic) PFUser *user;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = PFUser.currentUser;
    self.majorField.text = self.user[@"major"];
    self.classificationField.text = self.user[@"classification"];
    // Do any additional setup after loading the view.
}
- (IBAction)saveButton:(id)sender {
    self.user[@"major"] = self.majorField.text;
    self.user[@"classification"] = self.classificationField.text;
    [self.user saveInBackground];
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:@"Saved!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler: ^ (UIAlertAction *_Nonnull action){
    }];
    [alertvc addAction:action];
    [self presentViewController:alertvc animated:true completion:nil];
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
