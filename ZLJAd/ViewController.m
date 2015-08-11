//
//  ViewController.m
//  ZLJAd
//
//  Created by ss on 15/8/6.
//  Copyright (c) 2015年 ss. All rights reserved.
//

#import "ViewController.h"
#define kWidthOfScreen [[UIScreen mainScreen]bounds].size.width
#define kHeightOfScreen [[UIScreen mainScreen]bounds].size.height
#define kImageViewCount 3
@interface ViewController ()<UIScrollViewDelegate>
/**
 *  加载图片数据
 */
-(void)loadImageData;
/**
 *  添加滚动视图
 */
-(void)addScrollView;
/**
 *  添加三个图片视图到滚动视图内
 */
-(void)addImageViewsToScrollView;

-(void)addPageControl;

-(void)addLabel;

-(void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex;

-(void)setDefaultInfo;
/**
 *  重新加载图片
 */
-(void)reloadImage;

-(void)layoutUI;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layoutUI];
}
-(void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex{
    NSString*currentImageNamed=[NSString stringWithFormat:@"m%lu.png",(unsigned long)currentImageIndex];
    _imageCenter.image=[UIImage imageNamed:currentImageNamed];
    
    _imageLeft.image=[UIImage imageNamed:[NSString stringWithFormat:@"m%lu.png",(unsigned long)((_currentImageIndex-1+_imageCount)%_imageCount)]];
    _imageRight.image=[UIImage imageNamed:[NSString stringWithFormat:@"m%lu.png",(unsigned long)((_currentImageIndex+1)%_imageCount)]];
    
    _pageC.currentPage=currentImageIndex;
    _lblImageDesc.text=_mDicImageData[currentImageNamed];
}
-(void)reloadImage{
    CGPoint contentOffset=[_scrollView contentOffset];
    if(contentOffset.x>kWidthOfScreen){//向左滑动
        NSLog(@"**%ld",_currentImageIndex);
        _currentImageIndex=(_currentImageIndex+1)%_imageCount;
        }else if(contentOffset.x<kWidthOfScreen){//向右滑动
            _currentImageIndex=(_currentImageIndex-1+_imageCount)%_imageCount;
            }
    
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}
-(void)layoutUI
{
    self.view.backgroundColor=[UIColor blackColor];
    
    [self loadImageData];
    [self addScrollView];
    [self addImageViewsToScrollView];
    [self addPageControl];
    [self addLabel];
    [self setDefaultInfo];
}
-(void)loadImageData{
    NSString*path=[[NSBundle mainBundle]pathForResource:@"ImageInfo" ofType:@"plist"];
    _mDicImageData=[NSMutableDictionary dictionaryWithContentsOfFile:path];
    _imageCount=3;
}
-(void)addScrollView{
    _scrollView=[[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    _scrollView.contentSize=CGSizeMake(kWidthOfScreen*kImageViewCount,kHeightOfScreen);
    _scrollView.contentOffset=CGPointMake(kWidthOfScreen,0.0);
    _scrollView.pagingEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
}
-(void)addImageViewsToScrollView{
    //图片视图；左边
    _imageLeft=[[UIImageView alloc]initWithFrame:CGRectMake(0.0,0.0,kWidthOfScreen,kHeightOfScreen)];
    _imageLeft.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageLeft];
    
    //图片视图；中间
    _imageCenter=[[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfScreen,0.0,kWidthOfScreen,kHeightOfScreen)];
    _imageCenter.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageCenter];
    
    //图片视图；右边
    _imageRight=[[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfScreen*2.0,0.0,kWidthOfScreen,kHeightOfScreen)];
    _imageRight.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageRight];
}
-(void)addPageControl{
    _pageC=[UIPageControl new];
    CGSize size=[_pageC sizeForNumberOfPages:_imageCount];//根据页数返回?UIPageControl?合适的大小
    _pageC.bounds=CGRectMake(0.0,0.0,size.width,size.height);
    _pageC.center=CGPointMake(kWidthOfScreen/2.0,kHeightOfScreen-80.0);
    _pageC.numberOfPages=_imageCount;
    _pageC.pageIndicatorTintColor=[UIColor whiteColor];
    _pageC.currentPageIndicatorTintColor=[UIColor brownColor];
    _pageC.userInteractionEnabled=NO;//设置是否允许用户交互；默认值为?YES，当为?YES?时，针对点击控件区域左（当前页索引减一，最小为0）右（当前页索引加一，最大为总数减一），可以编写?UIControlEventValueChanged?的事件处理方法
    [self.view addSubview:_pageC];
}
-(void)addLabel{
    _lblImageDesc=[[UILabel alloc] initWithFrame:CGRectMake(0.0,40.0,kWidthOfScreen,40.0)];
    _lblImageDesc.textAlignment=NSTextAlignmentCenter;
    _lblImageDesc.textColor=[UIColor whiteColor];
    _lblImageDesc.font=[UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    _lblImageDesc.text=@"Fucking?now.";
    [self.view addSubview:_lblImageDesc];
}


-(void)setDefaultInfo{
    _currentImageIndex=0;
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}
#pragma?mark?-?UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView{
   [self reloadImage];
    NSLog(@"%lf",scrollView.contentOffset.x);
   _scrollView.contentOffset=CGPointMake(kWidthOfScreen,0.0);
    _pageC.currentPage=_currentImageIndex;
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
