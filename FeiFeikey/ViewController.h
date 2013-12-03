//
//  ViewController.h
//  FeiFeikey
//
//  Created by meng on 13-12-2.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
-(IBAction)button_a:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *oldpass;
- (IBAction)SavePassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *newpassword;
@property (weak, nonatomic) IBOutlet UITextField *reppassword;

@property (weak, nonatomic) IBOutlet UITextField *_uit;
@end
