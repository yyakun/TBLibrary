//
//  TBHorizontalPagingView.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/6/25.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBHorizontalPagingView.h"

@interface TBHorizontalPagingView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak)   UIView             *headerView;
@property (nonatomic, strong) NSArray            *segmentButtons;
@property (nonatomic, strong) NSArray            *contentViews;

@property (nonatomic, strong, readwrite) UIView  *segmentView;
@property (nonatomic, strong) UICollectionView   *horizontalCollectionView;
@property (nonatomic, weak)   UIScrollView       *currentScrollView;
@property (nonatomic, strong) NSLayoutConstraint *headerOriginYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *headerSizeHeightConstraint;
@property (nonatomic, assign) CGFloat            headerViewHeight;
@property (nonatomic, assign) CGFloat            segmentBarHeight;
@property (nonatomic, assign) BOOL               isSwitching;
@property (nonatomic, assign) BOOL               scrollEnable;

@property (nonatomic, strong) NSMutableArray     *segmentButtonConstraintArray;

@property (nonatomic, strong) UIView             *currentTouchView;
@property (nonatomic, strong) UIButton           *currentTouchButton;

@end

@implementation TBHorizontalPagingView

static void *TBHorizontalPagingViewScrollContext = &TBHorizontalPagingViewScrollContext;
static void *TBHorizontalPagingViewInsetContext  = &TBHorizontalPagingViewInsetContext;
static void *TBHorizontalPagingViewPanContext    = &TBHorizontalPagingViewPanContext;
static NSString *kPagingCellIdentifier            = @"kPagingCellIdentifier";
static NSInteger kPagingButtonTag                 = 1000;

#pragma mark - TBHorizontalPagingView
+ (TBHorizontalPagingView*)pagingViewWithHeaderView:(UIView *)headerView
                                        headerHeight:(CGFloat)headerHeight
                                      segmentButtons:(NSArray *)segmentButtons
                                       segmentHeight:(CGFloat)segmentHeight
                                        contentViews:(NSArray *)contentViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing          = 0.0;
    layout.minimumInteritemSpacing     = 0.0;
    layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
    
    TBHorizontalPagingView*pagingView = [[TBHorizontalPagingView alloc] initWithFrame:CGRectMake(0., 0., [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    pagingView.horizontalCollectionView = [[UICollectionView alloc] initWithFrame:pagingView.bounds collectionViewLayout:layout];
    [pagingView.horizontalCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kPagingCellIdentifier];
    pagingView.horizontalCollectionView.backgroundColor                = [UIColor clearColor];
    pagingView.horizontalCollectionView.dataSource                     = pagingView;
    pagingView.horizontalCollectionView.delegate                       = pagingView;
    pagingView.horizontalCollectionView.pagingEnabled                  = YES;
    pagingView.horizontalCollectionView.showsHorizontalScrollIndicator = NO;
    pagingView.horizontalCollectionView.scrollsToTop                   = NO;
    if([pagingView.horizontalCollectionView respondsToSelector:@selector(setPrefetchingEnabled:)]) {
        pagingView.horizontalCollectionView.prefetchingEnabled = NO;
    }
    pagingView.headerView                     = headerView;
    pagingView.segmentButtons                 = segmentButtons;
    pagingView.contentViews                   = contentViews;
    pagingView.headerViewHeight               = headerHeight;
    pagingView.segmentBarHeight               = segmentHeight;
    pagingView.scrollEnable                   = YES;
    pagingView.segmentButtonConstraintArray   = [NSMutableArray array];
    
    UICollectionViewFlowLayout *tempLayout = (id)pagingView.horizontalCollectionView.collectionViewLayout;
    tempLayout.itemSize = pagingView.horizontalCollectionView.frame.size;
    
    [pagingView addSubview:pagingView.horizontalCollectionView];
    [pagingView configureHeaderView];
    [pagingView configureSegmentView];
    [pagingView configureContentView];
    
    return pagingView;
}

- (void)scrollToIndex:(NSInteger)pageIndex {
    [self segmentButtonEvent:self.segmentButtons[pageIndex]];
}

- (void)switchEnable:(BOOL)enable {
    if(enable) {
        self.segmentView.userInteractionEnabled     = YES;
        self.horizontalCollectionView.scrollEnabled = YES;
        self.scrollEnable                           = YES;
    }else {
        self.segmentView.userInteractionEnabled     = NO;
        self.horizontalCollectionView.scrollEnabled = NO;
        self.scrollEnable                           = NO;
    }
}

- (void)scrollEnable:(BOOL)enable {
    if(enable) {
        self.horizontalCollectionView.scrollEnabled = YES;
        self.scrollEnable                           = YES;
    }else {
        self.horizontalCollectionView.scrollEnabled = NO;
        self.scrollEnable                           = NO;
    }
}

- (void)configureHeaderView {
    if(self.headerView) {
        self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.headerView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        self.headerOriginYConstraint = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        [self addConstraint:self.headerOriginYConstraint];
        
        self.headerSizeHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.headerViewHeight];
        [self.headerView addConstraint:self.headerSizeHeightConstraint];
    }
}

- (void)configureSegmentView {
    
    if(self.segmentView) {
        self.segmentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.segmentView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView ? : self attribute:self.headerView ? NSLayoutAttributeBottom : NSLayoutAttributeTop multiplier:1 constant:0]];
        [self.segmentView addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.segmentBarHeight]];
    }
}

- (void)configureContentView {
    for(UIScrollView *v in self.contentViews) {
        [v setContentInset:UIEdgeInsetsMake(self.headerViewHeight+self.segmentBarHeight, v.contentInset.left, v.contentInset.bottom, v.contentInset.right)];
        v.alwaysBounceVertical = YES;
        v.showsVerticalScrollIndicator = NO;
//        v.contentOffset = CGPointMake(0., -self.headerViewHeight-self.segmentBarHeight);
        [v.panGestureRecognizer addObserver:self forKeyPath:NSStringFromSelector(@selector(state)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&TBHorizontalPagingViewPanContext];
        [v addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&TBHorizontalPagingViewScrollContext];
        [v addObserver:self forKeyPath:NSStringFromSelector(@selector(contentInset)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&TBHorizontalPagingViewInsetContext];
        
        if (@available(iOS 11.0, *)) {
            v.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
    }
    self.currentScrollView = [self.contentViews firstObject];
}

- (UIView *)segmentView {
    if(!_segmentView) {
        _segmentView = [[UIView alloc] init];
        [self configureSegmentButtonLayout];
    }
    return _segmentView;
}

- (void)configureSegmentButtonLayout {
    if([self.segmentButtons count] > 0) {
        
        CGFloat buttonTop    = 0.f;
        CGFloat buttonLeft   = 0.f;
        CGFloat buttonWidth  = 0.f;
        CGFloat buttonHeight = 0.f;
        if(CGSizeEqualToSize(self.segmentButtonSize, CGSizeZero)) {
            buttonWidth = [[UIScreen mainScreen] bounds].size.width/(CGFloat)[self.segmentButtons count];
            buttonHeight = self.segmentBarHeight;
        }else {
            buttonWidth = self.segmentButtonSize.width;
            buttonHeight = self.segmentButtonSize.height;
            buttonTop = (self.segmentBarHeight - buttonHeight)/2.f;
            buttonLeft = ([[UIScreen mainScreen] bounds].size.width - ((CGFloat)[self.segmentButtons count]*buttonWidth))/((CGFloat)[self.segmentButtons count]+1);
        }
        
        [_segmentView removeConstraints:self.segmentButtonConstraintArray];
        for(int i = 0; i < [self.segmentButtons count]; i++) {
            UIButton *segmentButton = self.segmentButtons[i];
            [segmentButton removeConstraints:self.segmentButtonConstraintArray];
            segmentButton.tag = kPagingButtonTag+i;
            [segmentButton addTarget:self action:@selector(segmentButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
            [_segmentView addSubview:segmentButton];
            
            if(i == 0) {
                [segmentButton setSelected:YES];
            }
            
            segmentButton.translatesAutoresizingMaskIntoConstraints = NO;
            
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:segmentButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_segmentView attribute:NSLayoutAttributeTop multiplier:1 constant:buttonTop];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:segmentButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_segmentView attribute:NSLayoutAttributeLeft multiplier:1 constant:i*buttonWidth+buttonLeft*i+buttonLeft];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:segmentButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:buttonWidth];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:segmentButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:buttonHeight];
            
            [self.segmentButtonConstraintArray addObject:topConstraint];
            [self.segmentButtonConstraintArray addObject:leftConstraint];
            [self.segmentButtonConstraintArray addObject:widthConstraint];
            [self.segmentButtonConstraintArray addObject:heightConstraint];
            
            [_segmentView addConstraint:topConstraint];
            [_segmentView addConstraint:leftConstraint];
            [segmentButton addConstraint:widthConstraint];
            [segmentButton addConstraint:heightConstraint];
        }
        
    }
}

- (void)segmentButtonEvent:(UIButton *)segmentButton {
    for(UIButton *b in self.segmentButtons) {
        [b setSelected:NO];
        
    }
    [segmentButton setSelected:YES];
    
    NSInteger clickIndex = segmentButton.tag-kPagingButtonTag;
    
    [self.horizontalCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:clickIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if(self.currentScrollView.contentOffset.y<-(self.headerViewHeight+self.segmentBarHeight)) {
        [self.currentScrollView setContentOffset:CGPointMake(self.currentScrollView.contentOffset.x, -(self.headerViewHeight+self.segmentBarHeight)) animated:NO];
    }else {
        [self.currentScrollView setContentOffset:self.currentScrollView.contentOffset animated:NO];
    }
    
    //Avoid the contentView space bug when switch content and scroll down/up immediately
    //Restore scrollEnabled in next runloop
    self.currentScrollView.scrollEnabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.currentScrollView.scrollEnabled = YES;
    });
    
    self.currentScrollView = self.contentViews[clickIndex];
    
    if(self.pagingViewSwitchBlock) {
        self.pagingViewSwitchBlock(clickIndex);
    }
    
}

- (void)adjustContentViewOffset {
    self.isSwitching = YES;
    CGFloat headerViewDisplayHeight = self.headerViewHeight + self.headerView.frame.origin.y;
    [self.currentScrollView layoutIfNeeded];
    if(self.currentScrollView.contentOffset.y < -self.segmentBarHeight) {
        //如果视图滚动的offsetY小于segmentBar，说明视图与segmentBar处于分离状态。则调整视图offsetY到segmentBar下方
        [self.currentScrollView setContentOffset:CGPointMake(0, -headerViewDisplayHeight - self.segmentBarHeight)];
    }else {
        //如果当前滚动区域不足以将segmentBar滑到顶部，则调整offsetY
        if(self.currentScrollView.contentOffset.y + self.currentScrollView.bounds.size.height > self.currentScrollView.contentSize.height - headerViewDisplayHeight + self.segmentTopSpace) {
            [self.currentScrollView setContentOffset:CGPointMake(0, self.currentScrollView.contentOffset.y - headerViewDisplayHeight + self.segmentTopSpace)];
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0)), dispatch_get_main_queue(), ^{
        self.isSwitching = NO;
    });
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    if(point.x < 20) {
        return NO;
    }
    return YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isDescendantOfView:self.headerView] || [view isDescendantOfView:self.segmentView]) {
        self.horizontalCollectionView.scrollEnabled = NO;
        
        self.currentTouchView = nil;
        self.currentTouchButton = nil;
        
        [self.segmentButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj == view) {
                self.currentTouchButton = obj;
            }
        }];
        if(!self.currentTouchButton) {
            self.currentTouchView = view;
        }else {
            return view;
        }
        return self.currentScrollView;
    }
    return view;
}

#pragma mark - Setter
- (void)setSegmentTopSpace:(CGFloat)segmentTopSpace {
    if(segmentTopSpace > self.headerViewHeight) {
        _segmentTopSpace = self.headerViewHeight;
    }else {
        _segmentTopSpace = segmentTopSpace;
    }
}

- (void)setSegmentButtonSize:(CGSize)segmentButtonSize {
    _segmentButtonSize = segmentButtonSize;
    [self configureSegmentButtonLayout];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.contentViews count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.isSwitching = YES;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPagingCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    for(UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    [cell.contentView addSubview:self.contentViews[indexPath.row]];
    
    UIScrollView *v = self.contentViews[indexPath.row];
    
    CGFloat scrollViewHeight = v.frame.size.height;
    
    v.translatesAutoresizingMaskIntoConstraints = NO;
    [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:scrollViewHeight == 0 ? 0 : -(cell.contentView.frame.size.height-v.frame.size.height)]];
    [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    self.currentScrollView = v;
    [self adjustContentViewOffset];
    
    return cell;
    
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(__unused id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if(context == &TBHorizontalPagingViewPanContext) {
        
        if(self.scrollEnable) {
            self.horizontalCollectionView.scrollEnabled = YES;
        }
        UIGestureRecognizerState state = [change[NSKeyValueChangeNewKey] integerValue];
        //failed说明是点击事件
        if(state == UIGestureRecognizerStateFailed) {
            if(self.currentTouchButton) {
                [self segmentButtonEvent:self.currentTouchButton];
            }else if(self.currentTouchView && self.clickEventViewsBlock) {
                self.clickEventViewsBlock(self.currentTouchView);
            }
            self.currentTouchView = nil;
            self.currentTouchButton = nil;
        }
        
    }else if (context == &TBHorizontalPagingViewScrollContext) {
        self.currentTouchView = nil;
        self.currentTouchButton = nil;
        if (self.isSwitching) {
            return;
        }
        
        CGFloat oldOffsetY          = [change[NSKeyValueChangeOldKey] CGPointValue].y;
        CGFloat newOffsetY          = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        CGFloat deltaY              = newOffsetY - oldOffsetY;
        
        CGFloat headerViewHeight    = self.headerViewHeight;
        CGFloat headerDisplayHeight = self.headerViewHeight+self.headerOriginYConstraint.constant;
        
        if(deltaY >= 0) {    //向上滚动
            
            if(headerDisplayHeight - deltaY <= self.segmentTopSpace) {
                self.headerOriginYConstraint.constant = -headerViewHeight+self.segmentTopSpace;
            }else {
                self.headerOriginYConstraint.constant -= deltaY;
            }
            if(headerDisplayHeight <= self.segmentTopSpace) {
                self.headerOriginYConstraint.constant = -headerViewHeight+self.segmentTopSpace;
            }
            
            if (self.headerOriginYConstraint.constant >= 0 && self.magnifyTopConstraint) {
                self.magnifyTopConstraint.constant = -self.headerOriginYConstraint.constant;
            }
            
        }else {            //向下滚动
            
            if (headerDisplayHeight+self.segmentBarHeight < -newOffsetY) {
                self.headerOriginYConstraint.constant = -self.headerViewHeight-self.segmentBarHeight-self.currentScrollView.contentOffset.y;
            }
            
            if (self.headerOriginYConstraint.constant > 0 && self.magnifyTopConstraint) {
                self.magnifyTopConstraint.constant = -self.headerOriginYConstraint.constant;
            }
            
        }
        
        if(self.scrollViewDidScrollBlock) {
            self.scrollViewDidScrollBlock(newOffsetY);
        }
        
    }else if(context == &TBHorizontalPagingViewInsetContext) {
        
        if(self.currentScrollView.contentOffset.y > -self.segmentBarHeight) {
            return;
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.headerOriginYConstraint.constant = -self.headerViewHeight-self.segmentBarHeight-self.currentScrollView.contentOffset.y;
            [self layoutIfNeeded];
            [self.headerView layoutIfNeeded];
            [self.segmentView layoutIfNeeded];
        }];
        
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x/[[UIScreen mainScreen] bounds].size.width;
    
    for(UIButton *b in self.segmentButtons) {
        if(b.tag - kPagingButtonTag == currentPage) {
            [b setSelected:YES];
        }else {
            [b setSelected:NO];
        }
    }
    self.currentScrollView = self.contentViews[currentPage];
    
    if(self.pagingViewSwitchBlock) {
        self.pagingViewSwitchBlock(currentPage);
    }
}

- (void)dealloc {
    for(UIScrollView *v in self.contentViews) {
        [v.panGestureRecognizer removeObserver:self forKeyPath:NSStringFromSelector(@selector(state)) context:&TBHorizontalPagingViewPanContext];
        [v removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) context:&TBHorizontalPagingViewScrollContext];
        [v removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentInset)) context:&TBHorizontalPagingViewInsetContext];
    }
}

@end
