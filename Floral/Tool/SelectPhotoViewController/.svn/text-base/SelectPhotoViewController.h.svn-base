//
//  SelectPhotoViewController.h
//  QianfengSchool
//
//  Created by AlicePan on 16/8/10.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^presentBlock)(id viewController);
typedef void(^dismissBlock)(id dismissVC);
//imageArray 存储的是NSData类型的图片原图数组 
typedef void(^selectImageBlock)(NSMutableArray *imageArray,NSMutableArray *nameArray,NSMutableArray *sizeArray,NSMutableArray *userNameArray);

@interface SelectPhotoViewController : BaseViewController

//用户选择的属性
@property (assign, nonatomic) NSInteger selectPhotoMaxCount;/**< 可以选择最多的照片个数, 默认9张*/
@property (assign, nonatomic) BOOL isKeepLastImage;/**< 是否保留上次的图片 默认是no*/
@property (assign, nonatomic) BOOL isCompressImage;/**< 是否在选择完图片或拍完照之后就压缩图片 默认是NO不压缩*/


@property (copy, nonatomic) presentBlock presentBlock;/**<界面跳转 */
@property (copy, nonatomic) dismissBlock dismissBlock;/**<界面跳转 */
@property (copy, nonatomic) selectImageBlock selectImageBlock;/**<选中的图片 */

@property (strong, nonatomic) NSMutableArray *mutArr;/**<仅从相册选择的图片 */
@property (strong, nonatomic) NSMutableArray *imageNameArray;/**<选择上传的图片名字数组 */
@property (strong, nonatomic) NSMutableArray *imageSizeArray;/**<选择上传的图片大小数组 */
@property (strong, nonatomic) NSMutableArray *imageUsernameArray;/**<图片重命名 */

+ (SelectPhotoViewController *)sharedInstance;

- (NSData *)compressImage:(UIImage *)image;

- (void)selectPhotoAction;

- (void)VCPresentWithBlock:(presentBlock)block;
- (void)VCDismissWithBlock:(dismissBlock)block;
- (void)selectImageWithBlock:(selectImageBlock)block;

@end
