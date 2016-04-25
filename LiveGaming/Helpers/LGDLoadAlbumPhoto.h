//
//  LGDLoadAlbumPhoto.h
//  LiveGaming
//
//  Created by xy on 16/3/11.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^finishBlock) (UIImage *resultData, NSError *error);

@protocol LGDLoadAlbumPhotoDelegate;
@interface LGDLoadAlbumPhoto : UIViewController <
    UIActionSheetDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate>

@property(nonatomic, assign) UIViewController *viewController;

/**
 *  打开选择载入相册、相机菜单
 *
 *  @param viewController 源控制器
 */
- (void)openAlbumMenuFromViewController:(UIViewController *)viewController
                                 finish:(finishBlock)finish;
@end

