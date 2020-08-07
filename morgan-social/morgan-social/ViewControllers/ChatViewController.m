//
//  ChatViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "ChatViewController.h"
#import "Message.h"
#import <Parse/Parse.h>
#import "SenderTableViewCell.h"
#import "ReceiverTableViewCell.h"
#import "ReceiverGIFTableViewCell.h"
#import "SenderGIFTableViewCell.h"
@import GiphyCoreSDK;
@import GiphyUISDK;
@interface ChatViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) IBOutlet UITextField *messageField;
@property (strong, nonatomic) NSString *gifURL;

@end

@implementation ChatViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UITapGestureRecognizer *const tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self queryMessages];
    //[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(reloadTable) userInfo:nil repeats:YES];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.messageField.delegate = self;
    self.navigationItem.title = [self.friend[@"firstName"] stringByAppendingFormat:@" %@", self.friend[@"lastName"]];
    [self.tableView reloadData];
    //self.tableView.transform = CGAffineTransformMakeScale(1, -1);
    
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
    query.limit = 30;
    [query orderByAscending:@"createdAt"];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
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
    [Message createMessage:self.messageField.text withReceiver:self.friend withGIF:nil withCompletion:^(BOOL succeeded, NSError *error){
        [self queryMessages];
        [self.tableView reloadData];
        self.messageField.text = @"";
    }];
}

- (IBAction)gifButton:(id)sender {
    GiphyViewController *giphy = [GiphyViewController new];
    giphy.layout = GPHGridLayoutWaterfall;
    giphy.theme = [GPHTheme new];
    giphy.rating = GPHRatingTypeRatedPG13;
    giphy.delegate = self;
    giphy.showConfirmationScreen = true;
    [giphy setMediaConfigWithTypes: [ [NSMutableArray alloc] initWithObjects:
    @(GPHContentTypeGifs),@(GPHContentTypeStickers), @(GPHContentTypeText),@(GPHContentTypeEmoji), nil] ];
    [self presentViewController:giphy animated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didSelectMediaWithGiphyViewController:(GiphyViewController *)giphyViewController media:(GPHMedia *)media {
    [Message createMessage:nil withReceiver:self.friend withGIF:media.id withCompletion:^(BOOL succeeded, NSError *error){
        [self queryMessages];
        [self.tableView reloadData];
    }];
    [giphyViewController dismissViewControllerAnimated:true completion:nil];
}

- (void)didDismissWithController:(GiphyViewController *)controller {
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Message *message = self.messages[indexPath.row];
    ReceiverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiverTableViewCell"];
    if ([message.sender.username isEqualToString:PFUser.currentUser.username]) {
        if (message.text != nil){
            SenderTableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"SenderTableViewCell"];
            otherCell.backgroundColor = [UIColor clearColor];
            otherCell.message = message;
            return otherCell;
        } else {
            SenderGIFTableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"SenderGIFTVC"];
            otherCell.message = message;
            return otherCell;
        }
    } else {
        if (message.text != nil) {
            ReceiverTableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"ReceiverTableViewCell"];
            otherCell.backgroundColor = [UIColor clearColor];
            otherCell.message = message;
            return otherCell;
        } else {
            ReceiverGIFTableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"ReceiverGIFTVC"];
            otherCell.message = message;
            return otherCell;
        }
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

@end
