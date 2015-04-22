//
//  Photo.h
//  DAZongDianPing
//
//  Created by wanglin on 15-4-7.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"
#import "MViewController.h"
@interface Photo : UIView
@property(nonatomic,strong)DrawView *drview;
@property(nonatomic,strong)UIImageView *imageIV;
@property(nonatomic)float speed;
@property(nonatomic,strong)MViewController *delegate;
-(void)initStates;

@end
