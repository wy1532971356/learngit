//
//  registerOneViewController.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "registerOneViewController.h"
#import <MBProgressHUD.h>
#import <SMS_SDK/SMSSDK.h>
#import "AccountDao.h"
#import "AppDelegate.h"


@interface registerOneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userAccountTextfield;

- (IBAction)getVerficationCodeBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property(strong,nonatomic) MBProgressHUD *HUD;

@property(strong,nonatomic)NSString *phoneNum;


@end

@implementation registerOneViewController

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

//获取验证码
- (IBAction)getVerficationCodeBtn:(id)sender {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.userAccountTextfield.text zone:@"86" result:^(NSError *error) {
        if(!error){
            [self showHUD:@"验证码获取成功"];
            
        }else{
            [self showHUD:@"请检查手机号"];
        }

    }];
    
    
}

-(void)checkVerityCode{
    //判断验证码是否成功
    [SMSSDK commitVerificationCode:self.verificationTextField.text phoneNumber:self.userAccountTextfield.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"验证成功");
                UINavigationController *nextTwo=[self.storyboard instantiateViewControllerWithIdentifier:@"nextTwo"];
                [self presentViewController:nextTwo animated:YES completion:nil];
        
        } else {
            [self showHUD:@"验证码错误"];
        }
    }];
    
}


- (IBAction)registerOneNextBtn:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.userAccounr=self.userAccountTextfield.text;
    
    if(![self verifyMobile])  return;
    if(![self vertifyInput])  return;
    
    //判断验证码
    if(self.verificationTextField.text.length==0){
        [self showHUD:@"请输入验证码"];
    }else{
        [self checkVerityCode];
    }

    


    

    
    



    

}




//验证手机号
- (BOOL)verifyMobile{
    self.phoneNum = self.userAccountTextfield.text;
    
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self.phoneNum] == YES)
        || ([regextestcm evaluateWithObject:self.phoneNum] == YES)
        || ([regextestct evaluateWithObject:self.phoneNum] == YES)
        || ([regextestcu evaluateWithObject:self.phoneNum] == YES))
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






//验证输入
-(BOOL)vertifyInput{
    
    self.phoneNum = self.userAccountTextfield.text;
    
    if([self.phoneNum isEqualToString:@""]){
        
        [self showHUD:@"请输入手机号码"];
        
        return NO;
    }
    
    return YES;
}



//触摸退出键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.userAccountTextfield resignFirstResponder];
    [self.verificationTextField resignFirstResponder];
}
@end
