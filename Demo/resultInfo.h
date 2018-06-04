//
//  resultInfo.h
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resultInfo : NSObject


@property(atomic,strong) NSString* code;
@property(atomic,strong) id content;
@property(atomic,strong) NSString* message;

@end
