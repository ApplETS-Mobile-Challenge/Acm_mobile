
#import <UIKit/UIKit.h>

@interface UIImage (BezierPath)

- (UIImage *)imageWithBezierPathFill:(UIBezierPath *)bezierPath;

- (UIImage *)imageWithBezierPathStroke:(UIBezierPath *)bezierPath;

@end
