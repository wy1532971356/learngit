//
//  userInfo.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "userInfo.h"

@implementation userInfo

-(NSString*)description{
    return [NSString stringWithFormat:@"userId->%@,userAccount->%@,userSex->%@,userAddress->%@,userPassword->%@,userName->%@",self.userId,self.userAccount,self.userSex,self.userAddress,self.userPassword,self.userName];
}


@end
