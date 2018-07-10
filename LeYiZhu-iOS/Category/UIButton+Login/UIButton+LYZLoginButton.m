//
//  UIButton+LYZLoginButton.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/22.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "UIButton+LYZLoginButton.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "LoginManager.h"

static const void *kNeedLogin = "needLogin";
static const void *kSelector = @"Selector";
static const void *kObjClass = @"objClass";

@implementation UIButton (LYZLoginButton)

-(void)setNeedLogin:(BOOL)needLogin{
    objc_setAssociatedObject(self, kNeedLogin, [NSNumber numberWithBool:needLogin],OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)needLogin{
    return [objc_getAssociatedObject(self, kNeedLogin) boolValue];
}

-(void)setSelector:(NSString *)selector{
    objc_setAssociatedObject(self, kSelector, selector,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)selector {
    return objc_getAssociatedObject(self, kSelector);
}

-(void)setObjClass:(id)objClass{
    objc_setAssociatedObject(self, kObjClass, objClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)objClass{
    return objc_getAssociatedObject(self, kObjClass);
}


- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.needLogin)
    {
        self.selector = NSStringFromSelector(action);
        self.objClass = target;
        [self checkIsLogin];
    }else{
        [super sendAction:action to:target forEvent:event];
    }
}
- (void)checkIsLogin
{
    __weak typeof(self) weakSelf = self;
    [[LoginManager instance] checkLoginSuccess:^{
        SEL sel = NSSelectorFromString(weakSelf.selector);
        if ([weakSelf.objClass respondsToSelector:sel])
        {
            if ([weakSelf.selector hasSuffix:@":"])
            {
//                objc_msgSend(weakSelf.objClass, sel, self);
               ((void(*)(id, SEL,int))objc_msgSend)(weakSelf.objClass, sel, 0);
            }
            else
            {
//                objc_msgSend(weakSelf.objClass, sel);
                int (*action)(id, SEL, int) = (int (*)(id, SEL, int)) objc_msgSend;
                action(weakSelf.objClass, sel, 0);
            }
        }
    }];
}

@end
