//
//  loginViewController.m
//  Demo
//
//  Created by Mac on 2018/5/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "loginViewController.h"
#import <MBProgressHUD.h>
#import "TrimWhitespace.h"
#import "AccountDao.h"
@interface loginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextfield;
@property(strong,nonatomic) MBProgressHUD* HUD;



@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//弹出提示
-(void)showHUD:(NSString*)text{
    
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.HUD];
    self.HUD.labelText = text;
    self.HUD.mode = MBProgressHUDModeText;
    
    self.HUD.yOffset = 100.0f;
    self.HUD.xOffset = 0.0f;
    
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1.5);
    } completionBlock:^{
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }];
    
    
}


//验证手机号
- (BOOL)verifyMobile{
    NSString *userName=self.userAccountTextField.text;
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:userName] == YES)
        || ([regextestcm evaluateWithObject:userName] == YES)
        || ([regextestct evaluateWithObject:userName] == YES)
        || ([regextestcu evaluateWithObject:userName] == YES))
    {
        return YES;
    }
    else
    {
        [self showHUD:@"请输入正确手机号"];
        return NO;
    }
    
    return YES;
    
}


//验证登录用户名和密码  success YES   fail  NO
-(BOOL)validateLoginDataWith:(NSString*)userName andPassword:(NSString*)passWord{
    
    if([TrimWhitespace isNullOrEmptyOrWhiteSpace:userName]){
        [self showHUD:@"请输入用户名"];
        return NO;
    }
    
    if([TrimWhitespace isNullOrEmptyOrWhiteSpace:passWord]){
        [self showHUD:@"请输入密码"];
        return NO;
    }
    
    
    return YES;
}

//触摸退出键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.userAccountTextField resignFirstResponder];
    [self.userPasswordTextfield resignFirstResponder];
}

-(IBAction)loginButtonAction:(id)sender{
    NSString *userName=self.userAccountTextField.text;
    NSString *passWord=self.userPasswordTextfield.text;
    
    
    //验证手机号
    if(![self verifyMobile])  return;
    
    if(![self validateLoginDataWith:userName andPassword:passWord]) return;
    
    if([userName isEqualToString:@""]||[passWord isEqualToString:@""]){
        [self showHUD:@"用户和密码不能为空"];
        return;
    }else{        
        AccountDao *account=[[AccountDao alloc]init];
        [account loginWith:userName Password:passWord successHander:^(userInfo *account) {
            [self showHUD:@"登录成功"];
        } errorHandler:^(NSString *code, NSString *message) {
            [self showHUD:@"登录失败，账号或密码错误"];

        }];
    }
}


@end
