//
//  WGJsonParser.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WGJsonParser.h"

static id<WGJsonParserDelegate> WGJsonParser_delegate;

@implementation WGJsonParser

+ (void)setDelegate:(id<WGJsonParserDelegate>)delegate
{
    WGJsonParser_delegate = delegate;
}

+ (id<WGMessageDelegate>)parseData:(NSData*)data usingModel:(Class)model
{
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];//解析json字符串
    
    return [self parseObject:jsonObject usingModel:model];
}

//功能：将dictionary转换为model；参数：dic－包含原始数据的字典对象，model－目标数据的类模型
+ (id)parseDic:(NSDictionary*) dic usingModel:(Class)model{
    id obj = [[model alloc] init];//返回的对象实例
    unsigned int outCount;//该对象的属性总数
    objc_property_t *properties = class_copyPropertyList([model class], &outCount);//获取该对象的属性列表
    const char *propertyName;//类的元数据中的属性名称
    NSEnumerator* enumerator=[dic keyEnumerator];//获取dic的迭代器
    id value;//属性的值
    NSString  *name;//元数据中的属性名称转换成NSString用来比较
    const char * attributes;
    NSString* type;
    Class propertyClass;
    
    for (id key in enumerator) {
        for (int i=0; i<outCount; i++) {
            objc_property_t property = properties[i];
            propertyName =  property_getName(property);
            name=[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            attributes = property_getAttributes(property);
            
            type = [NSString  stringWithCString:attributes encoding:NSUTF8StringEncoding];
            
            //如果dic的key与类的属性匹配将对应的值写入对象实例中
            if([[key uppercaseString] isEqualToString:[name uppercaseString]]){
                
                NSArray* splitedType = [type componentsSeparatedByString:@","];
                NSString* className = [splitedType objectAtIndex:0];
                
                className = [className stringByReplacingOccurrencesOfString:@"T@" withString:@""];
                className = [className stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                propertyClass = NSClassFromString(className);
                //NSLog(@"%@ : %@",name,propertyClass);
                
                value = [dic objectForKey:key];
                
                if ([value isKindOfClass:[NSDictionary class]]){
                    
                    if (propertyClass != nil) {
                        
                        NSDictionary *dic = (NSDictionary *)value;
                        value = [self parseDic:dic usingModel:propertyClass];
                    }
                    
                } else if ([value isKindOfClass:[NSArray class]]){
                    
                    if (propertyClass != nil) {
                        
                        if (WGJsonParser_delegate != nil) {
                            value = [WGJsonParser_delegate parseArray:value forKey:name];
                        }
                    }
                    
                } else if ([value isKindOfClass:[NSNull class]]){
                    
                    value =  nil;
                }
                
                [obj setValue:value forKey:name];
                break;
            }
        }
    }
    
    return obj;
}

+ (NSString*) jsonString:(id) instance{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    unsigned int outCount;//该对象的属性总数
    objc_property_t *properties = class_copyPropertyList([instance class], &outCount);//获取该对象的属性列表
    const char *propertyName;//类的元数据中的属性名称
    NSString  *name;//元数据中的属性名称转换成NSString用来比较
    
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        propertyName =  property_getName(property);
        name=[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding];//[NSString stringWithUTF8String:propertyName]]
        id value = [instance valueForKey:name];
        if (value != nil) {
            
            [dic setValue:value forKey:name.lowercaseString];
            
        }else{
            
            if ([instance isKindOfClass:[NSString class]]) {
                [dic setValue:@"" forKey:name];
            } else if ([instance isKindOfClass:[NSNumber class]]) {
                [dic setValue:@(0) forKey:name];
            }
        }
    }
    //字典转字符串
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

//功能：将dictionary数组转换为对象数组；参数：json－包含原始数据的json字符串，model－目标数据的类模型
+ (NSMutableArray*)parseArray:(NSArray*) array usingModel:(Class)model{
    NSMutableArray* rsltArray = [[NSMutableArray alloc] init];//目标对象数组
    id obj;
    
    for(id item in array){
        obj = [self parseDic:item usingModel:model];//调用parseDic将数组中的单个元素解析出来
        [rsltArray addObject:obj];
    }
    
    return rsltArray;
}

//功能：将json字符串转换为model；参数：json－包含原始数据的json字符串，model－目标数据的类模型
+ (id)parseJson:(NSString*)json usingModel:(Class)model{
    
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [self parseData:jsonData usingModel:model];
}

+ (id)parseObject:(id)jsonObject usingModel:(Class)model{
    
    if ([jsonObject isKindOfClass:[NSString class]]) {
        
        return jsonObject;
        
    }else if([jsonObject isKindOfClass:[NSNumber class]]) {
        
        return jsonObject;
        
    }else if ([jsonObject isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *dic = (NSDictionary *)jsonObject;
        return [self parseDic:dic usingModel:model];
        
    }else if ([jsonObject isKindOfClass:[NSArray class]]){
        
        NSArray *array = (NSArray *)jsonObject;
        return [self parseArray:array usingModel:model];
        
    } else {
        
        NSLog(@"未识别JSON对象类型.");
        return nil;
    }
}


@end
