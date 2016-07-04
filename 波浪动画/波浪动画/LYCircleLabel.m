//
//  LYCircleLabel.m
//  波浪动画
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 雷晏. All rights reserved.
//

#import "LYCircleLabel.h"

static  CGFloat offset = 0.0;
static  CGFloat height = 5;
@interface LYCircleLabel()
{
    CGFloat _width;
    CADisplayLink *link;
}

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation LYCircleLabel

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        _percent = 0.1;
        [self addSubview:self.titleLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _width = self.layer.frame.size.width;
    self.layer.cornerRadius = self.layer.frame.size.width*0.5;
    self.layer.borderWidth = 2.f;
    [self createTimer];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    offset+=10;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGContextSetLineWidth(context, 1);
    UIColor * blue = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3];
    CGContextSetFillColorWithColor(context, [blue CGColor]);

    //计算开始的y的位置，y=Asin（ωx+φ）+h
    CGFloat startY = rect.size.height * (1.0-_percent);
    CGPathMoveToPoint(pathRef, NULL, 0, startY);

    for(CGFloat i = 0.0 ; i < rect.size.width;i++){
        CGFloat y = height*sinf(i*2.5*M_PI/rect.size.width+offset*M_PI/rect.size.width)+startY;
        CGPathAddLineToPoint(pathRef, NULL, i, y);
    }
    CGPathAddLineToPoint(pathRef, nil, rect.size.width , rect.size.height );
    CGPathAddLineToPoint(pathRef, nil, 0, rect.size.height );
    CGContextAddPath(context, pathRef);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(pathRef);
    //添加文字
    _titleLabel.text = [NSString stringWithFormat:@"%.2f%%",self.percent * 100.0];
}
-(void)createTimer{
    if(!link){
        link = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAnimation)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}
-(void)startAnimation{
    [self setNeedsDisplay];
}

-(void)setPercent:(CGFloat)percent{
    _percent = percent;
    if(percent == 0 || percent == 1){
        height = 1;
    }else{
        height = 10;
    }
    [self createTimer];
}
@end
