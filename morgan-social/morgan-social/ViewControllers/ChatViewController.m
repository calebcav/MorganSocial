//
//  ChatViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
#import "Message.h"
#import <Parse/Parse.h>
@interface ChatViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) IBOutlet UITextField *messageField;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    UITapGestureRecognizer *const tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self queryMessages];
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(reloadTable) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
}

- (void)reloadTable {
    [self queryMessages];
    [self.tableView reloadData];
}

-(void)dismissKeyboard {
    [_messageField resignFirstResponder];
}

- (void)queryMessages {
    NSPredicate *const matchingUsers = [NSPredicate predicateWithFormat:@"(receiver = %@ AND sender = %@) OR (receiver = %@ AND sender = %@)", PFUser.currentUser, self.friend, self.friend, PFUser.currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Message" predicate:matchingUsers];
    [query orderByAscending:@"createdAt"];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error){
        if (messages != nil) {
            self.messages = messages;
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
}

- (IBAction)sendButton:(id)sender {
    [Message createMessage:self.messageField.text withReceiver:self.friend withCompletion:^(BOOL succeeded, NSError *error){
        [self queryMessages];
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
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTableViewCell"];
    Message *message = self.messages[indexPath.row];
    cell.message = message;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}


@end
