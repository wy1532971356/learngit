//
//  TrimWhitespace.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TrimWhitespace.h"

@implementation TrimWhitespace

+(BOOL)isNullOrEmpty:(NSString *)str{
    return (str==nil || str.length==0);
}


+(BOOL)isNullOrEmptyOrWhiteSpace:(NSString *)str{
    if([TrimWhitespace isNullOrEmpty:str]){
        return true;
    }
    NSString *tmp = [TrimWhitespace trim:str];
    return (tmp.length==0);
}

//去除文字二边的空格
+(NSString*)trim:(NSString*)str{
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return ([str stringByTrimmingCharactersInSet:set]);
}

@end
