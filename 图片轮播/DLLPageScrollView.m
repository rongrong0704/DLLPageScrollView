//
//  DLLScrollView.m
//  InLife
//
//  Created by DLL on 15/8/20.
//  Copyright (c) 2015年 Joe. All rights reserved.
//

#import "DLLPageScrollView.h"

@implementation DLLPageScrollView {
    __weak id <DLLPageScrollViewDelegate> _delegate;
    BOOL _needsToReload;
}


@dynamic delegate;
@synthesize selectedIndex = _selectedIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doInit];
    }
    return self;
}

- (id)init
{
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self doInit];
    }
    return self;
}


- (void)checkToAddSubview:(UIView *)subview {
    if (subview.superview == nil) {
        [self addSubview:subview];
    }
}

- (void)doInit {
    self.scrollsToTop = NO;
    self.backgroundColor = [UIColor clearColor];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    [self addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!_notPerformScroll) {
        [self didScroll];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_needsToReload) {
        _needsToReload = NO;
        [self reload];
    }
}


- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)setDelegate:(id<DLLPageScrollViewDelegate>)delegate
{
    _delegate = delegate;
    [super setDelegate:delegate];
}

- (id<DLLPageScrollViewDelegate>)delegate {
    return _delegate;
}


- (void)scrollToNextPage {
    
}

- (void)scrollToPreviousPage {
    
}

- (void)didScroll {

}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)reload {
    _totalPage = [_delegate pageScrollViewNumberOfPages:self];
    if (_selectedIndex >= _totalPage) {
        _selectedIndex = _totalPage - 1;
    } 
    if (self.bounds.size.width == 0) {
        _needsToReload = YES;
    } else {
        [self layoutPages];
    }
    
    if ([self.delegate respondsToSelector:@selector(pageScrollView:willChangePageToIndex:)]) {
        [self.delegate pageScrollView:self willChangePageToIndex:_selectedIndex];
    }
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex >= [_delegate pageScrollViewNumberOfPages:self]) {
        _selectedIndex = 0;
    } else {
        _selectedIndex = selectedIndex;
    }
    [self reload];
}


- (void)layoutPages {
    
}
@end
