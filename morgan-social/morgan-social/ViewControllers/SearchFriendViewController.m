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
@property (strong, nonatomic) NSArray *friendNames;
@property (strong, nonatomic) NSArray *data;
@end

@implementation SearchFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self queryFriends];
    [self.tableView reloadData];
    
}

- (void)makeFriendNameList {
    NSMutableArray *temp = [NSMutableArray new];
    for (PFUser *friend in self.friends) {
        [temp addObject:friend.username];
    }
    self.friendNames = [temp copy];
}

- (void)createFilteredFriends {
    NSMutableArray *temp = [NSMutableArray new];
    for (PFUser *user in self.friends){
        if ([self.friendNames containsObject:user.username]) {
            [temp addObject:user];
        }
    }
    self.filteredFriends = [temp copy];
}

- (void)queryFriends {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" notEqualTo:PFUser.currentUser.objectId];
    [query includeKey:@"username"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *friends, NSError *error){
        if (friends != nil){
            self.friends = friends;
            self.filteredFriends = friends;
            [self makeFriendNameList];
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
    PFUser *user = self.filteredFriends[indexPath.row];
    cell.user = user;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredFriends.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject containsString:searchText];
        }];
        self.friendNames = [self.friendNames filteredArrayUsingPredicate:predicate];
        [self createFilteredFriends];
        [self makeFriendNameList];
    }
    else {
        self.filteredFriends = self.friends;
        [self makeFriendNameList];
    }
    [self.tableView reloadData];
}

@end
