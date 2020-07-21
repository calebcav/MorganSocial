//
//  SearchFriendViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "SearchFriendViewController.h"
#import <Parse/Parse.h>
#import "FriendsTableViewCell.h"
#import "ChatViewController.h"

@interface SearchFriendViewController ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *friends;
@property (strong, nonatomic) NSArray *filteredFriends;
@property (strong, nonatomic) NSMutableArray *friendNames;
@property (nonatomic) NSInteger friendsListSize;
@end

@implementation SearchFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    [self queryFriends];
    [self.tableView reloadData];
}

- (void) queryFriends {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" notEqualTo:PFUser.currentUser.objectId];
    [query includeKey:@"username"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *friends, NSError *error){
        if (friends != nil){
            self.friends = friends;
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    PFUser *user = self.friends[indexPath.row];
    ChatViewController *chatViewController = [segue destinationViewController];
    chatViewController.friend = user;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsTableViewCell"];
    PFUser *user = self.friends[indexPath.row];
    cell.user = user;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}


@end
