//
//  KKLuaScriptRunnable.h
//  KKViewLua
//
//  Created by 张海龙 on 2017/3/9.
//  Copyright © 2017年 kkserver.cn. All rights reserved.
//

#import <KKView/KKView.h>
#import <KKLua/KKLua.h>


@interface KKLuaScriptRunnable : NSObject<KKScriptElementRunnable>

@property(nonatomic,strong,readonly) KKLuaState * luaState;

-(instancetype) initWithState:(KKLuaState * ) luaState;

@end
