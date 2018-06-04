//
//  AccountDao.h
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "BasicDao.h"
#import "userInfo.h"

@interface AccountDao : BasicDao

-(void)registerWithPhoneNumber:(NSString *)phoneNumber userSex:(NSString *)userSex userAddress:(NSString *)userAddress userPassword:(NSString *)userPassword userName:(NSString *)userName successHandler:(void(^)(userInfo *account))successBlock errorHandler:(void(^)(NSString *code,NSString *message))errorBlock;


-(void)loginWith:(NSString *)name Password:(NSString *)password successHander:(void(^)(userInfo *account))successBlock errorHandler:(void(^)(NSString *code,NSString *message))errorBlock;
@end
