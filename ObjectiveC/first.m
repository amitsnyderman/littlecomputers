#import <Foundation/Foundation.h>

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
#pragma mark MyClass

@interface MyClass : NSObject {
	float myFloat;
	YourClass *friend;
}

- (void)hello;
- (float)myFloat;
- (void)setMyFloat:(float)val;
- (YourClass*)friend;
- (void)setFriend:(YourClass*)aFriend;

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

- (float)myFloat {
	return myFloat;
}

- (void)setMyFloat:(float)val {
	myFloat = val;
}

- (YourClass*)friend {
	return friend;
}

- (void)setFriend:(YourClass*)aFriend {
	[friend release];
	friend = [aFriend retain];
}

- (void)dealloc {
	[friend dealloc];
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
	
	YourClass *mine = [[YourClass alloc] init];
	[instance setFriend:mine];
	NSLog(@"This is my friend %@ and he says '%@'", [instance friend], [[instance friend] goodbye]);
	
	[mine release];
	[instance release];
	[pool release];
	
	return 0;
}