#import <UIKit/UIKit.h>
#import "SmoothLine.h"
@interface flycentViewController : UIViewController<UIScrollViewDelegate,UIWebViewDelegate>
{
    SmoothLine *controller;
}
@property (retain, nonatomic) IBOutlet UIButton *annotateBtn;
@property (retain, nonatomic) IBOutlet UIWebView *drawOnwebview;
- (IBAction)annotate:(id)sender;
@end
