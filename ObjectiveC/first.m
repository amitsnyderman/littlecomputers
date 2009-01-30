#import <Foundation/Foundation.h>

#pragma mark MyClass

@interface MyClass : NSObject {
	float myFloat;
}

- (void)hello;

@end

@implementation MyClass

- (id)init {
	self = [super init];
	if (self != nil) {
		myFloat = 5.0;
	}
	return self;
}

- (void)hello {
	NSLog(@"Hello, I'm your first Objective-C program!");
}

- (void)setMyFloat:(float)val {
	myFloat = val;
}

- (float)myFloat {
	return myFloat;
}

- (void)dealloc {
	[super dealloc];
}

@end

#pragma mark -
#pragma mark YourClass

@interface YourClass : NSObject {}

- (NSString*)goodbye;

@end

@implementation YourClass

- (id)init {
	self = [super init];
	return self;
}

- (NSString*)goodbye {
	return @"Goodbye, nice seeing you!";
}

- (void)dealloc {
	[super dealloc];
}

@end

#pragma mark -
#pragma mark Runtime

int main(int argc, char **argv) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	MyClass *instance = [[MyClass alloc] init];
	[instance hello];
	
	[instance setMyFloat:10.0f];
	NSLog(@"New value is %f", [instance myFloat]);
	
	[pool release];
	
	return 0;
}