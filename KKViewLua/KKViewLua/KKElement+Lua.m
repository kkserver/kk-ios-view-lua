//
//  KKElement+Lua.m
//  KKViewLua
//
//  Created by zhanghailong on 2016/11/26.
//  Copyright © 2016年 kkserver.cn. All rights reserved.
//

#import "KKElement+Lua.h"
#import <KKLua/KKLua.h>

static int KKElementGetFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 1 && lua_isObject(L, -top) && lua_isstring(L, -top +1) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        const char * name = lua_tostring(L, -top + 1);
       
        id vv = [KKStyle getWithElement:v :[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
        
        lua_pushValue(L, vv);
        
        return 1;
    }
    
    return 0;
}

static int KKElementSetFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 1 && lua_isObject(L, -top) && lua_isstring(L, -top +1) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        const char * name = lua_tostring(L, -top + 1);
        id vv = top > 2 ? lua_toValue(L, -top + 2) : nil;
        
        [KKStyle setWithElement:v :[NSString stringWithCString:name encoding:NSUTF8StringEncoding] :vv];
        
    }
    
    return 0;
}

static int KKElementParentFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        lua_pushValue(L, v.parent);
        
        return 1;
    }
    
    return 0;
}

static int KKElementFirstChildFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        lua_pushValue(L, v.firstChild);
        
        return 1;
    }
    
    return 0;
}

static int KKElementLastChildFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        lua_pushValue(L, v.lastChild);
        
        return 1;
    }
    
    return 0;
}

static int KKElementNextSiblingFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        lua_pushValue(L, v.nextSibling);
        
        return 1;
    }
    
    return 0;
}

static int KKElementPrevSiblingFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        lua_pushValue(L, v.prevSibling);
        
        return 1;
    }
    
    return 0;
}

static int KKElementAppendFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 1 && lua_isObject(L, -top)  && lua_isObject(L, -top + 1) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        KKElement * e = lua_toObject(L, lua_isObject(L, -top + 1));
        
        [v append:e];
        
    }
    
    return 0;
}

static int KKElementAppendToFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 1 && lua_isObject(L, -top)  && lua_isObject(L, -top + 1) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        KKElement * e = lua_toObject(L, lua_isObject(L, -top + 1));
        
        [v appendTo:e];
        
    }
    
    return 0;
}

static int KKElementBeforeFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 1 && lua_isObject(L, -top)  && lua_isObject(L, -top + 1) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        KKElement * e = lua_toObject(L, lua_isObject(L, -top + 1));
        
        [v before:e];
        
    }
    
    return 0;
}

static int KKElementBeforeToFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 1 && lua_isObject(L, -top)  && lua_isObject(L, -top + 1) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        KKElement * e = lua_toObject(L, lua_isObject(L, -top + 1));
        
        [v beforeTo:e];
        
    }
    
    return 0;
}

static int KKElementAfterFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 1 && lua_isObject(L, -top)  && lua_isObject(L, -top + 1) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        KKElement * e = lua_toObject(L, lua_isObject(L, -top + 1));
        
        [v after:e];
        
    }
    
    return 0;
}

static int KKElementAfterToFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 1 && lua_isObject(L, -top)  && lua_isObject(L, -top + 1) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        KKElement * e = lua_toObject(L, lua_isObject(L, -top + 1));
        
        [v afterTo:e];
        
    }
    
    return 0;
}

static int KKElementRemoveFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        [v remove];
        
    }
    
    return 0;
}

static int KKElementCloneFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top) ) {
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        lua_pushValue(L, [v copyWithZone:nil]);
        
        return 1;
    }
    
    return 0;
}

static int KKElementLayoutFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 2 && lua_isObject(L, -top) && lua_isnumber(L, -top +1) && lua_isnumber(L, -top + 2)) {
        
        CGSize size = CGSizeMake(lua_tonumber(L, -top + 1), lua_tonumber(L, -top + 2));
        
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        [v layout:size];
        
    }
    
    return 0;
}

static int KKElementLayoutChildrenFunction(lua_State * L) {
    
    int top = lua_gettop(L);
    
    if(top > 0 && lua_isObject(L, -top) ) {
    
        KKElement * v = lua_toObject(L, lua_isObject(L, -top));
        
        [v layoutChildren];
        
    }
    
    return 0;
}

/**
 * element:get("name")
 * element:set("name",any)
 * element.parent
 * element.firstChild
 * element.lastChild
 * element.prevSibling
 * element.nextSibling
 * element:append(element)
 * element:appendTo(element)
 * element:before(element)
 * element:beforeTo(element)
 * element:after(element)
 * element:afterTo(element)
 * element:remove()
 * element:clone()
 * element:layout(width,height)
 * element:layoutChildren()
 */

@implementation KKElement (Lua)

-(int) KKLuaObjectGet:(NSString *) key L:(lua_State *)L {
   
    if([key isEqualToString:@"get"]) {
        
        lua_pushcclosure(L, KKElementGetFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"set"]) {
        
        lua_pushcclosure(L, KKElementSetFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"parent"]) {
        
        lua_pushcclosure(L, KKElementParentFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"firstChild"]) {
        
        lua_pushcclosure(L, KKElementFirstChildFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"lastChild"]) {
        
        lua_pushcclosure(L, KKElementLastChildFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"prevSibling"]) {
        
        lua_pushcclosure(L, KKElementPrevSiblingFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"nextSibling"]) {
        
        lua_pushcclosure(L, KKElementNextSiblingFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"append"]) {
        
        lua_pushcclosure(L, KKElementAppendFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"appendTo"]) {
        
        lua_pushcclosure(L, KKElementAppendToFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"before"]) {
        
        lua_pushcclosure(L, KKElementBeforeFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"beforeTo"]) {
        
        lua_pushcclosure(L, KKElementBeforeToFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"after"]) {
        
        lua_pushcclosure(L, KKElementAfterFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"afterTo"]) {
        
        lua_pushcclosure(L, KKElementAfterToFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"remove"]) {
        
        lua_pushcclosure(L, KKElementRemoveFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"clone"]) {
        
        lua_pushcclosure(L, KKElementCloneFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"layout"]) {
        
        lua_pushcclosure(L, KKElementLayoutFunction, 0);
        
        return 1;
    }
    else if([key isEqualToString:@"layoutChildren"]) {
        
        lua_pushcclosure(L, KKElementLayoutChildrenFunction, 0);
        
        return 1;
    }
    else {
        return [super KKLuaObjectGet:key L:L];
    }
}


@end
