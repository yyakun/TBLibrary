//
//  TBCyclePagerView.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/19.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBCyclePagerTransformLayout.h"

NS_ASSUME_NONNULL_BEGIN

// pagerView scrolling direction
typedef NS_ENUM(NSUInteger, TBPagerScrollDirection) {
    TBPagerScrollDirectionLeft,
    TBPagerScrollDirectionRight,
};

@class TBCyclePagerView;
@protocol TBCyclePagerViewDataSource <NSObject>

- (NSInteger)numberOfItemsInPagerView:(TBCyclePagerView *)pageView;

- (__kindof UICollectionViewCell *)pagerView:(TBCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index;

/**
 return pagerView layout,and cache layout
 */
- (TBCyclePagerViewLayout *)layoutForPagerView:(TBCyclePagerView *)pageView;

@end

@protocol TBCyclePagerViewDelegate <NSObject>

@optional

/**
 pagerView did scroll to new index page
 */
- (void)pagerView:(TBCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

/**
 pagerView did selected item cell
 */
- (void)pagerView:(TBCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index;

// custom layout
- (void)pagerView:(TBCyclePagerView *)pageView initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

- (void)pagerView:(TBCyclePagerView *)pageView applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;


// scrollViewDelegate

- (void)pagerViewDidScroll:(TBCyclePagerView *)pageView;

- (void)pagerViewWillBeginDragging:(TBCyclePagerView *)pageView;

- (void)pagerViewDidEndDragging:(TBCyclePagerView *)pageView willDecelerate:(BOOL)decelerate;

- (void)pagerViewWillBeginDecelerating:(TBCyclePagerView *)pageView;

- (void)pagerViewDidEndDecelerating:(TBCyclePagerView *)pageView;

- (void)pagerViewWillBeginScrollingAnimation:(TBCyclePagerView *)pageView;

- (void)pagerViewDidEndScrollingAnimation:(TBCyclePagerView *)pageView;

@end


@interface TBCyclePagerView : UIView

// will be automatically resized to track the size of the pagerView
@property (nonatomic, strong, nullable) UIView *backgroundView; 

@property (nonatomic, weak, nullable) id<TBCyclePagerViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id<TBCyclePagerViewDelegate> delegate;

// pager view layout
@property (nonatomic, strong, readonly) TBCyclePagerViewLayout *layout;

/**
 is infinite cycle pageview
 */
@property (nonatomic, assign) BOOL isInfiniteLoop;

/**
 pagerView automatic scroll time interval, default 0,disable automatic
 */
@property (nonatomic, assign) CGFloat autoScrollInterval;

/**
 current page index
 */
@property (nonatomic, assign, readonly) NSInteger curIndex;

// scrollView property
@property (nonatomic, assign, readonly) CGPoint contentOffset;
@property (nonatomic, assign, readonly) BOOL tracking;
@property (nonatomic, assign, readonly) BOOL dragging;
@property (nonatomic, assign, readonly) BOOL decelerating;


/**
 reload data, !!important!!: will clear layout and call delegate layoutForPagerView
 */
- (void)reloadData;

/**
 update data is reload data, but not clear layuot
 */
- (void)updateData;

/**
 if you only want update layout
 */
- (void)setNeedUpdateLayout;

/**
 will set layout nil and call delegate->layoutForPagerView
 */
- (void)setNeedClearLayout;

/**
 current index cell in pagerView
 */
- (__kindof UICollectionViewCell * _Nullable)curIndexCell;

/**
 visible cells in pageView
 */
- (NSArray<__kindof UICollectionViewCell *> *_Nullable)visibleCells;


/**
 visible pageView indexs, maybe repeat index
 */
- (NSArray *)visibleIndexs;

/**
 scroll to item at index
 */
- (void)scrollToItemAtIndex:(NSInteger)index animate:(BOOL)animate;

/**
 scroll to next or pre item
 */
- (void)scrollToNearlyIndexAtDirection:(TBPagerScrollDirection)direction animate:(BOOL)animate;

/**
 register pager view cell with class
 */
- (void)registerClass:(Class)Class forCellWithReuseIdentifier:(NSString *)identifier;

/**
 register pager view cell with nib
 */
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;

/**
 dequeue reusable cell for pagerView
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
