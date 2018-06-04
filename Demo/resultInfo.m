//
//  resultInfo.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "resultInfo.h"

@implementation resultInfo

-(NSString*)description{
    
    return [NSString stringWithFormat:@"code->%@,content->%@,message->%@",self.code,self.content,self.message];
}

@end
