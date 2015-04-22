//
//  MovieTView.h
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Moive.h"
@interface MovieTView : UIView
@property(nonatomic,strong)Moive *movie;
@property(nonatomic, weak)IBOutlet UIImageView *movieIV;
@property(nonatomic, weak)IBOutlet UILabel *nameLabel;
@property(nonatomic, weak)IBOutlet UILabel *scoreLabel;
@property(nonatomic, weak)IBOutlet UITextView *introTV;
@property(nonatomic, weak)IBOutlet UISegmentedControl *actorsOrSocurceSC;
@end
