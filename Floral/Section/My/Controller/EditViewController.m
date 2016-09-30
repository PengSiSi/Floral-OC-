//
//  EditViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/12.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "EditViewController.h"
#import "UIBarButtonItem+Create.h"
#import "textViewPlaceHolder.h"
#import "AddPhotoCell.h"
#import "SelectPhotoViewController.h"
#import "WSelectPhotoPickerViewController.h"
#import "WSelectPhotoAssets.h"
#import "MJPhoto.h"
#import "ELCImagePickerController.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SelectJobViewController.h"

static NSString *const identify = @"cell";
static NSString *const AddPhotoCellIdentify = @"AddPhotoCell";

@interface EditViewController ()<UITableViewDataSource,UITableViewDelegate,AddPhotoCellDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ELCImagePickerControllerDelegate>
{
    AddPhotoCell *cell;
    UILabel *label;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *itemsSectionPictureArray;

@end

@implementation EditViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self setNav];
    [self receviewNotification];
}

#pragma mark - 接收通知

-(void)receviewNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updatePhotoCount:) name:kAddCellPhotoCount object:nil];
}

- (void)updatePhotoCount: (NSNotification *)notification{

    NSLog(@"%@", notification.userInfo);
    NSString *count = notification.userInfo[@"count"];
    label.text = [NSString stringWithFormat:@"  添加照片(%@/9)",count];
}

#pragma mark - 创建导航栏

- (void)setNav{
    
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highLightedImage:nil target:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithTitle:@"下一步" tintColor:[UIColor orangeColor] target:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)leftItemClick{
    
    
}

- (void)nextStep{
    
    NSLog(@"下一步");
    if (!(self.itemsSectionPictureArray.count > 0)) {
        [SVProgressHUD showInfoWithStatus:@"至少选择一张照片哟!!!"];
        return;
    }
    else{
        SelectJobViewController *jobVc = [[SelectJobViewController alloc]init];
        [self.navigationController pushViewController:jobVc animated:YES];
    }
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identify];
    [self.tableView registerClass:[AddPhotoCell class] forCellReuseIdentifier:AddPhotoCellIdentify];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        textViewPlaceHolder *textView = [[textViewPlaceHolder alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 100)];
        textView.font = [UIFont systemFontOfSize:15.0f];
        textView.placeHolderText = @"输入文章内容(最多输入140字)";
        [cell1.contentView addSubview:textView];
        return cell1;
    }
    else{
      
        cell = [tableView dequeueReusableCellWithIdentifier:AddPhotoCellIdentify forIndexPath:indexPath];
        cell.delegate = self;
        cell.backgroundColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    return 500;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    else
        return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"  添加照片(0/9)";
        return label;
    }
    return nil;
}

- (void)didAddPhoto:(AddPhotoCell *)cell{
    
    NSLog(@"添加图片...");
    //判断个数是不是超过了八张图片
    if (self.itemsSectionPictureArray.count > 8) {
        return;
    }
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机选择",@"精美配图", @"拍照", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
}

#pragma mark - 相册,相机的调用代理方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        NSLog(@"点击了从手机选择");
        
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc]initImagePicker];
        elcPicker.maximumImagesCount = 9 - self.itemsSectionPictureArray.count;
        elcPicker.returnsOriginalImage = YES;
        elcPicker.returnsImage = YES;
        
        //需要导入此框架  #import <MobileCoreServices/MobileCoreServices.h>
        
        elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
        elcPicker.imagePickerDelegate = self;  //设置代理
        [self presentViewController:elcPicker animated:YES completion:nil];
        
    }
    else if (buttonIndex == 1){
        
        NSLog(@"点击了精美配图");
        
    }
    else if (buttonIndex == 2){
        
        NSLog(@"点击了拍照");
        
        UIImagePickerControllerSourceType source = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            
            //拍照后图片可被编辑
            picker.allowsEditing = YES;
            picker.sourceType = source;
            picker.modalTransitionStyle = UIModalTransitionStylePartialCurl;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else{
            NSLog(@"模拟器不具备拍照功能");
        }
    }
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    __weak EditViewController *wself = self;
    
    [self dismissViewControllerAnimated:YES completion:^{
        BOOL hasVideo = NO;
        
        NSMutableArray *images = [NSMutableArray array];
        for (NSDictionary *dict in info) {
            if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
                if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                    UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                    [images addObject:image];
                } else {
                    NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
                }
                
                //#import <AssetsLibrary/AssetsLibrary.h>
                
            } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
                if (!hasVideo) {
                    hasVideo = YES;
                }
            } else {
                NSLog(@"Uknown asset type");
            }
        }
        
        NSMutableArray *indexPathes = [NSMutableArray array];
        for (unsigned long i = wself.itemsSectionPictureArray.count; i < wself.itemsSectionPictureArray.count + images.count; i++) {
            [indexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [wself.itemsSectionPictureArray removeAllObjects];
        [wself.itemsSectionPictureArray addObjectsFromArray:images];
        // 调整集合视图的高度
        
        cell.imgArray = self.itemsSectionPictureArray;
    }];
}



- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载

- (NSMutableArray *)itemsSectionPictureArray{
    
    if (!_itemsSectionPictureArray) {
        _itemsSectionPictureArray = [NSMutableArray array];
    }
    return _itemsSectionPictureArray;
}

@end
