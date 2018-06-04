//
//  BasicDao.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "BasicDao.h"
#import <AFHTTPRequestOperationManager.h>
#import "WGJsonParser.h"
#import "resultInfo.h"

@implementation BasicDao

-(void)post:(NSString*)url params:(NSDictionary*)params dataModle:(Class)dataModle successHandler:(void(^)(id modle))successBlock errorHandler:(void(^)(NSString *code,NSString *message))errorBlock{
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON:%@",responseObject);
        
        resultInfo *result = [WGJsonParser parseData:responseObject usingModel:[resultInfo class]];
        
        
        //判断是否错误
        if (![result.content isEqualToString:@"[]"]) {
            id vo = [WGJsonParser parseJson:result.content usingModel:[dataModle class]];
            successBlock(vo);
        }else{
            errorBlock(result.code,result.message);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
    
}

@end
