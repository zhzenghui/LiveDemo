//
//  LGDLoadAlbumPhoto.m
//  LiveGaming
//
//  Created by xy on 16/3/11.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "LGDLoadAlbumPhoto.h"


#define _IPHONE90_ 90000


typedef NS_ENUM(NSUInteger, LGDLoadAlbumPhotoError) {
    LGDLoadAlbumPhotoCancel,
    LGDLoadAlbumPhotoNoPhoto,
};

NSString *ewd = @"LGDLoadAlbumPhoto";

@interface LGDLoadAlbumPhoto()

@property(nonatomic, copy) finishBlock finishBlock;
@property(nonatomic, strong) UIImagePickerController *imagePicker;



@end

@implementation LGDLoadAlbumPhoto
- (void)openAlbumMenuFromViewController:(UIViewController *)viewController
                                 finish:(finishBlock)finish
{
    self.viewController = viewController;
    self.finishBlock = finish;
    



#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE90_
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [self openAlbumFrom:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbumFrom:UIImagePickerControllerSourceTypeCamera];
    }]];
    
    [self.viewController presentViewController:alert animated:YES completion:nil];
#else
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"选择图片来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相册", @"相机",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:viewController.view];
    
#endif

}


- (void)openAlbumFrom:(UIImagePickerControllerSourceType)sourceType {
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate =  (id) self.viewController;
    self.imagePicker.sourceType = sourceType;// UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.imagePicker.allowsEditing = YES;

    [self.viewController presentViewController:self.imagePicker animated:YES completion:^{
        
    }];
}

#pragma mark - imagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSLog(@"didFinishPickingMediaWithInfo");
    self.finishBlock(nil, nil);
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    NSLog(@"imagePickerControllerDidCancel");

    NSDictionary *userInfo = @{@"msg": @"picker用户取消"};
    NSError *error = [NSError errorWithDomain:ewd code:LGDLoadAlbumPhotoCancel userInfo:userInfo];
    self.finishBlock(nil, error);

    [self.viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - actionSheet


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
    }else if (buttonIndex == 1) {
        [self openAlbumFrom:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }else if(buttonIndex == 2) {
        [self openAlbumFrom:UIImagePickerControllerSourceTypeCamera];
    }
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
    NSString *ewd = @"LGDLoadAlbumPhoto";
    NSDictionary *userInfo = @{@"msg": @"用户取消选择"};
    NSError *error = [NSError errorWithDomain:ewd code:LGDLoadAlbumPhotoCancel userInfo:userInfo];
    
    self.finishBlock(nil, error);
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}

@end
