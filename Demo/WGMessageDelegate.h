//
//  WGMessageDelegate.h
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WGMessageDelegate <NSObject>

@required

- (BOOL) isSuceess;
- (NSString*) getCode;
- (NSString*) getMessage;
- (id) getContent;

@end

