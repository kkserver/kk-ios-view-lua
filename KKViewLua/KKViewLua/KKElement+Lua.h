//
//  KKElement+Lua.h
//  KKViewLua
//
//  Created by zhanghailong on 2016/11/26.
//  Copyright © 2016年 kkserver.cn. All rights reserved.
//

#import <KKView/KKView.h>

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
@interface KKElement (Lua)

@end
