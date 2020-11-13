#import <Foundation/Foundation.h>

@class NSNotification;

@interface Command : NSObject
{
  NSFileHandle *fileHandle;
  NSPipe *pipe;
}

- (void)exec;
//- (void)readData:(NSNotification *) not;
//- (void)taskEnded:(NSNotification *) not;

@end
