//
//  mainViewController.m
//  FeiFeikey
//
//  Created by meng on 13-12-3.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import "mainViewController.h"
#import "AESCrypt.h"
#import "MBProgressHUD.h"
@interface mainViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
     __textview.editable=false;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *contents = [defaults objectForKey:@"contents"];
    NSString *aescontents=[AESCrypt decrypt:contents password:@"pwd"];
    __textview.text=aescontents;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender {
  
   
    [_edit setTitle:@"保存" forState:UIControlStateNormal];
    __textview.editable=TRUE;
    [__textview becomeFirstResponder];
    __textview.backgroundColor=[UIColor colorWithRed:255/255.0 green:250/255.0 blue:205/255.0 alpha:1];
    
    [_edit removeTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [_edit addTarget:self action:@selector(process:)forControlEvents:UIControlEventTouchUpInside];
}
-(IBAction)process:(id)sender
{
    [_edit setTitle:@"编辑" forState:UIControlStateNormal];
   
    __textview.editable=false;
    __textview.backgroundColor=[UIColor whiteColor];
    [_edit removeTarget:self action:@selector(process:) forControlEvents:UIControlEventTouchUpInside];
    [_edit addTarget:self action:@selector(edit:)forControlEvents:UIControlEventTouchUpInside];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    //如果设置此属性则当前的view置于后台
    //HUD.dimBackground = YES;
    
    //设置对话框文字
    HUD.labelText = @"请稍等";
    
    //显示对话框
    [HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *content= __textview.text;
        NSString *aescontent=[AESCrypt encrypt:content password:@"pwd"];
        [defaults setValue:aescontent forKeyPath:@"contents"];
        [defaults synchronize];

    } completionBlock:^{
        //操作执行完后取消对话框
        [HUD removeFromSuperview];
        HUD = nil;
    }];
    }
@end
