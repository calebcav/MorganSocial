//
//  CommentsViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/16/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "CommentsViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "Comment.h"
#import "CommentTableViewCell.h"

@interface CommentsViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *commentField;
@property (strong, nonatomic) NSArray *comments;
@end

@implementation CommentsViewController

/*
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self){
     self.post = [Post new];
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    [self queryPosts];
    // Do any additional setup after loading the view.
}

- (IBAction)sendButton:(id)sender {
    [Comment createComment:self.commentField.text withPostID:self.post.objectId withCompletion:^(BOOL succeeded, NSError *error){
        //self.post.commentCount += @1;
    }];
    self.post.commentCount += 1;
    [self.post saveInBackground];
    [self queryPosts];
    [self.tableView reloadData];
}

- (void) queryPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"postID" equalTo:self.post.objectId];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error){
        if (comments != nil) {
            self.comments = comments;
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
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
    Comment *comment = self.comments[indexPath.row];
    cell.comment = comment;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

@end
