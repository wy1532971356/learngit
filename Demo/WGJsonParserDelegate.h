//
//  WGJsonParserDelegate.h
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//


#ifndef practiceplatform_WGJsonParserDelegate_h
#define practiceplatform_WGJsonParserDelegate_h

@protocol WGJsonParserDelegate <NSObject>

@required

- (NSArray*)parseArray:(NSArray*)dicArray forKey:(NSString*)key;

@end

#endif
