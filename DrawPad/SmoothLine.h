@interface SmoothLine : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
}
@property (retain) UIColor* currentColor;
@property float currentSize;
@property (retain) NSMutableArray* arrayStrokes;
@property (retain) NSMutableArray* arrayAbandonedStrokes;


-(void) setColor:(UIColor*)theColor;
-(void) viewJustLoaded;
-(void)undo;
-(void)redo;
-(void)clearCanvas;
@end
