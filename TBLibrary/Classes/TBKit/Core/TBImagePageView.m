//
//  TBImagePageView.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBImagePageView.h"
#import "UIView+TBFrame.h"

static const NSTimeInterval DefalutRollingDelayTime = 4;

@interface TBImagePageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy) NSArray *imageViewArray;
@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, assign) BOOL shouldLayoutImageViews;
@property (nonatomic, assign) BOOL enableRolling;

@end

@implementation TBImagePageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _rollingDelayTime = DefalutRollingDelayTime;
        _direction = TBImagePageViewDirection_Rightward;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images {
    self = [self initWithFrame:frame];
    if (self) {
        self.images = images;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!self.scrollView.superview) {
        [self setUI];
        self.shouldLayoutImageViews = YES;
        [self refreshLayout];
    }
}

- (void)startRolling {
    if (self.images.count <= 1) {
        return;
    }
    [self stopRolling];
    self.enableRolling = YES;
    [self performSelector:@selector(rollingScrollAction) withObject:nil afterDelay:self.rollingDelayTime];
}

- (void)stopRolling {
    self.enableRolling = NO;
    //取消已加入的延迟线程
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(rollingScrollAction) object:nil];
}

#pragma mark - private methods
- (void)setUI {
    [self addSubview:self.scrollView];
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        [self.scrollView addSubview:imageView];
    }];
    [self.pageControl setFrame:CGRectMake((self.bounds.size.width-60)/2, self.bounds.size.height-15, 60, 15)];
    [self addSubview:self.pageControl];
}

- (void)rollingScrollAction {
    CGFloat offsetXFactor = 1.f;
    CGFloat offsetYFactor = 0.f;
    
    NSInteger indexFactor = 1;
    if (![self isHorizontal]) {
        offsetXFactor = 0.f;
        offsetYFactor = 1.f;
    }
    
    CGFloat multiplyFactor = 1.99;
    if (![self isForward]) {
        multiplyFactor = 0.01f;
        indexFactor = -1;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(multiplyFactor*offsetXFactor*self.scrollView.width, multiplyFactor*offsetYFactor*self.scrollView.height);
    } completion:^(BOOL finished) {
        self.currentPageIndex = [self getPageIndex:self.currentPageIndex+ indexFactor];
        [self refreshLayout];
        if (self.enableRolling) {
            [self performSelector:@selector(rollingScrollAction) withObject:nil afterDelay:self.rollingDelayTime];
        }
    }];
}

- (void)refreshLayout {
    if (_shouldLayoutImageViews) {
        _shouldLayoutImageViews = NO;
        [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
            if ([self isHorizontal]) {
                [imageView setOrigin:CGPointMake(idx * self.width, 0)];
            } else {
                [imageView setOrigin:CGPointMake(0, idx * self.height)];
            }
        }];
        if ([self isHorizontal]) {
            self.scrollView.contentSize = CGSizeMake(self.width * 3, 0);
        } else {
            self.scrollView.contentSize = CGSizeMake(0, self.height * 3);
        }
    }
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        if (self.images) {
            NSInteger imageIndex = (self.images.count + _currentPageIndex + idx - 1)%self.images.count;
            NSString *imageString = self.images[imageIndex];
            //  测试期使用：
            imageView.image = [UIImage imageNamed:imageString];
            //            NSURL *imageUrl = [NSURL URLWithString:imageString];
            //            [imageView sd_setImageWithURL:imageUrl placeholderImage:_placeholder];
        }
    }];
    UIImageView *centerImageView = self.imageViewArray[1];
    [self.scrollView setContentOffset:CGPointMake(centerImageView.left, centerImageView.top)];
    if (self.images.count > 1) {
        self.scrollView.scrollEnabled = YES;
        self.pageControl.alpha = 1;
        return;
    }
    self.scrollView.scrollEnabled = NO;
    self.pageControl.alpha = 0;
}

- (NSInteger)getPageIndex:(NSInteger)index{
    if (index<0){
        index = self.images.count - 1;
    }
    if (index == self.images.count)
    {
        index = 0;
    }
    return index;
}

- (BOOL)isHorizontal {
    return _direction & 1;
}

- (BOOL)isForward {
    return !(_direction & 0b100);
}

#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat focusOffset = scrollView.contentOffset.y;
    CGFloat focusLength = scrollView.height;
    if ([self isHorizontal]) {
        focusOffset = scrollView.contentOffset.x;
        focusLength = scrollView.width;
    }
    
    //取消已加入的延迟线程
    double remainder = focusOffset - ((int)(focusOffset/focusLength))*focusLength;
    if (self.enableRolling && remainder > 1) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(rollingScrollAction) object:nil];
    }
    
    if (focusOffset >=  2 * focusLength) {
        self.currentPageIndex = [self getPageIndex:self.currentPageIndex+1];
        [self refreshLayout];
    } else if (focusOffset <= 0) {
        self.currentPageIndex = [self getPageIndex:self.currentPageIndex-1];
        [self refreshLayout];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 水平滚动
    if ([self isHorizontal]) {
        scrollView.contentOffset = CGPointMake(scrollView.width, 0);
    } else {
        scrollView.contentOffset = CGPointMake(0, scrollView.height);
    }
    if (self.enableRolling) {
        [self performSelector:@selector(rollingScrollAction) withObject:nil afterDelay:self.rollingDelayTime];
    }
}

#pragma mark - actions
- (void)tapped:(id)sender {
    _didClickOnImage? _didClickOnImage(_currentPageIndex): nil;
}

#pragma mark - setter
- (void)setDirection:(TBImagePageViewDirection)direction {
    if (_direction != direction) {
        _direction = direction;
        _shouldLayoutImageViews = YES;
        [self refreshLayout];
    }
}

- (void)setImages:(NSArray *)images {
    NSParameterAssert(images.count);
    if (_images != images) {
        _images = images;
        _currentPageIndex = 0;
        _shouldLayoutImageViews = YES;
        self.pageControl.numberOfPages = _images.count;
        [self.pageControl setWidth:60];
        [self refreshLayout];
        [self startRolling];
        _didShowOnImage? _didShowOnImage(_currentPageIndex): nil;
    }
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    if (_contentMode == contentMode) {
        _contentMode = contentMode;
        [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
            imageView.contentMode = contentMode;
        }];
    }
}

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex {
    if (_currentPageIndex != currentPageIndex) {
        _currentPageIndex = currentPageIndex;
        _pageControl.currentPage = currentPageIndex;
        _didShowOnImage? _didShowOnImage(_currentPageIndex): nil;
    }
    
}

#pragma mark - getter
- (UIImageView *)createImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [imageView addGestureRecognizer:singleTap];
    return imageView;
}

- (NSArray *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = [[NSArray alloc] initWithObjects:[self createImageView], [self createImageView], [self createImageView], nil];
    }
    return _imageViewArray;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

@end
