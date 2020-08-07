//
//  SearchUserViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 8/7/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "SearchUserViewController.h"
#import <Parse/Parse.h>
#import "SearchUserTableViewCell.h"
#import "OtherUserViewController.h"
@import Parse;
@interface SearchUserViewController ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) NSArray *filteredUsers;
@property (strong, nonatomic) NSArray *usernames;

@end

@implementation SearchUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self queryUsers];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)queryUsers {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" notEqualTo:PFUser.currentUser.objectId];
    [query includeKey:@"username"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error){
        if (users != nil){
            self.users = users;
            self.filteredUsers = users;
            [self makeUserNameList];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
}

- (void)makeUserNameList {
    NSMutableArray *temp = [NSMutableArray new];
    for (PFUser *user in self.users) {
        [temp addObject:user.username];
    }
    self.usernames = [temp copy];
}

- (void)createFilteredUsers {
    NSMutableArray *temp = [NSMutableArray new];
    for (PFUser *user in self.users){
        if ([self.usernames containsObject:user.username]) {
            [temp addObject:user];
        }
    }
    self.filteredUsers = [temp copy];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    PFUser *user = self.users[indexPath.row];
    OtherUserViewController *otherUsersViewController = [segue destinationViewController];
    otherUsersViewController.user = user;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SearchUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchUserTVC"];
    PFUser *user = self.filteredUsers[indexPath.row];
    cell.user = user;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredUsers.count;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject containsString:searchText];
        }];
        self.usernames = [self.usernames filteredArrayUsingPredicate:predicate];
        [self createFilteredUsers];
        [self makeUserNameList];
    }
    else {
        self.filteredUsers = self.users;
        [self makeUserNameList];
    }
    [self.tableView reloadData];
}

@end
