//
//  Message.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/20/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "Message.h"
#import <Parse/Parse.h>

@implementation Message

@dynamic receiver;
@dynamic sender;
@dynamic text;
@dynamic GIF;

+ (nonnull NSString *)parseClassName {
    return @"Message";
}

+ (void) createMessage:(NSString *)text withReceiver:(PFUser *)receiver withGIF:(NSString *)GIF withCompletion:(PFBooleanResultBlock)completion {
    Message *newMessage = [Message new];
    newMessage.text = text;
    newMessage.receiver = receiver;
    newMessage.sender = [PFUser currentUser];
    newMessage.GIF = GIF;
    
    [newMessage saveInBackgroundWithBlock:completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
