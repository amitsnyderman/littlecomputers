#import <UIKit/UIKit.h>

@interface MyCustomView : UIView <UIAccelerometerDelegate> {
	CGFloat squareSize;
	CGFloat rotation;
	CGColorRef aColor;
	BOOL twoFingers;
	
	IBOutlet UILabel *xField;
	IBOutlet UILabel *yField;
	IBOutlet UILabel *zField;
}
@end