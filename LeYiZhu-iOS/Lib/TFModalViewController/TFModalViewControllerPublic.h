//
//  TFModalViewControllerPublic.h
//  20141109-01TFModalViewController框架
//
//  Created by btz-mac on 14-11-9.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#ifndef _0141109_01TFModalViewController___TFModalViewControllerPublic_h
#define _0141109_01TFModalViewController___TFModalViewControllerPublic_h



/*==========================以下为 可自定义参数 ==========================*/

/** 界面显示出来后的背景蒙板颜色 */
#define TF_ModalView_Background_Color [UIColor darkGrayColor]

/** 界面显示出来后的背景蒙板透明度 */
#define TF_ModalView_Background_Alpha 0.6

/** 界面显示跟隐藏的动画时间 */
#define TF_Animation_Show_Duration 0.5

/** 拖拽界面时,是否自动隐藏界面的拖拽距离比例 (这个比例系数是指拖拽的位移偏移量跟被拖拽的界面的宽度或高度的比例) 默认0.3 */
#define TF_ModalView_ShowHiddenAnimation_Scale 0.3

/*==========================以上为 可自定义参数 ==========================*/



/** 界面隐藏完全后的回调block */
typedef void(^TFModalViewControllerHiddenCompletionBlock)(void);

/** 界面显示完成后的回调block */
typedef void(^TFModalViewControllerShowCompletionBlock)(void);


/** 界面进入视野的方向 */
typedef enum {
    
    TFModalViewControllerShowDirectionFromRight = 0 ,   //默认从右边进入
    TFModalViewControllerShowDirectionFromLeft,     
    TFModalViewControllerShowDirectionFromTop,
    TFModalViewControllerShowDirectionFromBottom
    
}TFModalViewControllerShowDirection;




#endif
