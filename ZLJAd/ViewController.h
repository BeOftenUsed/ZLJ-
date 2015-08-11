//
//  ViewController.h
//  ZLJAd
//
//  Created by ss on 15/8/6.
//  Copyright (c) 2015年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIPageControl *pageC;
@property(strong,nonatomic)UIImageView *imageLeft;
@property(strong,nonatomic)UIImageView *imageCenter;
@property(strong,nonatomic)UIImageView *imageRight;
@property(strong,nonatomic)NSMutableDictionary *mDicImageData;
@property(assign)NSUInteger currentImageIndex;
@property(assign)NSUInteger imageCount;
@property(strong,nonatomic)UILabel*lblImageDesc;
@end

