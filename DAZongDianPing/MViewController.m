//
//  MViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-7.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "MViewController.h"
#import "Photo.h"
@interface MViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLable;
@property (weak, nonatomic) IBOutlet UITextField *myTextF;
@property(nonatomic,strong)NSMutableArray *images;
@end

@implementation MViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [NSMutableArray array];
    NSString *path = @"/Users/tarena04/Desktop/美女";
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *finames = [manager contentsOfDirectoryAtPath:path error:nil];
    for (NSString *filename in finames) {
        if ([filename hasSuffix:@"jpg"]) {
            NSString *fpath = [path stringByAppendingPathComponent:filename];
            [self.images addObject:fpath];
            
        }
    }

    
    for (int i = 0; i<self.images.count; i++) {
        Photo *p = [[Photo alloc]init];
        p.delegate = self;
        UIImage *img= [UIImage imageWithContentsOfFile:self.images[i]];
//        NSLog(@"%@",[self.images[i]lastPathComponent]);
      
        
        p.alpha = i*0.1+0.2;
        [p initStates];
        p.imageIV.image = img;
        [self.view addSubview:p];
        
    }
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimeAction:) userInfo:nil repeats:YES];
    
    
    
    
    
}
-(void)TimeAction:(NSTimer*)timer{
    self.curr += 1;
    
    self.myTextF.text = [NSString stringWithFormat:@"所用时间:%02d:%02d",(int)self.curr/60,(int)self.curr%60];
    if (self.Icount==self.images.count) {
        [timer invalidate];
    }
}
-(void)addImageCount:(int)count
{
//    self.Icount = self.myLable.text.intValue;
    self.Icount += count;
    self.myLable.text = [NSString stringWithFormat:@"点到:%d",self.Icount];
    
    
    
    
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
