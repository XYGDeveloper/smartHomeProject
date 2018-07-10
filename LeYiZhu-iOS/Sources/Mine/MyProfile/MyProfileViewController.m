//
//  MyProfileViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "MyProfileViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "LoginManager.h"
#import "MyProfileCommonCell.h"
#import "AvatarCell.h"
#import "ChangePhoneStep2ViewController.h"
#import "LYZImaageUploaderManager.h"
#import "Public+JGHUD.h"
#import "UpdateUserNameController.h"

@interface MyProfileViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;

@property (nonatomic, strong) UIActionSheet *actionSheet;



@end

@implementation MyProfileViewController

#pragma mark - life cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [self createTableViewAndRegisterCells];
    [self createDataSource];
}

#pragma mark - UI Config

- (void)createTableViewAndRegisterCells {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 64)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [ColorSpaceCell registerToTableView:self.tableView];
    [AvatarCell registerToTableView:self.tableView];
    [MyProfileCommonCell registerToTableView:self.tableView];
}

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : LYZTheme_BackGroundColor} cellHeight:height];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
        
    } else {
        
        return nil;
    }
}

#pragma mark - Data Config

-(void)createDataSource{
    if (!_adapters) {
        _adapters= [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    [self.adapters addObject:[self lineType:kSpace height:20]];
    [self.adapters addObject:[AvatarCell dataAdapterWithData:self.facePath cellHeight:AvatarCell.cellHeight]];
    [self.adapters addObject:[self lineType:kShortType height:0.5]];
    [self.adapters addObject:[MyProfileCommonCell dataAdapterWithData:@{@"title":@"修改手机号码",@"subtitle":self.phone} cellHeight:MyProfileCommonCell.cellHeight]];
     [self.adapters addObject:[self lineType:kShortType height:0.5]];
     [self.adapters addObject:[MyProfileCommonCell dataAdapterWithData:@{@"title":@"昵称",@"subtitle":self.nickName} cellHeight:MyProfileCommonCell.cellHeight]];
    
    [self.tableView reloadData];
    
}

#pragma mark - TableView Delegate & DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellDataAdapter *adapter = _adapters[indexPath.row];
    CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.indexPath           = indexPath;
    cell.tableView           = tableView;
    cell.delegate            = self;
    cell.controller          = self;
    [cell loadContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        //修改头像
        [self callActionSheetFunc];
        
    }else if (indexPath.row == 3) {
        ChangePhoneStep2ViewController * vc = [[ChangePhoneStep2ViewController alloc]  init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        //昵称
        UpdateUserNameController *vc = [[UpdateUserNameController alloc] init];
        WEAKSELF;
        vc.updateNamePop = ^(NSString *nickName) {
            weakSelf.nickName = nickName;
            [weakSelf createDataSource];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
  
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
}

/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil ,nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil ,nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    LYLog(@"%@",image);
    //TODO:
    [LYZImaageUploaderManager uploadImgs:@[image] withResult:^(id imgs) {
        LYLog(@"imgs is ----> %@",imgs);
        NSString *imgURL  = [(NSArray *)imgs firstObject];
        if (imgs) {
            [[LYZNetWorkEngine sharedInstance] updateUserInfo:nil facepath:imgs[0] block:^(int event, id object) {
                if (event == 1) {
                    //上传成功
                    self.facePath = imgURL;
                    [self createDataSource];
                }else{
                    [Public showJGHUDWhenError:self.view msg:@"上传失败"];
                }
            }];
        }else{
            [Public showJGHUDWhenError:self.view msg:@"上传失败"];

        }
    }];

}

@end
