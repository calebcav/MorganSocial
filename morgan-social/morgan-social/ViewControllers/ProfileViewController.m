//
//  ProfileViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "UserProfileTableViewCell.h"
#import "Post.h"
@import Parse;

@interface ProfileViewController ()

@property (strong, nonatomic) IBOutlet PFImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *profileUsername;
@property (strong, nonatomic) IBOutlet UILabel *profileMajor;
@property (strong, nonatomic) IBOutlet UILabel *profileClassification;
@property (strong, nonatomic) IBOutlet UILabel *profileFullName;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self queryPosts];
    [self.tableView reloadData];
    self.user = PFUser.currentUser;
    self.profileUsername.text = [@"@" stringByAppendingFormat:@"%@", self.user.username];
    self.profilePicture.file = self.user[@"picture"];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
    self.profileMajor.text = self.user[@"major"];
    self.profileClassification.text = self.user[@"classification"];
    [self.profilePicture loadInBackground];
    [self.user saveInBackground];
    self.profileFullName.text = [self.user[@"firstName"] stringByAppendingFormat:@" %@", self.user[@"lastName"]];
}

- (void)queryPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:PFUser.currentUser];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"address"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error){
        if (posts != nil) {
            self.posts = posts;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.tableView reloadData];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UserProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileTableViewCell"];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

@end
