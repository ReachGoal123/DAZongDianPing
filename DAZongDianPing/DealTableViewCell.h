//
//  DealTableViewCell.h
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"
#import "BussinessInfo.h"
@interface DealTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *s_image;
//@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UIImageView *tuanImage;
@property (weak, nonatomic) IBOutlet UIImageView *dingImage;
@property (weak, nonatomic) IBOutlet UILabel *deal_descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *current_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(strong,nonatomic)Deal * deal;
@property(strong,nonatomic)BussinessInfo * business;


@end
