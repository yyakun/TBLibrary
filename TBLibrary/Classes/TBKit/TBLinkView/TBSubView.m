//
//  TBSubView.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBSubView.h"

@implementation TBSubView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    BOOL theThingThatGotLoadedWasJustAPlaceholder = ([[self subviews] count] == 0);
    if (theThingThatGotLoadedWasJustAPlaceholder) {
        TBSubView *theRealThing = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        // pass properties through
        [self copyUIPropertiesTo:theRealThing];
        //auto layout
        self.translatesAutoresizingMaskIntoConstraints = NO;
        theRealThing.translatesAutoresizingMaskIntoConstraints = NO;
        return theRealThing;
    }
    return self;
}

- (void)copyUIPropertiesTo:(UIView *)view {
    // reflection did not work to get those lists, so I hardcoded them
    // any suggestions are welcome here
    NSArray *properties =
    [NSArray arrayWithObjects: @"frame",@"bounds", @"center", @"transform", @"contentScaleFactor", @"multipleTouchEnabled", @"exclusiveTouch", @"autoresizesSubviews", @"autoresizingMask", @"clipsToBounds", @"backgroundColor", @"alpha", @"opaque", @"clearsContextBeforeDrawing", @"hidden", @"contentMode", @"contentStretch", nil];
    // some getters have 'is' prefix
    NSArray *getters =
    [NSArray arrayWithObjects: @"frame", @"bounds", @"center", @"transform", @"contentScaleFactor", @"isMultipleTouchEnabled", @"isExclusiveTouch", @"autoresizesSubviews", @"autoresizingMask", @"clipsToBounds", @"backgroundColor", @"alpha", @"isOpaque", @"clearsContextBeforeDrawing", @"isHidden", @"contentMode", @"contentStretch", nil];
    for (int i=0; i<[properties count]; i++) {
        NSString *propertyName = [properties objectAtIndex:i];
        NSString *getter = [getters objectAtIndex:i];
        SEL getPropertySelector = NSSelectorFromString(getter);
        NSString *setterSelectorName =
        [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[propertyName substringToIndex:1] capitalizedString]];
        setterSelectorName = [NSString stringWithFormat:@"set%@:", setterSelectorName];
        SEL setPropertySelector = NSSelectorFromString(setterSelectorName);
        if ([self respondsToSelector:getPropertySelector] && [view respondsToSelector:setPropertySelector]) {
            NSObject *propertyValue = [self valueForKey:propertyName];
            [view setValue:propertyValue forKey:propertyName];
        }
    }
}

@end
