//
//  TrimWhitespace.h
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrimWhitespace : NSObject

//表单为空或者Null 返回 NO , 否则返回YES
+(BOOL)isNullOrEmpty:(NSString *)str;
//表单为空、Null或者是空格 返回 NO , 否则返回YES
+(BOOL)isNullOrEmptyOrWhiteSpace:(NSString *)str;
//去除文字二边的空格
+(NSString*)trim:(NSString*)str;

@end
