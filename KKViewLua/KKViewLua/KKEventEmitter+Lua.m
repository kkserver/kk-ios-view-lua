//
//  KKEventEmitter+Lua.m
//  KKViewLua
//
//  Created by zhanghailong on 2016/11/26.
//  Copyright © 2016年 kkserver.cn. All rights reserved.
//

#import "KKEventEmitter+Lua.h"
#import <KKLua/KKLua.h>

static int KKEventEmitterOnFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 2 && lua_isObject(L, -top) && lua_isstring(L, -top +1) && lua_isfunction(L, -top +2) ) {
        
        KKEventEmitter * v = lua_toObject(L, lua_isObject(L, -top));
        
        const char * name = lua_tostring(L, -top + 1);
        id weakObject = top > 3 ? lua_toValue(L, -top +3) : nil;
        
        lua_pushvalue(L, -top +2);
        
        KKLuaRef * ref = [[KKLuaRef alloc] initWithL:L];
        
        [v on:[NSString stringWithCString:name encoding:NSUTF8StringEncoding] :^(NSString * name, KKEvent * event, id weakobject) {
            
            lua_pushstring(ref.L, [name UTF8String]);
            lua_pushObject(ref.L, event);
            lua_pushValue(ref.L, weakObject);
            
            [ref get];
            
            if(0 != lua_pcall(ref.L, 3, 0, 0)) {
                NSLog(@"[KK][KKViewLua][KKEventEmitterOnFunction] %s",lua_tostring(ref.L, -1));
                lua_pop(ref.L, 1);
            }

            
        } :weakObject];
        
    }
    
    return 0;
}

static int KKEventEmitterOffFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top)) {
        
        KKEventEmitter * v = lua_toObject(L, lua_isObject(L, -top));
        
        const char * name = top > 1 ? lua_tostring(L, -top + 1) : nil;
        id weakObject = top > 2 ? lua_toValue(L, -top +2) : nil;
        
        [v off:name ? [NSString stringWithCString:name encoding:NSUTF8StringEncoding]: nil :weakObject];
        
    }
    
    return 0;
}


@implementation KKEventEmitter (Lua)

-(int) KKLuaObjectGet:(NSString *) key L:(lua_State *)L {
    if([key isEqualToString:@"on"]) {
        
        lua_pushcclosure(L, KKEventEmitterOnFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"off"]) {
        
        lua_pushcclosure(L, KKEventEmitterOffFunction, 0);
        
        return 1;
    }
    else {
        return [super KKLuaObjectGet:key L:L];
    }
}


@end
