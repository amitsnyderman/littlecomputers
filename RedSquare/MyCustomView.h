#import <UIKit/UIKit.h>

@interface MyCustomView : UIView <UIAccelerometerDelegate> {
	CGRect square;
	CGFloat squareRotation;
	CGPoint moveOffset;
	
	BOOL isRotating;
	BOOL isMoving;
	
	IBOutlet UILabel *xField;
	IBOutlet UILabel *yField;
	IBOutlet UILabel *zField;
}
@end