//
//  Photo.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-7.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
       
    }
    
    
    return self;
    
}
-(void)initStates{
    
    self.speed = self.alpha;
    
    float w= 60*self.alpha;
    float h = 90*self.alpha;
    
    self.frame = CGRectMake(-w, arc4random()%(int)(568-h), w, h);
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
    self.backgroundColor = [UIColor redColor];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.drview = [[DrawView alloc]initWithFrame:self.bounds];
    [self addSubview:self.drview];

    
    self.imageIV = [[UIImageView alloc]initWithFrame:self.bounds];
    
    [self addSubview:self.imageIV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    }
-(void)tapAction{
    
   [UIView animateWithDuration:.5 animations:^{
    self.frame = CGRectMake(60, 200, 250, 330);
       self.imageIV.frame = self.bounds;
       self.drview.frame = self.bounds;
       self.speed = 0;
       self.alpha = 1;
       [self.delegate addImageCount:1];
       [self.superview bringSubviewToFront:self];
       
   }];
    
    
    
}

-(void)moveAction{
    
    self.center = CGPointMake(self.center.x+self.speed, self.center.y);
    if (self.frame.origin.x>=320) {
        CGRect frame = self.frame;
        frame.origin.x = -self.bounds.size.width;
        frame.origin.y = arc4random()%(int)(568-20-self.bounds.size.height);
        self.frame = frame;
    }
    
    
    
    
    
}

@end
