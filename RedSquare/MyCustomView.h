#import <UIKit/UIKit.h>

@interface MyCustomView : UIView <UIAccelerometerDelegate> {
	CGFloat squareSize;
	CGFloat squareRotation;
	CGPoint squareCenter;
	CGColorRef aColor;
	BOOL twoFingers;
	
	IBOutlet UILabel *xField;
	IBOutlet UILabel *yField;
	IBOutlet UILabel *zField;
}
@end