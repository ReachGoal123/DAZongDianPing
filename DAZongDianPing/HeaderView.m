//
//  HeaderView.m
//  DAZongDianPing
//
//  Created by wanglin on 15-3-30.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        NSArray * labelText = @[@"美食",@"电影",@"酒店",@"KTV",@"小吃",@"休闲娱乐",@"今日新品",@"更多"];
        for (int i = 0; i<8; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i%4*80+10, i/4*90+10, 60, 60)];
            btn.tag = i;
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"首页_1%d",i+1]]forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(categoryClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(i%4*80+10, i/4*90+80, 60, 10)];
            label.text = labelText[i];
            label.textAlignment = NSTextAlignmentCenter;
//            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont fontWithName:@"黑体-简" size:13];
        label.textColor = [UIColor colorWithRed:62.0/255 green:62.0/255 blue:62.0/255 alpha:1];
            [self addSubview:label];
            
            
        }
        
        
        
    }
    
    
    
    return self;
}

-(void)categoryClick:(UIButton*)btn{
    
    NSString *category = @"美食";
    switch (btn.tag) {
        case 1:
            category = @"电影";
            break;
        case 2:
            category = @"酒店";
            break;
        case 3:
            category = @"KTV";
            break;
        case 4:
            category = @"购物";
            break;
        case 5:
            category = @"休闲娱乐";
            break;
        case 6:
            category = @"旅行社";
            break;
        case 7:
            category = @"购物";
            break;
            
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickedCategory" object:nil userInfo:@{@"category":category}];
}












@end
