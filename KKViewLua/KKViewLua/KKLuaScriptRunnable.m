//
//  KKLuaScriptRunnable.m
//  KKViewLua
//
//  Created by 张海龙 on 2017/3/9.
//  Copyright © 2017年 kkserver.cn. All rights reserved.
//

#import "KKLuaScriptRunnable.h"

@interface KKLuaScriptElementFunction : NSObject<KKScriptElementFunction> {
    int _ref;
    NSString * _errmsg;
}

@property(nonatomic,strong,readonly) KKLuaState * luaState;

-(instancetype) initWithState:(KKLuaState * ) luaState code:(NSString *) code;


@end

@implementation KKLuaScriptElementFunction

- (id)invokeWithObject:(id)object {
    
    if(_ref != LUA_REFNIL && _luaState != nil) {
        
        struct lua_State * L = _luaState.L;
        
        lua_rawgeti(L, LUA_REGISTRYINDEX, _ref);
        
        if(lua_isfunction(L, -1)) {
            
            lua_pushValue(L, object);
            
            if(lua_pcall(L, 1, 1, 0) !=0) {
                
                NSString * v = [NSString stringWithCString:lua_tostring(L, -1) encoding:NSUTF8StringEncoding];
                
                lua_pop(L, 1);
                
                NSLog(@"[KK] [KKView] [Lua] %@",v);
                
                return @"";
                
            } else if(lua_isfunction(L, -1)) {
                
                if(lua_pcall(L, 0, 1, 0) !=0) {
                    
                    NSString * v = [NSString stringWithCString:lua_tostring(L, -1) encoding:NSUTF8StringEncoding];
                    
                    lua_pop(L, 1);
                    
                    NSLog(@"[KK] [KKView] [Lua] %@",v);
                    
                    return @"";
                    
                } else {
                    id v = lua_toValue(L, -1);
                    lua_pop(L, 1);
                    return v;
                }
                
            } else {
                id v = lua_toValue(L, -1);
                lua_pop(L, 1);
                return v;
            }
            
        } else {
            lua_pop(_luaState.L, 1);
        }
        
    }

    return _errmsg;
}

-(instancetype) initWithState:(KKLuaState * ) luaState code:(NSString *) code {
    if((self = [super init])) {
        _luaState = luaState;
        _ref = LUA_REFNIL;
        
        struct lua_State * L = _luaState.L;

        if(luaL_loadstring(L, [[NSString stringWithFormat:@"return function(object) return %@ end",code] UTF8String]) != 0) {
            _errmsg = [NSString stringWithCString:lua_tostring(L, -1) encoding:NSUTF8StringEncoding] ;
            lua_pop(L, 1);
            NSLog(@"[KK] [KKView] [Lua] %@",_errmsg);
        } else if(lua_pcall(L, 0, 1, 0) != 0) {
            _errmsg = [NSString stringWithCString:lua_tostring(L, -1) encoding:NSUTF8StringEncoding] ;
            lua_pop(L, 1);
            NSLog(@"[KK] [KKView] [Lua] %@",_errmsg);
        } else {
            _ref = luaL_ref(L, LUA_REGISTRYINDEX);
        }
        
    }
    return self;
}

-(void) dealloc {
    if(_ref != LUA_REFNIL && _luaState != nil) {
        luaL_unref(_luaState.L, LUA_REGISTRYINDEX, _ref);
        _ref = LUA_REFNIL;
    }
}


@end

@implementation KKLuaScriptRunnable

@synthesize luaState = _luaState;

-(instancetype) initWithState:(KKLuaState * ) luaState {
    if((self = [super init])) {
        _luaState = luaState;
    }
    return self;
}

- (id <KKScriptElementFunction>)compileWithCode:(NSString *)code {
    return [[KKLuaScriptElementFunction alloc] initWithState:_luaState code:code];
}

@end
