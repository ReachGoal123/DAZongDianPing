//
//  Moive.h
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Moive : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, strong)NSNumber *score;
@property (nonatomic, strong)NSMutableArray *actors;
@property (nonatomic, strong)NSMutableArray *sources;
@end
