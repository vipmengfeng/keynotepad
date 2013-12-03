//
//  mainViewController.h
//  FeiFeikey
//
//  Created by meng on 13-12-3.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainViewController : UIViewController
- (IBAction)edit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *edit;
@property (weak, nonatomic) IBOutlet UITextView *_textview;
@end
