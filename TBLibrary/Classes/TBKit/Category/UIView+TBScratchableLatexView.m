//
//  UIView+TBScratchableLatexView.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIView+TBScratchableLatexView.h"
#import "NSObject+TBRuntime.h"
#import "UIView+TBFrame.h"

@implementation UIView (TBScratchableLatexView)

+ (NSArray *)createViewsWithRowLine:(TBRowLine)rowLine location:(TBLocation)location viewClassName:(NSString *)viewClassName superView:(UIView *)superView {
    return [self createViewsWithRowLine:rowLine location:location viewClassName:viewClassName superView:superView lineWidth:0 lineColor:[UIColor clearColor] lineStyle:TBScratchableLatexViewNoneLineViewStyle];
}

+ (NSArray *)createViewsWithRowLine:(TBRowLine)rowLine location:(TBLocation)location viewClassName:(NSString *)viewClassName superView:(UIView *)superView lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor lineStyle:(TBScratchableLatexViewStyle)lineStyle {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:rowLine.row * rowLine.line];
    for (NSInteger i = 0; i < rowLine.row * rowLine.line; i++) {
        CGRect objectRect = CGRectMake(location.origin.x + ((i % rowLine.line) * (location.size.width + location.interval.horizontal)), location.origin.y + ((i / rowLine.line) * (location.size.height + location.interval.vertical)), location.size.width, location.size.height);
        UIView *object = [[NSClassFromString(viewClassName) alloc] initWithFrame:objectRect];
        [superView addSubview:object];
        NSString *objectIdentifier = [NSString stringWithFormat:@"view%ld", (long)i];
        object.objectIdentifier = objectIdentifier;
        [array addObject:object];
        
        if (lineStyle != TBScratchableLatexViewNoneLineViewStyle) {
            UIView *horizontalLineView = [self createLineView:superView number:i directionString:@"horizontal"];
            UIView *verticalLineView = [self createLineView:superView number:i directionString:@"vertical"];
            [horizontalLineView setBounds:CGRectMake(0, 0, location.size.width + location.interval.horizontal, lineWidth)];
            [verticalLineView setBounds:CGRectMake(0, 0, lineWidth, location.size.height + location.interval.vertical)];
            CGPoint lineOrigin = CGPointMake(objectRect.origin.x - location.interval.horizontal/2.0, objectRect.origin.y - location.interval.vertical/2.0);
            [horizontalLineView setOrigin:lineOrigin];
            [verticalLineView setOrigin:lineOrigin];
            horizontalLineView.backgroundColor = verticalLineView.backgroundColor = lineColor;
            
            if (i < rowLine.line) {
                if (lineStyle == TBScratchableLatexViewStyleNoneAroundLineViewStyle) {
                    horizontalLineView.hidden = YES;
                } else {
                    [horizontalLineView setOrigin:CGPointMake(lineOrigin.x, lineOrigin.y + location.interval.vertical/2.0)];
                }
                [verticalLineView setBounds:CGRectMake(0, 0, lineWidth, location.size.height + location.interval.vertical/2.0)];
                [verticalLineView setOrigin:CGPointMake(lineOrigin.x, lineOrigin.y + (location.interval.vertical/2.0))];
            }
            
            if (0 == (i % rowLine.line)) {
                [horizontalLineView setBounds:CGRectMake(0, 0, location.size.width + location.interval.horizontal/2.0, lineWidth)];
                if (i == 0) {
                    [horizontalLineView setOrigin:CGPointMake(lineOrigin.x + location.interval.horizontal/2.0, lineOrigin.y + location.interval.vertical/2.0)];
                    [verticalLineView setOrigin:CGPointMake(lineOrigin.x + location.interval.horizontal/2.0, lineOrigin.y + location.interval.vertical/2.0)];
                } else {
                    [horizontalLineView setOrigin:CGPointMake(lineOrigin.x + location.interval.horizontal/2.0, lineOrigin.y)];
                }
            } else if ((rowLine.line - 1) == (i % rowLine.line)) {
                [horizontalLineView setBounds:CGRectMake(0, 0, location.size.width + location.interval.horizontal/2.0, lineWidth)];
                if (i == rowLine.line - 1) {
                    [horizontalLineView setOrigin:CGPointMake(lineOrigin.x, lineOrigin.y + location.interval.vertical/2.0)];
                } else {
                    [horizontalLineView setOrigin:CGPointMake(lineOrigin.x, lineOrigin.y)];
                }
            }
            
            if (i >= (rowLine.row - 1) * rowLine.line) {
                [verticalLineView setBounds:CGRectMake(0, 0, lineWidth, location.size.height + location.interval.vertical/2.0)];
                [verticalLineView setOrigin:CGPointMake(objectRect.origin.x - location.interval.horizontal/2.0, objectRect.origin.y - location.interval.vertical/2.0)];
                if (lineStyle == TBScratchableLatexViewStyleNoneLeftAndRightLineViewStyle || lineStyle == TBScratchableLatexViewStyleAroundLineViewStyle) {
                    static int count = -1;
                    count++;
                    UIView *horizontalLineView = [self createLineView:superView number:(i + rowLine.line) directionString:@"horizontal"];
                    CGPoint lineOrigin = CGPointMake(objectRect.origin.x - location.interval.horizontal/2.0, objectRect.origin.y - location.interval.vertical/2.0 + location.size.height + location.interval.vertical/2.0);
                    horizontalLineView.backgroundColor = lineColor;
                    if (0 == (i % rowLine.line) || (rowLine.line - 1) == (i % rowLine.line)) {
                        [horizontalLineView setBounds:CGRectMake(0, 0, location.size.width + location.interval.horizontal/2.0, lineWidth)];
                    } else {
                        [horizontalLineView setBounds:CGRectMake(0, 0, location.size.width + location.interval.horizontal, lineWidth)];
                    }
                    
                    if (i == (rowLine.row - 1) * rowLine.line) {
                        [horizontalLineView setOrigin:CGPointMake(lineOrigin.x + location.interval.horizontal/2.0, lineOrigin.y)];
                    } else {
                        [horizontalLineView setOrigin:CGPointMake(lineOrigin.x, lineOrigin.y)];
                    }
                }
            }
            
            if (lineStyle == TBScratchableLatexViewStyleAroundLineViewStyle) {
                if ((rowLine.line - 1) == (i % rowLine.line)) {
                    static int count = -1;
                    count++;
                    UIView *verticalLineView = [self createLineView:superView number:(rowLine.row * rowLine.line + count) directionString:@"vertical"];
                    CGPoint lineOrigin = CGPointMake(objectRect.origin.x - location.interval.horizontal/2.0 + location.size.width + location.interval.horizontal/2.0, objectRect.origin.y - location.interval.vertical/2.0);
                    [verticalLineView setBounds:CGRectMake(0, 0, lineWidth, location.size.height + location.interval.vertical)];
                    verticalLineView.backgroundColor = lineColor;
                    if (i == rowLine.line - 1) {
                        [verticalLineView setBounds:CGRectMake(0, 0, lineWidth, location.size.height + location.interval.vertical/2.0)];
                        [verticalLineView setOrigin:CGPointMake(lineOrigin.x, lineOrigin.y + location.interval.vertical/2.0)];
                    } else {
                        if (i == (rowLine.row * rowLine.line - 1)) {
                            [verticalLineView setBounds:CGRectMake(0, 0, lineWidth, location.size.height + location.interval.vertical/2.0)];
                        }
                        [verticalLineView setOrigin:CGPointMake(lineOrigin.x, lineOrigin.y)];
                    }
                }
            }
            
            if (0 == (i % rowLine.line)) {
                if (i != 0) {
                    [verticalLineView setOrigin:CGPointMake(lineOrigin.x + location.interval.horizontal/2.0, lineOrigin.y)];
                }
                if (lineStyle == TBScratchableLatexViewStyleNoneAroundLineViewStyle || lineStyle == TBScratchableLatexViewStyleNoneLeftAndRightLineViewStyle) {
                    [verticalLineView removeFromSuperview];
                }
            }
        }
    }
    return array;
}

+ (UIView *)createLineView:(UIView *)superview number:(NSInteger)number directionString:(NSString *)directionString {
    UIView *lineView = [[UIView alloc] init];
    [superview addSubview:lineView];
    NSString *objectIdentifier = [NSString stringWithFormat:@"%@LineView%ld", directionString, (long)number];
    lineView.objectIdentifier = objectIdentifier;
    return lineView;
}

@end
