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

@interface SearchFriendViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *friends;
@end

@implementation SearchFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self queryFriends];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void) queryFriends {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" notEqualTo:PFUser.currentUser.objectId];
    [query includeKey:@"username"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *friends, NSError *error){
        if (friends != nil){
            self.friends = friends;
            NSLog(@"%lu", self.friends.count);
            NSLog(@"%lu", friends.count);
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
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsTableViewCell"];
    PFUser *user = self.friends[indexPath.row];
    cell.user = user;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}


@end
