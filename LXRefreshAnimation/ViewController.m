//
//  ViewController.m
//  LXRefreshAnimation
//
//  Created by chuanglong02 on 16/11/30.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "ViewController.h"
#import "LXTableViewController.h"
#import "Logview.h"
#import "LxButton.h"
@interface ViewController ()
@property(nonatomic,strong)Logview *logview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Logview *logview =[[Logview alloc]initWithFrame:CGRectMake(100, 65, 40, 40)];
    [self.view addSubview:logview];
    self.logview = logview;
    
 
    UISlider *slider =[[UISlider alloc]initWithFrame:CGRectMake(100, 200, 100, 30)];
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    LxButton *button =[LxButton LXButtonWithTitle:@"进入下个界面" titleFont:[UIFont systemFontOfSize:16.0] Image:nil backgroundImage:nil backgroundColor:[UIColor redColor] titleColor:[UIColor blackColor] frame:CGRectMake(100, 250, 100, 30)];
    [self.view addSubview:button];
    __weak ViewController *weakSelf =self;
    [button addClickBlock:^(UIButton *button) {
        LXTableViewController *tab=[[LXTableViewController alloc]init];
        [weakSelf.navigationController pushViewController:tab animated:YES];
    }];
    
}
-(void)sliderAction:(UISlider *)slider
{
    self.logview.circleView.hidden = YES;
    self.logview.circleLayer.hidden = NO;
    self.logview.circleLayer.strokeEnd = slider.value;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    LXTableViewController *tab = [[LXTableViewController alloc]init];
//    [self presentViewController:tab animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
