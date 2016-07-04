//
//  ViewController.m
//  波浪动画
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 雷晏. All rights reserved.
//

/*
 *  正弦函数公式：y=Asin（ωx+φ）+h
 *  各常数值对函数图像的影响：
 *  φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减）
 *  ω：决定周期（最小正周期T=2π/|ω|）
 *  A：决定峰值（即纵向拉伸压缩的倍数）
 *  h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
 */
#define WIDTH     [UIScreen mainScreen].bounds.size.width-20

#import "ViewController.h"
#import "LYCircleLabel.h"

@interface ViewController ()


@property (nonatomic,strong) LYCircleLabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LYCircleLabel *label = [[LYCircleLabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH,WIDTH)];
    _label = label;
    label.center = self.view.center;
    [self.view addSubview:label];

    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, WIDTH-20, 30)];
    slider.center = CGPointMake(self.view.center.x,label.center.y+WIDTH-100);
    slider.minimumValue = 0.0;
    slider.maximumValue = 100;
    slider.value = (slider.minimumValue+slider.maximumValue)*0.1;
    [slider addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}

-(void)change:(UISlider *)sldier
{
    _label.percent =  sldier.value/100.0;
}
@end
