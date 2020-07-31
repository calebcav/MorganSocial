//
//  CreatePostViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "CreatePostViewController.h"
#import "ChooseLocationViewController.h"
#import "Post.h"
#import "Address.h"
#import <Parse/Parse.h>

@interface CreatePostViewController () <ChooseLocationViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextField *captionField;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *const categories;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) Address *address;
@end

@implementation CreatePostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.categories = @[@"Food", @"Dorms", @"Professors"];
    self.category = @"Food";
    // Do any additional setup after loading the view.
}

- (void)addressFields:(nonnull Address *)address {
    self.address = address;
}

- (IBAction)postButton:(id)sender {
    [Post createPost:self.captionField.text withTitle:self.titleField.text withCategory:self.category withAddress:self.address withCompletion:^(BOOL succeeded, NSError *error){
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.categories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.categories[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.category = self.categories[row];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ChooseLocationViewController *chooseLocationViewController = [segue destinationViewController];
    chooseLocationViewController.delegate = self;
}

@end
