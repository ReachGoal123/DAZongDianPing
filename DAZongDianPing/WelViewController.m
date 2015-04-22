//
//  WelViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-3-30.
//  Copyright (c) 2015年 tarena. All rights reserved.
//
#define kD_WIDTH [[UIScreen mainScreen]bounds].size.width
#define kD_HEIGHT [[UIScreen mainScreen]bounds].size.height
#import "WelViewController.h"
#import "AppDelegate.h"
@interface WelViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *mySIV;
@property(nonatomic,strong)UIButton *btn;
@end

@implementation WelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    self.mySIV.pagingEnabled = YES;
    self.mySIV.showsHorizontalScrollIndicator = YES;
    self.mySIV.showsVerticalScrollIndicator = NO;
    self.mySIV.contentSize = CGSizeMake(3*kD_WIDTH,kD_HEIGHT);
    self.mySIV.delegate = self;
    
    [self CreatImageData];
    
    
}


-(void)CreatImageData{
    for (int i = 0; i<3; i++) {
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kD_WIDTH * i, 0, kD_WIDTH, kD_HEIGHT)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页－%d.jpg",i+1]];
        [self.mySIV addSubview:imgView];
        if (2==i) {
            imgView.userInteractionEnabled = YES;
            self.btn = [[UIButton alloc]initWithFrame:CGRectMake(127,591, 127, 40)];
         [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(enter) userInfo:nil repeats:NO];
//            [self.btn addTarget:self action:@selector(clickon) forControlEvents:UIControlEventTouchUpInside];
//            self.btn.backgroundColor = [UIColor greenColor];
            
            [imgView addSubview:self.btn];
        
        
        }
        
    }
    
    
}

//-(void)clickon{
////    AppDelegate *app = [UIApplication  sharedApplication].delegate;
////    
////    app.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainvc"];
//    
//        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(enter) userInfo:nil repeats:NO];

//}
-(void)enter{
    
    AppDelegate *app = [UIApplication  sharedApplication].delegate;
    
    app.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTVC"];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
