//
//  OtherUserViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 8/7/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "OtherUserViewController.h"
#import "OtherUserTableViewCell.h"
#import <Parse/Parse.h>
@import Parse;
@interface OtherUserViewController ()
@property (strong, nonatomic) IBOutlet PFImageView *userPicture;
@property (strong, nonatomic) IBOutlet UILabel *userFullName;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *userMajor;
@property (strong, nonatomic) IBOutlet UILabel *userClass;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation OtherUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.userPicture.file = self.user[@"picture"];
    self.userFullName.text = [self.user[@"firstName"] stringByAppendingFormat:@" %@",self.user[@"lastName"]];
    self.username.text = [@"@" stringByAppendingFormat:@"%@", self.user.username];
    self.userMajor.text = self.user[@"major"];
    self.userClass.text = self.user[@"classification"];
    self.userPicture.layer.cornerRadius = self.userPicture.frame.size.width / 2;
    self.userPicture.clipsToBounds = YES;
    [self queryPosts];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
*/

- (void)queryPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:self.user];
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

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    OtherUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherUserTVC"];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


@end
