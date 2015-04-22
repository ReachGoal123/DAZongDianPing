//
//  MovieTView.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "MovieTView.h"

@implementation MovieTView

-(void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.text = self.movie.name;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",self.movie.score];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.movie.img]];
        UIImage *img = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.movieIV.image = img;
        });
    });
    
    self.introTV.text = self.movie.intro;
    
    
    
}
-(IBAction)valueChanged:(id)sender{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sourceChange" object:nil userInfo:@{@"sourceType":@(self.actorsOrSocurceSC.selectedSegmentIndex)}];
    
    
    
}
@end
