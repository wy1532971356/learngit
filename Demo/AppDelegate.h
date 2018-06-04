//
//  AppDelegate.h
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property(assign, nonatomic) NSString *userAccounr;//登录的用户账号
@property(assign, nonatomic) NSString *userName;//登录的用户密码
@property(assign, nonatomic) NSString *userSex;
@property(assign, nonatomic) NSString *userAddress;
@property(assign, nonatomic) NSString *userPassword;

-(NSString *)getUserAccount;//得到用户账号
-(NSString *)getUserName;
-(NSString *)getUserSex;
-(NSString *)getUserAddress;
-(NSString *)getUserPassword;
@end

