#import "LPRFixedWidthLabelNode.h"

#define DEFAULT_TRUNCATION_SUFIX @"..."
#define DEFAULT_TRUNCATION_PROTECTED_LAST_CHARACTERS @"?!:;'\""

@interface LPRFixedWidthLabelNode ()

@property (nonatomic) NSString *origialText;

@end

@implementation LPRFixedWidthLabelNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        _keepPunctuation = YES;
        self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    }
    return self;
}

- (instancetype)initWithMaxWidth:(CGFloat)maxWidth truncationMode:(LPRFixedWidthLabelNodeTruncationMode)truncationMode
{
    self = [self init];
    if (self) {
        _maxWidth = maxWidth;
        _truncationMode = truncationMode;
    }
    return self;
}

- (void)syncScale:(LPRFixedWidthLabelNode *)label2 {
    CGFloat minScale = MIN(self.xScale, label2.xScale);
    [self setScale:minScale];
    [label2 setScale:minScale];
}
#pragma mark - Setters

- (void)setText:(NSString *)text
{
    self.origialText = text;
    [super setText:text];
    [self redraw];
}

- (void)setMaxWidth:(CGFloat)maxWidth
{
    _maxWidth = maxWidth;
    [self setScale:1.0];
    self.text = self.origialText;
}

- (void)setTruncationMode:(LPRFixedWidthLabelNodeTruncationMode)truncationMode
{
    _truncationMode = truncationMode;
    self.text = self.origialText;

}

- (void)setKeepPunctuation:(BOOL)keepPunctuation
{
    _keepPunctuation = keepPunctuation;
    self.text = self.origialText;
}

#pragma mark - Configuration

- (void)redraw
{
    if (self.frame.size.width > self.maxWidth && self.text.length > 0 && self.maxWidth > 0)
        switch (self.truncationMode) {
            case LPRFixedWidthLabelNodeTruncationModeSuspensionPoints:
                [self truncate];
                break;
            case LPRFixedWidthLabelNodeTruncationModeScale:
            default:
                [self rescale];
                break;
        }
}

- (void)rescale
{
    [self setScale:self.maxWidth/self.frame.size.width];
}

- (void)truncate
{
    NSString *lastChar = [self.text substringFromIndex:self.text.length-1];
    NSCharacterSet *pontuation = [NSCharacterSet characterSetWithCharactersInString:DEFAULT_TRUNCATION_PROTECTED_LAST_CHARACTERS];
    NSRange range = [lastChar rangeOfCharacterFromSet:pontuation];
    NSString *sufix;
    if (range.length > 0 && self.keepPunctuation) {
        sufix = [DEFAULT_TRUNCATION_SUFIX stringByAppendingString:lastChar];
        super.text = [[self.text substringToIndex:self.text.length-3] stringByAppendingString:sufix];
        while (![self textFits:self] && self.text.length > sufix.length) {
            super.text = [[self.text substringToIndex:self.text.length-5] stringByAppendingString:sufix];
        }
    } else {
        sufix = DEFAULT_TRUNCATION_SUFIX;
        super.text = [[self.text substringToIndex:self.text.length-3] stringByAppendingString:sufix];
        while (![self textFits:self] && self.text.length > sufix.length) {
            super.text = [[self.text substringToIndex:self.text.length-4] stringByAppendingString:sufix];
        }
    }
}

- (BOOL)textFits:(SKLabelNode *)label
{
    if (label.frame.size.width > self.maxWidth)
        return NO;
    else
        return YES;
}

#pragma mark - Lazy instantiations

- (NSString *)origialText
{
    if (!_origialText) {
        _origialText = self.text;
    }
    return _origialText;
}

@end
