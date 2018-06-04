//
//  BasicDao.h
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicDao : NSObject

-(void)post:(NSString*)url params:(NSDictionary*)params dataModle:(Class)dataModle successHandler:(void(^)(id modle))successBlock errorHandler:(void(^)(NSString *code,NSString *message))errorBlock;



@end
