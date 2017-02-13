//
//  DLLScrollView.h
//  InLife
//
//  Created by DLL on 15/8/20.
//  Copyright (c) 2015年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLLPageScrollView;
@protocol DLLPageScrollViewDelegate <UIScrollViewDelegate>
@required
// 获取视图
- (UIView*)pageScrollView:(DLLPageScrollView*)scrollView viewUseConvertView:(UIView*)convertView atIndex:(NSUInteger)index;

// 总页数
- (NSUInteger)pageScrollViewNumberOfPages:(DLLPageScrollView*)scrollView;
@optional
// 翻页回调
- (void)pageScrollView:(DLLPageScrollView*)scrollView willChangePageToIndex:(NSUInteger)index;

@end



@interface DLLPageScrollView : UIScrollView  {
    NSUInteger _selectedIndex;
    NSUInteger _totalPage;
    
    BOOL _notPerformScroll;
}
@property (weak, nonatomic) id<DLLPageScrollViewDelegate> delegate;
@property (assign, nonatomic) NSUInteger selectedIndex;

@property (strong, nonatomic) UIView *foreView;
@property (strong, nonatomic) UIView *backView;

// 翻到下一页
- (void)scrollToNextPage;
// 翻到上一页
- (void)scrollToPreviousPage;
// 重新加载
- (void)reload;

/**
 *  检查子视图是否已经加入到scrollView中。如果没有加入，则将其加入
 *
 *  @param subview 子视图
 */
- (void)checkToAddSubview:(UIView *)subview;

/**
 *  当调用reload会调用这个方法，子类需要重写。
 */
- (void)layoutPages;

/**
 *  当滚动的时候会调用，子类可以重写。
 */
- (void)didScroll;

@end
