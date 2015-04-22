//
//  JsonPaeser.h
//  DAZongDianPing
//
//  Created by wanglin on 15-3-30.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Star.h"
#import "Moive.h"
@interface JsonPaeser : NSObject
+ (NSArray *)parseBussinessByDic:(NSDictionary *)dic;
+ (NSArray*)parserDealbydic:(NSDictionary*)dic;

+ (Star*)parseStarByDic:(NSDictionary *)dic;
+ (NSMutableArray *)parseMoviesByDic:(NSDictionary *)dic;
+ (NSString *)parseMovieURLByDic:(NSDictionary *)dic;
@end
