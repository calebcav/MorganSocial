//
//  ProfileViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
@import Parse;
@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet PFImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *profileUsername;
@property (strong, nonatomic) IBOutlet UILabel *profileMajor;
@property (strong, nonatomic) IBOutlet UILabel *profileClassification;
@property (strong, nonatomic) IBOutlet UILabel *profileFullName;
@property (strong, nonatomic) PFUser *user;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.user = PFUser.currentUser;
    self.profileUsername.text = [@"@" stringByAppendingFormat:self.user.username];
    self.profilePicture.file = self.user[@"picture"];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
    self.profileMajor.text = self.user[@"major"];
    self.profileClassification.text = self.user[@"classification"];
    [self.profilePicture loadInBackground];
    [self.user saveInBackground];
    self.profileFullName.text = [self.user[@"firstName"] stringByAppendingFormat:@" %@", self.user[@"lastName"]];
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
