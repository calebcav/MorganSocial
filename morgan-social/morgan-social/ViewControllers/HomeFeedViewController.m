//
//  HomeFeedViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "HomeFeedViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"

@interface HomeFeedViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self queryPosts];
    [self.tableView reloadData];
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


- (void) queryPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error){
        if (posts != nil) {
            self.posts = posts;
        }
        else {
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
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell"];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


@end
