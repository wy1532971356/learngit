//
//  AccountDao.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AccountDao.h"
#import "Constants.h"

@implementation AccountDao

-(void)registerWithPhoneNumber:(NSString *)phoneNumber userSex:(NSString *)userSex userAddress:(NSString *)userAddress userPassword:(NSString *)userPassword userName:(NSString *)userName successHandler:(void(^)(userInfo *account))successBlock errorHandler:(void(^)(NSString *code,NSString *message))errorBlock{
    
    
    NSString *url =[BASIC_URL stringByAppendingString:@"user/register.php"];
    NSDictionary *params = @{@"userAccount":phoneNumber,@"userPassword":userPassword,@"userSex":userSex
                             ,@"userAddress":userAddress,@"userName":userName};
    [self post:url params:params dataModle:[userInfo class] successHandler:^(id modle) {
        if (successBlock != nil) {
            successBlock(modle);
        }
    } errorHandler:errorBlock];


}

-(void)loginWith:(NSString *)name Password:(NSString *)password successHander:(void(^)(userInfo *account))successBlock errorHandler:(void(^)(NSString *code,NSString *message))errorBlock{
    
    NSString *url =[BASIC_URL stringByAppendingString:@"user/login.php"];
    
    NSDictionary *params = @{@"userAccount":name,@"userPassword":password};
    
    [self post:url params:params dataModle:[userInfo class] successHandler:^(id modle) {
        if (successBlock != nil) {
            successBlock(modle);
        }
    } errorHandler:errorBlock];
    
}


@end
