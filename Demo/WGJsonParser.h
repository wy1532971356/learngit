//
//  WGJsonParser.h
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "WGJsonParserDelegate.h"
#import "WGMessageDelegate.h"

@interface WGJsonParser : NSObject

+ (void)setDelegate:(id<WGJsonParserDelegate>)delegate;
+ (id<WGMessageDelegate>)parseData:(NSData*)data usingModel:(Class)model;
//功能：将dictionary转换为model；参数：dic－包含原始数据的字典对象，model－目标数据的类模型
+ (id)parseDic:(NSDictionary*) dic usingModel:(Class)model;
//功能：将json字符串转换为model；参数：json－包含原始数据的json字符串，model－目标数据的类模型
+ (id)parseJson:(NSString*)json usingModel:(Class)model;
//功能：将dictionary数组转换为对象数组；参数：json－包含原始数据的json字符串，model－目标数据的类模型
+ (NSMutableArray*)parseArray:(NSArray*) array usingModel:(Class)model;
//功能：将对象实例转换成Json字符串
+ (NSString*) jsonString:(id) instance;
//功能：转换JSON对象
+ (id)parseObject:(id)jsonObject usingModel:(Class)model;
@end
