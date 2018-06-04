//
//  registerThreeViewController.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "registerThreeViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import "AccountDao.h"

@interface registerThreeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userAccountTextField;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordOneTextfield;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTwoTextField;
@property(nonatomic,strong)MBProgressHUD *HUD;


@end

@implementation registerThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userAccountTextField.text=appDelegate.userAccounr;
    
    self.userNameTextField.text=appDelegate.userName;
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
- (IBAction)completeButton:(id)sender {
    
    if(self.userPasswordOneTextfield.text != self.userPasswordTwoTextField.text){
        [self showHUD:@"两次输入的密码不一致"];
    }else{
        
        

        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

        AccountDao *account=[[AccountDao alloc]init];

        [account registerWithPhoneNumber:appDelegate.userAccounr userSex:appDelegate.userSex userAddress:appDelegate.userAddress userPassword:self.userPasswordOneTextfield.text userName:appDelegate.userName successHandler:^(userInfo *account) {
                      NSLog(@"11233232--->%@",account);
                                [self showHUD:@"注册成功，请返回登录"];
        } errorHandler:^(NSString *code, NSString *message) {
            [self showHUD:message];
        }];
    }
}


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

@end
