//
//  WebUtils.h
//  DAZongDianPing
//
//  Created by wanglin on 15-3-30.
//  Copyright (c) 2015年 tarena. All rights reserved.
//
typedef void (^MyCallback)(id obj);
#import <Foundation/Foundation.h>

@interface WebUtils : NSObject
+(void)requestBusinessAndCallback:(MyCallback)callback;
+(void)requestBusinessWithParams:(NSDictionary *)params AndCallback:(MyCallback)callback;


+(void)requestDealsWithParams:(NSDictionary *)params AndCallback:(MyCallback)callback;


+(void)requestStartInfoWithStartName:(NSString*)name AndCallback:(MyCallback)callback;
+(void)requestMoivesWithMoiveName:(NSString*)name AndCallback:(MyCallback)callback;
+(void)requestMoiveURLWithSourceID:(NSString*)SouceID AndCallback:(MyCallback)callback;

@end
