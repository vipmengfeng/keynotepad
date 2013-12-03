//
//  ViewController.m
//  FeiFeikey
//
//  Created by meng on 13-12-2.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import "ViewController.h"
#import "AESCrypt.h"
#import "MBProgressHUD.h"
@interface ViewController ()
{
    
    
    MBProgressHUD *HUD;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    BOOL isfirstuse=[defaults boolForKey:@"isfirstuse"];
    if(!isfirstuse)
    {
        _oldpass.placeholder=@"初始密码为空";
        
    }
}
- (IBAction)button_a:(id)sender
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *password = [defaults valueForKey:@"password"];
    NSString *AESpass =[AESCrypt decrypt:password password:@"pwd"];
    if([__uit.text isEqual:AESpass]){
        [self performSegueWithIdentifier:@"mainViewController" sender:self];
    }else
    {
        __uit.backgroundColor=[UIColor redColor];
        [__uit resignFirstResponder];
    }
    
   
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self._uit) {     //addTextField为该TextField的名称
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SavePassword:(id)sender {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *password = [defaults valueForKey:@"password"];
    NSString *AESpass =[AESCrypt decrypt:password password:@"pwd"];
    if ([_oldpass.text isEqual:AESpass]) {
        if ([_newpassword.text isEqual:_reppassword.text]) {
            _reppassword.enabled=FALSE;
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.labelText = @"操作成功";
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.customView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
            [HUD showAnimated:YES whileExecutingBlock:^{
                NSString *aespassword=[AESCrypt encrypt:_newpassword.text password:@"pwd"];
                [defaults setValue:aespassword forKey:@"password"];
                [defaults setBool:YES forKey:@"isfirstuse"];
                [defaults synchronize];
                
            } completionBlock:^{
                [HUD removeFromSuperview];
                HUD = nil;
                _reppassword.enabled=TRUE;
            }];
        }else{
        
            _reppassword.backgroundColor=[UIColor redColor];
            [_reppassword resignFirstResponder];
        }
        
    }else
    {
        _oldpass.backgroundColor=[UIColor redColor];
        [_oldpass resignFirstResponder];
    }
    
}
@end
