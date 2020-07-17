//
//  CreatePostViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "CreatePostViewController.h"
#import "Post.h"
#import <Parse/Parse.h>

@interface CreatePostViewController ()
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextField *captionField;

@end

@implementation CreatePostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (IBAction)postButton:(id)sender {
    [Post createPost:self.captionField.text withTitle:self.titleField.text withCompletion:^(BOOL succeeded, NSError *error){
        [self.delegate didPost];
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)dismissKeyboard {
    [_captionField resignFirstResponder];
    [_titleField resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
