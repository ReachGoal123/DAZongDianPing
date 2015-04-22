//
//  MyAnnotation.h
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject<MKAnnotation>
@property(nonatomic)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
