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
#import "CommentsViewController.h"
#import "CreatePostViewController.h"

@interface HomeFeedViewController () <CreatePostViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *filters;
@property (strong, nonatomic) CommentsViewController *CommentsVC;
@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self queryPosts];
    [self.tableView reloadData];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(queryPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.filters = [NSMutableArray new];
    // Do any additional setup after loading the view.
}

- (NSString *)addToPredicate:(NSString *)predicate withCategory: (NSString *)category withIndex:(int)index {
    NSString *expected = @"";
    if (index > 0){
        expected = [predicate stringByAppendingFormat:@" OR category = '%@'", category];
    } else {
        expected = [NSString stringWithFormat:@"category = '%@'", category];
    }
    return expected;
}

- (IBAction)dormButton:(id)sender {
    UIButton *button = sender;
    [self changeButton:button withName:@"Dorms"];
    [self queryPosts];
    [self.tableView reloadData];
}

- (IBAction)professorsButton:(id)sender {
    UIButton *button = sender;
    [self changeButton:button withName:@"Professors"];
    [self queryPosts];
    [self.tableView reloadData];
}

- (IBAction)foodButton:(id)sender {
    UIButton *button = sender;
    [self changeButton:button withName:@"Food"];
    [self queryPosts];
    [self.tableView reloadData];
}

- (void)changeButton:(UIButton *)button withName: (NSString *)name {
    if (![button isSelected]) {
        [button setSelected:YES];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor lightGrayColor]];
        [self.filters addObject:name];
    } else {
        [button setSelected:NO];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor grayColor]];
        [self.filters removeObject:name];
    }
}

- (void) queryPosts {
    [self.activityIndicator startAnimating];
    NSString *predicateString;
    int i = 0;
    for (NSString *category in self.filters) {
        predicateString = [self addToPredicate:predicateString withCategory:category withIndex:i];
        NSLog(@"%@", predicateString);
        i += 1;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    PFQuery *query = [PFQuery queryWithClassName:@"Post" predicate:predicate];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"likeList"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
        [self animateTable];
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


- (void)tapCommentsButton:(id)sender {
    UIButton *button = (UIButton*)sender;
    self.CommentsVC.post = self.posts[button.tag];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell"];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    cell.commentButton.tag = indexPath.row;
    [cell.commentButton addTarget:self action:@selector(tapCommentsButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)didPost {
    [self queryPosts];
    [self animateTable];
    [self.tableView reloadData];
}

- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error){
        SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        sceneDelegate.window.rootViewController = loginViewController;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqual:@"createPost"]){
        CreatePostViewController *createPostViewController = [segue destinationViewController];
        createPostViewController.delegate = self;
    } else if ([[segue identifier] isEqual:@"comments"]){
        CommentsViewController *commentsViewController = (CommentsViewController *)[segue destinationViewController];
        self.CommentsVC = commentsViewController;
    }
}

- (void)animateTable {
    [self.tableView reloadData];
    NSArray *cells = self.tableView.visibleCells;
    int tableViewHeight = self.tableView.bounds.size.height;
    
    for (PostTableViewCell *cell in cells){
        cell.transform = CGAffineTransformMakeTranslation(0, tableViewHeight);
    }
    
    int delayCounter = 0;
    
    for (PostTableViewCell *cell in cells){
        [UIView animateWithDuration:1.75 delay:(double)delayCounter * 0.05 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:nil];
        delayCounter += 1;
    }
}

@end
