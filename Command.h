#import <Foundation/Foundation.h>

@class NSNotification;

@interface Command : NSObject
{
  NSFileHandle *fileHandle;
  NSPipe *pipe;
}

//- (instancetype)init;
- (void)exec;
//- (void)cmd:(id) sender;
- (void)readData:(NSNotification *) not;
- (void)taskEnded:(NSNotification *) not;

@end
