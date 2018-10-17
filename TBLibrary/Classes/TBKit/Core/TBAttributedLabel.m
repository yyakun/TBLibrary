//
//  TBAttributedLabel.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBAttributedLabel.h"

@interface TBAttributedLabel()

@property (nonatomic, strong) NSMutableAttributedString *attString;

@property (nonatomic, assign) CTFrameRef frameRef;

@end

@implementation TBAttributedLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    [self setText:self.text];
    [self setFont:self.font];
    [self setTextColor:self.textColor];
    [self setTextAlignment:self.textAlignment];
    self.userInteractionEnabled = YES;
}

- (void)dealloc
{
    if (self.frameRef) {
        CFRelease(_frameRef);
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.text) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.0, 0.0);
        CGContextScaleCTM(context, 1.0, -1.0);
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge  CFAttributedStringRef)_attString);
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGPathAddRect(pathRef,NULL , CGRectMake(0, 0, rect.size.width, rect.size.height));
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), pathRef,NULL );
        CFRelease(framesetter);
        CGContextTranslateCTM(context, 0, -rect.size.height);
        CTFrameDraw(frame, context);
        CGContextRestoreGState(context);
        if (self.frameRef) {
            CFRelease(self.frameRef);
        }
        
        self.frameRef = frame;
        CGPathRelease(pathRef);
        UIGraphicsPushContext(context);
    }
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (!text) {
        self.attString = nil;
    }else{
        self.attString = [[NSMutableAttributedString alloc] initWithString:text];
        [self setFont:self.font];
        [self setTextColor:self.textColor];
        [self setTextAlignment:self.textAlignment];
    }
}

- (void)setFrameForLabelWithFont:(UIFont*)font
{
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size = self.frame.size;
    if (self.text){
        size =[self.text boundingRectWithSize:CGSizeMake(size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    CGRect frame = self.frame;
    frame.size.height = size.height;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    [self setFrame:frame];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [_attString addAttribute:(NSString *)kCTFontAttributeName
                       value:(__bridge id)fontRef
                       range:NSMakeRange(0, _attString.length)];
    [self setFrameForLabelWithFont:font];
    CFRelease(fontRef);
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    [_attString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)textColor.CGColor range:NSMakeRange(0, _attString.length)];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    
    CTTextAlignment alignment;//对齐方式
    
    alignment = NSTextAlignmentToCTTextAlignment(textAlignment);
    
    CTParagraphStyleSetting paraStyles[1] = {
        {.spec = kCTParagraphStyleSpecifierAlignment,
            .valueSize = sizeof(CTTextAlignment),
            .value = (const void*)&alignment},
    };
    
    CTParagraphStyleRef style = CTParagraphStyleCreate(paraStyles,2);
    
    [_attString addAttribute:(NSString*)(kCTParagraphStyleAttributeName) value:(__bridge id)style range:NSMakeRange(0,[self.text length])];
    
    CFRelease(style);
}

/**
 *  设置某段字的颜色
 *
 *  @param color color to set
 *  @param location from index
 *  @param length length of text to change
 */
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length
{
    if (location < 0||location>self.text.length-1||length+location>self.text.length){
        return;
    }
    [_attString addAttribute:(NSString *)kCTForegroundColorAttributeName
                       value:(id)color.CGColor
                       range:NSMakeRange(location, length)];
}

/**
 *  设置某段字的字体
 *
 *  @param font     font to be set
 *  @param location from index
 *  @param length length of text to change
 */
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length
{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName,
                                             font.pointSize,
                                             NULL);
    [_attString addAttribute:(NSString *)kCTFontAttributeName
                       value:(__bridge id)fontRef
                       range:NSMakeRange(location, length)];
    CFRelease(fontRef);
}

/**
 *  设置某段字的下划线风格
 *
 *  @param style    style to be set
 *  @param location from index
 *  @param length   length of text to change
 */
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length
{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                       value:(id)[NSNumber numberWithInt:style]
                       range:NSMakeRange(location, length)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //获取UITouch对象
    UITouch *touch = [touches anyObject];
    //获取触摸点击当前view的坐标位置
    CGPoint location = [touch locationInView:self];
    //获取每一行
    CFArrayRef lines = CTFrameGetLines(self.frameRef);
    CGPoint origins[CFArrayGetCount(lines)];
    //获取每行的原点坐标
    CTFrameGetLineOrigins(self.frameRef, CFRangeMake(0, 0), origins);
    CTLineRef line = NULL;
    CGPoint lineOrigin = CGPointZero;
    for (int i= 0; i < CFArrayGetCount(lines); i++)
    {
        CGPoint origin = origins[i];
        CGPathRef path = CTFrameGetPath(self.frameRef);
        //获取整个CTFrame的大小
        CGRect rect = CGPathGetBoundingBox(path);
        //坐标转换，把每行的原点坐标转换为uiview的坐标体系
        CGFloat y = rect.origin.y + rect.size.height - origin.y;
        //判断点击的位置处于那一行范围内
        if ((location.y <= y) && (location.x >= origin.x))
        {
            line = CFArrayGetValueAtIndex(lines, i);
            lineOrigin = origin;
            break;
        }
    }
    
    location.x -= lineOrigin.x;
    //获取点击位置所处的字符位置，就是相当于点击了第几个字符
    CFIndex index = CTLineGetStringIndexForPosition(line, location);
    //判断点击的字符是否在需要处理点击事件的字符串范围内，这里是hard code了需要触发事件的字符串范围
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickTextWithIndex:)]) {
        [self.delegate clickTextWithIndex:index];
    }
    
}

@end
