//
//  JsonPaeser.m
//  DAZongDianPing
//
//  Created by wanglin on 15-3-30.
//  Copyright (c) 2015年 tarena. All rights reserved.
//
#import "Deal.h"
#import "JsonPaeser.h"
#import "BussinessInfo.h"
@implementation JsonPaeser
+(NSArray *)parseBussinessByDic:(NSDictionary *)dic{
    NSMutableArray *busics = [NSMutableArray array];
    NSMutableArray *bdic = [dic objectForKey:@"businesses"];
//    NSLog(@"%@",bdic);
    
    if([bdic isMemberOfClass:[NSNull class]]){
        return [NSArray array];
    }
    
    for( NSDictionary * businessDic  in bdic){
       BussinessInfo * business = [[BussinessInfo alloc]init];
        //        business.business_id = [[businessDic objectForKey:@"business_id"]intValue];
        business.name = [businessDic objectForKey:@"name"];
        //        business.branch_name = [businessDic objectForKey:@"branch_name"];
        //        business.address = [businessDic objectForKey:@"address"];
        //        business.telephone = [businessDic objectForKey:@"telephone"];
        business.city = [businessDic objectForKey:@"city"];
        //        business.regions = [businessDic objectForKey:@"regions"];
        //        business.categories = [businessDic objectForKey:@"categories"];
        business.latitude = [[businessDic objectForKey:@"latitude"]floatValue];
        business.longitude = [[businessDic objectForKey:@"longitude"]floatValue];
        business.avg_rating = [[businessDic objectForKey:@"avg_rating"]floatValue];
        business.rating_img_url = [businessDic objectForKey:@"rating_img_url"];
        business.rating_s_img_url = [businessDic objectForKey:@"rating_s_img_url"];
        
        business.avg_price = [[businessDic objectForKey:@"avg_price"]intValue];
        business.business_url = [businessDic objectForKey:@"business_url"];
        business.photo_url = [businessDic objectForKey:@"photo_url"];
        business.s_photo_url = [businessDic objectForKey:@"s_photo_url"];
        business.has_coupon = [[businessDic objectForKey:@"has_copon"]intValue];
        
        business.coupon_description = [businessDic objectForKey:@"coupon_description"];
        business.has_deal = [[businessDic objectForKey:@"has_deal"]intValue];
        business.deal_count = [[businessDic objectForKey:@"deal_count"]intValue];
        business.deals = [businessDic objectForKey:@"deals"];
        business.has_online_reservation = [[businessDic objectForKey:@"has_online_reservation"]intValue];
        business.online_reservation_url = [businessDic objectForKey:@"online_reservation_url"];
        
        [busics addObject:business];
    }

    return busics;
}

+(NSArray*)parserDealbydic:(NSDictionary*)dic{
    
    NSMutableArray *deals = [NSMutableArray array];
    NSArray *dealDics = [dic objectForKey:@"deals"];
    if ([dealDics isMemberOfClass:[NSNull class]]) {
        return [NSArray array];
    }
    
    for(NSDictionary * dealDic in dealDics){
        Deal * deal = [[Deal alloc]init];
        deal.deal_id = [dealDic objectForKey:@"deal_id"];
        deal.title = [dealDic objectForKey:@"title"];
        deal.regions = [dealDic objectForKey:@"regions"];
        deal.current_price = [NSString stringWithFormat:@"%.1f",[[dealDic objectForKey:@"current_price"]floatValue]];
        deal.categories = [dealDic objectForKey:@"categories"];
        deal.purchase_count = [[dealDic objectForKey:@"purchase_count"]integerValue];
        deal.distance = [dealDic objectForKey:@"distance"];
        deal.image_url = [dealDic objectForKey:@"image_url"];
        deal.s_image_url = [dealDic objectForKey:@"s_image_url"];
        deal.deal_h5_url = [dealDic objectForKey:@"deal_h5_url"];
        deal.businesses = [dealDic objectForKey:@"businesses"];
    
        for(NSDictionary * busiDic in deal.businesses){
            deal.business_latitude = [busiDic objectForKey:@"latitude"];
            deal.business_longitude = [busiDic objectForKey:@"longitude"];
        }
        deal.rating_s_img_url = [dealDic objectForKey:@"rating_s_img_url"];
        [deals addObject:deal];
    }
    
    
    return deals;
    
    
    
}

+ (Star*)parseStarByDic:(NSDictionary *)dic{
    NSDictionary *resultdic = [dic objectForKey:@"result"];
    Star *s = [[Star alloc]init];
    s.name = [resultdic objectForKey:@"name"];
    s.area = [[resultdic objectForKey:@"area"]firstObject];
    s.birth = [resultdic objectForKey:@"birth"];
    s.intro = [resultdic objectForKey:@"intro"];
    s.avatarLarge = [resultdic objectForKey:@"avatarLarge"];
    return s;
    
}
+ (NSMutableArray *)parseMoviesByDic:(NSDictionary *)dic{
    NSMutableArray *movies = [NSMutableArray array];
    NSArray *resultArr = [dic objectForKey:@"result"];
    for (NSDictionary *movieDic in resultArr) {
        Moive *m  = [[Moive alloc]init];
        m.name = [movieDic objectForKey:@"name"];
        m.intro = [movieDic objectForKey:@"intro"];
        m.score = [movieDic objectForKey:@"score"];
        m.img = [movieDic objectForKey:@"img"];
        m.actors = [movieDic objectForKey:@"actors"];
        m.sources = [movieDic objectForKey:@"source"];
        [movies addObject:m];
        
    }
    
    return movies;
    
}
+ (NSString *)parseMovieURLByDic:(NSDictionary *)dic{
    
    NSDictionary *resultDic = [dic objectForKey:@"result"];
    NSArray *videosArr = [resultDic objectForKey:@"videos"];
    NSDictionary *movieDic = [videosArr firstObject];
    
    return [movieDic objectForKey:@"url"];

}




@end
