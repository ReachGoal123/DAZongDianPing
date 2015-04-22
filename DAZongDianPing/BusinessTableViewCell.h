//
//  BusinessTableViewCell.h
//  DAZongDianPing
//
//  Created by wanglin on 15-3-30.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussinessInfo.h"
@interface BusinessTableViewCell : UITableViewCell
@property(nonatomic,strong)BussinessInfo * business;
@property (weak, nonatomic) IBOutlet UIImageView *s_photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *coupon_description;
@property (weak, nonatomic) IBOutlet UILabel *avg_price;
@property (weak, nonatomic) IBOutlet UILabel *deal_count;



@end
