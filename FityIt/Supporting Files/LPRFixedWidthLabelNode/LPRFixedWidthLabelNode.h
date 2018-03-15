#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, LPRFixedWidthLabelNodeTruncationMode) {
    LPRFixedWidthLabelNodeTruncationModeSuspensionPoints,
    LPRFixedWidthLabelNodeTruncationModeScale,
};

@interface LPRFixedWidthLabelNode : SKLabelNode

@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) LPRFixedWidthLabelNodeTruncationMode truncationMode;
@property (nonatomic) BOOL keepPunctuation;

- (instancetype)initWithMaxWidth:(CGFloat)maxWidth truncationMode:(LPRFixedWidthLabelNodeTruncationMode)truncationMode;
- (void)syncScale:(LPRFixedWidthLabelNode *)label2;
@end
