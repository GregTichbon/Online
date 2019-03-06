/*
 * ByRei dynDiv 0.8 - dynamic Div Script
 *
 * Copyright (c) 2008 Markus Bordihn (markusbordihn.de)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * $Date: 2008-07-07 18:00:00 +0100 (Mon, 07 July 2008) $
 * $Rev: 0.8 $
 */

/*global ByRei_dynDiv*/

ByRei_dynDiv = {
 
 info: {
  Name: "ByRei dynDiv",
  Version:  "0.8",
  Author: "Markus Bordihn (http://markusbordihn.de)",
  Description: "Simple dynamic DIV's"
 },
 
 api: {
  drag: null,
  drop: null,
  elem: null,
  alter: null,
  obj: null
 },
 
 dropArea: [],
 
 cache: {
  obj: null,
  elem: null,
  l_obj: null,
  l_elem: null,
  modus: null,
  zIndex: null,
  width: null,
  height: null,
  posx: null,
  posy: null,
  init: {
   width: null,
   height: null,
   pos_x: null,
   pos_y: null,
   offset_x: null,
   offset_y: null 
  }
 },
 
 limit: {
  min_left: null,
  max_left: null,
  min_top: null,
  max_top: null,
  min_width: null,
  max_width: null,
  min_height: null,
  max_height: null
 },

 divList: [], 
 
/*
  divList Struction
  ==================
  
  0.  Object:[Object]      - Movable Object
  1.  Limiter:[Object]     - Object to which the dynDIV is limited 
  2.  Status:[Boolean]     - Active or Inactive
  3.  zIndex:[Number]      - Init. zIndex for the dynDIV
  4.  left:[Number]        - Init. Position left
  5.  top:[Number]         - Init. Position top
  6.  dropLimit:[Text]     - Contain the dropArea which the dynDIV is limited
  7.  dropMode:[Text]      - Set up the dropMode for the dropArea (default,center,fit)
  8.  dropLog:[Boolean]    - Is true when the dynDIV was dropped into the dropArea
  9.  hideAction:[Text]    - Hide other DIVs for move or resize
  10. showResize:[Text]    - Show resize DIVs only on active or double click
  
*/
  
 getPos: function(obj) {
  if (obj) {
   ByRei_dynDiv.cache.init.width = obj.clientWidth;
   ByRei_dynDiv.cache.init.height = obj.clientHeight;
   ByRei_dynDiv.cache.init.pos_y = ByRei_dynDiv.cache.posy;
   ByRei_dynDiv.cache.init.pos_x = ByRei_dynDiv.cache.posx;
   ByRei_dynDiv.cache.init.offset_x = ByRei_dynDiv.get_offset(obj)[0];
   ByRei_dynDiv.cache.init.offset_y = ByRei_dynDiv.get_offset(obj)[1];
   ByRei_dynDiv.db(2,true);
   ByRei_dynDiv.db(4,obj.offsetLeft);
   ByRei_dynDiv.db(5,obj.offsetTop);
  }
 },

 get_mousePos: function(evt) {
 if (evt) {
   if (!evt) {evt = window.event;}
   if (evt.pageX || evt.pageY) {
       ByRei_dynDiv.cache.posx = evt.pageX;
      ByRei_dynDiv.cache.posy = evt.pageY;
   } else if (evt.clientX || evt.clientY) {
             ByRei_dynDiv.cache.posx = evt.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
             ByRei_dynDiv.cache.posy = evt.clientY + document.body.scrollTop + document.documentElement.scrollTop;
    }
  }
 },

 do_mouseMove: function(e) {
  ByRei_dynDiv.get_mousePos(e); // Get Mouse Position
 
  if(ByRei_dynDiv.cache.obj) {
    if (ByRei_dynDiv.search('zIndex') > 0) {
    if (ByRei_dynDiv.cache.obj.style) {
        ByRei_dynDiv.cache.obj.style.zIndex = ByRei_dynDiv.search('zIndex') + 1;
    }
   }
   if (ByRei_dynDiv.cache.modus) {
    if (ByRei_dynDiv.api.alter) {ByRei_dynDiv.api.alter();} // API move Event
    switch (ByRei_dynDiv.cache.modus) {
     case "br": case "tr": case "tl": case "bl":  return ByRei_dynDiv.resize();
     case "move":  case "moveparent" : return ByRei_dynDiv.move();
     default: break;
    }
   }
    // return false; Lost Focus when this is true ???? - Confused
  }
 },

 do_Action: function() {
  if (!ByRei_dynDiv.cache.obj) {
   ByRei_dynDiv.set_eventListener(document, 'mousemove' , ByRei_dynDiv.do_mouseMove);
   ByRei_dynDiv.set_eventListener(document, 'mouseup', ByRei_dynDiv.do_noAction);
  }
 },
 
 check_Hit: function(elem1, elem2, modus) {
  var hit=false;
  if (elem1 && elem2) {
   var 
    obj1 = {
     left: ByRei_dynDiv.get_offset(elem1)[0],
    top:  ByRei_dynDiv.get_offset(elem1)[1],
    width:  elem1.clientWidth,
    height: elem1.clientHeight
   },
   obj2 = {
    left: ByRei_dynDiv.get_offset(elem2)[0],
    top:  ByRei_dynDiv.get_offset(elem2)[1],
    width:  elem2.clientWidth,
    height: elem2.clientHeight
   };
   
   // Check Hit
   switch (modus) {
    case "fit": case "center":
      if (
        ((obj1.left > obj2.left && obj1.left < obj2.left + obj2.width) && ((obj1.top > obj2.top && obj1.top < obj2.top + obj2.height) || (obj1.top + obj1.height > obj2.top && obj1.top + obj1.height < obj2.top + obj2.height))) ||
       ((obj1.left + obj1.width > obj2.left && obj1.left + obj1.width < obj2.left + obj2.width) && ((obj1.top > obj2.top && obj1.top < obj2.top + obj2.height) || (obj1.top + obj1.height > obj2.top && obj1.top + obj1.height < obj2.top + obj2.height)))
       ) {hit=true;}
    break;
    default:
     if (
        (obj1.left > obj2.left && obj1.left < obj2.left + obj2.width && obj1.left + obj1.width < obj2.left + obj2.width) &&
       (obj1.top > obj2.top && obj1.top < obj2.top + obj2.height && obj1.top + obj1.height < obj2.top + obj2.height)
        ) {hit=true;} 
    break;
   }
  }
  return hit;
 },
 
 do_noAction: function() {
  if (ByRei_dynDiv.db(0)) {
      
     // Drop Area Support
   if (ByRei_dynDiv.db(6)) {
       var 
       dropCheck = false,
      dropArea = false;

      for (var i=0;i<ByRei_dynDiv.dropArea.length;i++) {
          if (ByRei_dynDiv.dropArea[i][1] === ByRei_dynDiv.db(6)) {
                   if (ByRei_dynDiv.check_Hit(ByRei_dynDiv.cache.obj, ByRei_dynDiv.dropArea[i][0], ByRei_dynDiv.db(7))) {
                 dropCheck = true;
                dropArea = ByRei_dynDiv.dropArea[i][0];
             }
           }
      }
      
      if (!dropCheck && ByRei_dynDiv.cache.obj.style) {
         ByRei_dynDiv.cache.obj.style.left = ByRei_dynDiv.db(4) + 'px';
          ByRei_dynDiv.cache.obj.style.top  = ByRei_dynDiv.db(5) + 'px';
      } else {
         switch (ByRei_dynDiv.db(7)) {
         case "fit" :
           ByRei_dynDiv.cache.obj.style.left = ByRei_dynDiv.db(4) + (ByRei_dynDiv.get_offset(dropArea)[0] - ByRei_dynDiv.cache.init.offset_x) + 'px';
             ByRei_dynDiv.cache.obj.style.top  = ByRei_dynDiv.db(5) + (ByRei_dynDiv.get_offset(dropArea)[1] - ByRei_dynDiv.cache.init.offset_y) + 'px';
         break;
         case "center" :
           ByRei_dynDiv.cache.obj.style.left = ByRei_dynDiv.db(4) + (ByRei_dynDiv.get_offset(dropArea)[0] - ByRei_dynDiv.cache.init.offset_x) + ((dropArea.clientWidth/2) - (ByRei_dynDiv.cache.obj.clientWidth/2)) + 'px';
             ByRei_dynDiv.cache.obj.style.top  = ByRei_dynDiv.db(5) + (ByRei_dynDiv.get_offset(dropArea)[1] - ByRei_dynDiv.cache.init.offset_y) + ((dropArea.clientHeight/2) - (ByRei_dynDiv.cache.obj.clientHeight/2)) + 'px';
         break;
         }
         ByRei_dynDiv.db(8, true);
      }
   }
  }
  // Normal Event Handling
  ByRei_dynDiv.db(2,false); // Active to Inactive
  ByRei_dynDiv.del_eventListener(document, 'mousemove' , ByRei_dynDiv.do_mouseMove); // Remove Event Listener
  ByRei_dynDiv.del_eventListener(document, 'mouseup', ByRei_dynDiv.do_noAction);     // Remove Event Listener
  if (ByRei_dynDiv.cache.obj) {
      if (ByRei_dynDiv.cache.obj.style && ByRei_dynDiv.cache.zIndex) {
          ByRei_dynDiv.cache.obj.style.zIndex = ByRei_dynDiv.cache.zIndex; // Reset zIndex to initial value
      }
  }
  if (ByRei_dynDiv.cache.l_obj !== ByRei_dynDiv.cache.obj) {ByRei_dynDiv.cache.l_obj = ByRei_dynDiv.cache.obj;}
  if (ByRei_dynDiv.cache.l_elem !== ByRei_dynDiv.cache.elem) {ByRei_dynDiv.cache.l_elem = ByRei_dynDiv.cache.elem;}
  if (ByRei_dynDiv.db(9)) {ByRei_dynDiv.visible(true);} // Show hiden dynDIVs
  if (ByRei_dynDiv.api.drop) {ByRei_dynDiv.api.drop();} // API drop Event
  
  // Reset to default Values
  ByRei_dynDiv.limit.min_left = ByRei_dynDiv.limit.min_top = ByRei_dynDiv.limit.min_width = ByRei_dynDiv.limit.min_height = 
  ByRei_dynDiv.limit.min_left = ByRei_dynDiv.limit.min_top = ByRei_dynDiv.limit.min_width = ByRei_dynDiv.limit.min_height = 
  ByRei_dynDiv.cache.obj = ByRei_dynDiv.cache.modus = ByRei_dynDiv.cache.zIndex = ByRei_dynDiv.cache.elem = false;
 },

 set_limit: function() {
  if (ByRei_dynDiv.db(1) && ByRei_dynDiv.cache.obj) {
    var
   obj = {
     x1 : ByRei_dynDiv.get_offset(ByRei_dynDiv.cache.obj)[0],
    y1 : ByRei_dynDiv.get_offset(ByRei_dynDiv.cache.obj)[1],
    x2 : ByRei_dynDiv.cache.obj.offsetWidth + ByRei_dynDiv.get_offset(ByRei_dynDiv.cache.obj)[0],
    y2 : ByRei_dynDiv.cache.obj.offsetHeight + ByRei_dynDiv.get_offset(ByRei_dynDiv.cache.obj)[1]
   },
   limit = {
     x1 : ByRei_dynDiv.get_offset(ByRei_dynDiv.db(1))[0],
    y1 : ByRei_dynDiv.get_offset(ByRei_dynDiv.db(1))[1],
    x2 : ByRei_dynDiv.db(1).clientWidth + ByRei_dynDiv.get_offset(ByRei_dynDiv.db(1))[0],
    y2 : ByRei_dynDiv.db(1).clientHeight + ByRei_dynDiv.get_offset(ByRei_dynDiv.db(1))[1]
   };
   
   ByRei_dynDiv.limit.min_left = limit.x1 - obj.x1;
   ByRei_dynDiv.limit.max_left = limit.x2 - obj.x2;
   ByRei_dynDiv.limit.min_top = limit.y1 - obj.y1;
   ByRei_dynDiv.limit.max_top = limit.y2 - obj.y2;
  }
 },
 
 move: function() {
  if (ByRei_dynDiv.cache.obj) {
   if (ByRei_dynDiv.cache.obj.style) {
      
     var
     new_left = ByRei_dynDiv.cache.posx - (ByRei_dynDiv.cache.init.pos_x - ByRei_dynDiv.db(4)),
     new_top  = ByRei_dynDiv.cache.posy - (ByRei_dynDiv.cache.init.pos_y - ByRei_dynDiv.db(5));

     // Check for Div Limit
     if (ByRei_dynDiv.db(1)) {
      var
       pos_x  = ByRei_dynDiv.cache.posx - ByRei_dynDiv.cache.init.pos_x,
       pos_y  = ByRei_dynDiv.cache.posy - ByRei_dynDiv.cache.init.pos_y;
     
      if (pos_x < ByRei_dynDiv.limit.min_left) {new_left = ByRei_dynDiv.db(4) + ByRei_dynDiv.limit.min_left;}
      else if (pos_x > ByRei_dynDiv.limit.max_left) {new_left = ByRei_dynDiv.db(4) + ByRei_dynDiv.limit.max_left;}

      if (pos_y < ByRei_dynDiv.limit.min_top)  {new_top  = ByRei_dynDiv.db(5) + ByRei_dynDiv.limit.min_top;}
      else if (pos_y > ByRei_dynDiv.limit.max_top)  {new_top  = ByRei_dynDiv.db(5) + ByRei_dynDiv.limit.max_top;}
     }
     
     if (!isNaN(new_left)) {ByRei_dynDiv.cache.obj.style.left =  new_left + "px";}
     if (!isNaN(new_top))  {ByRei_dynDiv.cache.obj.style.top =  new_top + "px";}
   }
  }
  return false;
 },

 resize: function() {
  if (ByRei_dynDiv.cache.obj && ByRei_dynDiv.cache.modus) {
   if (ByRei_dynDiv.cache.obj.style) {
    var
    default_padding = 20,
    new_size_x = 0,
    new_size_y = 0,
    new_top = ByRei_dynDiv.db(5),
    new_left = ByRei_dynDiv.db(4),
    rs_modus = ByRei_dynDiv.cache.modus,
    mouse_diff_x = (ByRei_dynDiv.cache.posx - ByRei_dynDiv.cache.init.pos_x || 0),
    mouse_diff_y = (ByRei_dynDiv.cache.posy - ByRei_dynDiv.cache.init.pos_y || 0);
    
   // Scaling DIV depend on the Modus   
   switch(rs_modus) {
    case "br": case "tr": new_size_x = ByRei_dynDiv.cache.init.width + mouse_diff_x; break;
    case "tl": case "bl": new_size_x = ByRei_dynDiv.cache.init.width - mouse_diff_x; break;
   }
   
   switch(rs_modus) {
     case "br": case "bl": new_size_y = ByRei_dynDiv.cache.init.height + mouse_diff_y; break;
    case "tr": case "tl": new_size_y = ByRei_dynDiv.cache.init.height - mouse_diff_y; break;
   }
      
    switch(rs_modus) {
    case "tl": new_top  = ByRei_dynDiv.db(5) + mouse_diff_y; new_left = ByRei_dynDiv.db(4) + mouse_diff_x; break;
    case "tr": new_top  = ByRei_dynDiv.db(5) + mouse_diff_y; break;
    case "bl": new_left = ByRei_dynDiv.db(4) + mouse_diff_x; break;
   }
   
   // Check if Limit is reached   
   if (ByRei_dynDiv.db(1)) {
     var 
      pos_x = ByRei_dynDiv.cache.posx - ByRei_dynDiv.cache.init.pos_x,
      pos_y = ByRei_dynDiv.cache.posy - ByRei_dynDiv.cache.init.pos_y;
   
      switch(rs_modus) {
       case "tl": case "bl":
        if (pos_x < ByRei_dynDiv.limit.min_left) {
           new_size_x = ByRei_dynDiv.cache.init.width - ByRei_dynDiv.limit.min_left;
           new_left = ByRei_dynDiv.db(4) + ByRei_dynDiv.limit.min_left;
       }
      break;
      case "tr": case "br":
       if (pos_x > ByRei_dynDiv.limit.max_left) {
           new_size_x = ByRei_dynDiv.cache.init.width + ByRei_dynDiv.limit.max_left;
       }
      break;
     }
          
     switch(rs_modus) {
       case "tl": case "tr":
       if (pos_y < ByRei_dynDiv.limit.min_top)  {
           new_size_y = ByRei_dynDiv.cache.init.height - ByRei_dynDiv.limit.min_top;
           new_top  = ByRei_dynDiv.db(5) + ByRei_dynDiv.limit.min_top;

       }
      break;
      case "bl": case "br":
       if (pos_y > ByRei_dynDiv.limit.max_top)  {
           new_size_y = ByRei_dynDiv.cache.init.height + ByRei_dynDiv.limit.max_top;
       }
      break;
     }

   }
   
   // Check for min. Size (20x20)
    if (new_size_x > default_padding) {
       ByRei_dynDiv.cache.obj.style.width = new_size_x + "px";
       ByRei_dynDiv.cache.obj.style.left = new_left + "px";
   }
   if (new_size_y > default_padding) {
       ByRei_dynDiv.cache.obj.style.height = new_size_y + "px";
       ByRei_dynDiv.cache.obj.style.top = new_top + "px";
    }
   }
  }
  return false;
 },

 init_Action: function(evt, m_modus) {
  if (evt) {
   if (window.attachEvent) {evt.cancelBubble=true;}
   if (evt.stopPropagation) {evt.stopPropagation();}
   var evt_src = evt.target ? evt.target : evt.srcElement;
      
   // Avoid Issues with minmax
   if (evt_src.className.indexOf('dynDiv_minmaxDiv') === -1) {
    var i;
   ByRei_dynDiv.get_mousePos(evt);
    ByRei_dynDiv.do_Action();
    switch (m_modus) {
     case "move":
      for (i=0;i<5;i++) {
        if (evt_src.className.indexOf('dynDiv_moveDiv') < 0) {
           evt_src = evt_src.parentNode;
         } else {
           break;
        }
       }
      ByRei_dynDiv.cache.obj = ByRei_dynDiv.api.obj = evt_src;
     break;
     case "moveparent":
      for (i=0;i<5;i++) {
       if (evt_src.className.indexOf('dynDiv_moveParentDiv') < 0) {
          evt_src = evt_src.parentNode;
        } else {
          break;
        }
       }
      ByRei_dynDiv.cache.obj = ByRei_dynDiv.api.obj = evt_src.parentNode;
     break;
     case "tl" : case "tr" : case "bl" : case "br" :
      ByRei_dynDiv.cache.obj = ByRei_dynDiv.api.obj = evt_src.parentNode;
     break;
     default:
      ByRei_dynDiv.cache.obj = ByRei_dynDiv.api.obj = evt_src;
     break;
   }
   
   ByRei_dynDiv.cache.elem = ByRei_dynDiv.api.elem = ByRei_dynDiv.search(ByRei_dynDiv.cache.obj);
   ByRei_dynDiv.cache.zIndex = ByRei_dynDiv.cache.obj.style.zIndex;
    ByRei_dynDiv.getPos(ByRei_dynDiv.cache.obj);
    ByRei_dynDiv.cache.modus = m_modus;
   ByRei_dynDiv.set_limit();     // Set Limits for Move an Resize
   if (ByRei_dynDiv.api.drag) {ByRei_dynDiv.api.drag();}
    switch(m_modus){
     case "move" : case "moveparent" :
        if (ByRei_dynDiv.db(9) === 'move' || ByRei_dynDiv.db(9) === 'move_resize') {ByRei_dynDiv.visible(false);} 
     break;
     case "tl" : case "tr" : case "bl" : case "br" : 
       if (ByRei_dynDiv.db(9) === 'resize' || ByRei_dynDiv.db(9) === 'move_resize') {ByRei_dynDiv.visible(false);}
     break;
   }
   if (ByRei_dynDiv.cache.elem !== ByRei_dynDiv.cache.l_elem && (ByRei_dynDiv.cache.l_elem || ByRei_dynDiv.cache.l_elem === 0)) {
      if (ByRei_dynDiv.divList[ByRei_dynDiv.cache.l_elem][10]) {
          ByRei_dynDiv.showResize(ByRei_dynDiv.cache.l_obj,false);
      }
   }
   if (ByRei_dynDiv.db(10) === 'active') {
       ByRei_dynDiv.showResize(ByRei_dynDiv.cache.obj,true);
   }
   }
  }
 },
 
 visible: function(value) {
  for (var i=0;i<ByRei_dynDiv.divList.length;i++) {
      if (ByRei_dynDiv.divList[i] !== ByRei_dynDiv.divList[ByRei_dynDiv.cache.elem]) {
          if (ByRei_dynDiv.divList[i][0].style) {
             ByRei_dynDiv.divList[i][0].style.visibility = (value) ? 'visible' : 'hidden';
         }
      }
  }
 },
 
 db: function(i,value) { // db(1) return value / db(1,1) set value
  var result=false;
  if (ByRei_dynDiv.cache.elem >= 0) {
      if (ByRei_dynDiv.divList[ByRei_dynDiv.cache.elem]) {
         if (typeof ByRei_dynDiv.divList[ByRei_dynDiv.cache.elem][i] !== 'undefined') {
            if (typeof(value) !== 'undefined') {
                ByRei_dynDiv.divList[ByRei_dynDiv.cache.elem][i] = value;
              result = true;
           } else {
               result = ByRei_dynDiv.divList[ByRei_dynDiv.cache.elem][i];
           }
        }
     }
  }
  return result;
 },
 
 init_minmaxDiv: function(evt) {
  if (evt) {
   var 
    evt_src = evt.target ? evt.target : evt.srcElement,
    minmaxHeight;
   for (var i=0;i<5;i++) {
    if (ByRei_dynDiv.check_array(evt_src.className.split(' '),'dynDiv_minmax_Height-',1)) {minmaxHeight = ByRei_dynDiv.check_array(evt_src.className.split(' '),'dynDiv_minmax_Height-',1);}
    if (evt_src.className.indexOf('dynDiv_minmaxDiv') >= 0 || evt_src.className.indexOf('dynDiv_moveParentDiv') >= 0) {
       evt_src = evt_src.parentNode;
      } else {
       break;
      }
    }
   if (evt_src.style) {
    evt_src.style.clip = (evt_src.style.clip.indexOf((minmaxHeight||20) + 'px auto') >= 0 || evt_src.style.clip.indexOf((minmaxHeight||20) + 'px, auto') >= 0) ?  'rect(auto auto auto auto)' : 'rect(auto auto ' +  (minmaxHeight||20) +'px auto)';
   }
  }
 },

 get_offset: function(obj) {
  var 
   left = 0,
   top = 0;
  if (obj) {
   left = obj.offsetLeft;
   top = obj.offsetTop;
   while (obj.offsetParent) {
    left += obj.offsetParent.offsetLeft;
   top += obj.offsetParent.offsetTop;
   obj = obj.offsetParent;
   }
  }
  return [left,top];
 },
 
 search: function(obj,modus) {
  var result=false;
  if (obj) {
      for (var i=0;i<ByRei_dynDiv.divList.length;i++) {
           if (obj === 'zIndex') {
             if (ByRei_dynDiv.divList[i][3] !== 'auto') {
                if (ByRei_dynDiv.divList[i][3] > result) {
                   result = ByRei_dynDiv.divList[i][3];
               }
            }
         }
         else if (ByRei_dynDiv.divList[i][0] === obj) {
                  result = i; break;
         }
     }
  }
  return result;
 },
  
 showResize: function(evt,value) {
  
  var 
   evt_src = (evt.target || evt.srcElement) ? (evt.target ? evt.target : evt.srcElement) : (evt),
   classNames = evt_src.className.split(' '),
   resize_list = (ByRei_dynDiv.check_array(classNames,'dynDiv_moveParentDiv') && evt_src.parentNode) ? evt_src.parentNode.getElementsByTagName('div')  : evt_src.getElementsByTagName('div') ;
   
   for (var i=0;i<resize_list.length;i++) {
        if (ByRei_dynDiv.check_array(resize_list[i].className.split(' '),'dynDiv_resizeDiv_',1)) {
           if (resize_list[i].style) {
             if (resize_list[i].style.visibility === (value) ? 'visible' : 'hidden') {
                 resize_list[i].style.visibility = (value) ? 'visible' : 'hidden';
             }
         }
       }
   }
 },
 
 init: function() {
  var div_list = document.getElementsByTagName('div');
  for (var i=0;i<div_list.length;i++) {
      if (ByRei_dynDiv.check_array(div_list[i].className.split(' '),'dynDiv_',1)) {
         ByRei_dynDiv.add(div_list[i],i);
     }
  }
 },
 
 add: function(elem,i) {
  if (elem) {
   var
    zIndex = 'auto',
    fix_firefox      = function() {return false;},
    func_move        = function(e) {ByRei_dynDiv.init_Action(e,'move');},
    func_move_parent = function(e) {ByRei_dynDiv.init_Action(e,'moveparent');},
    func_resize_tl   = function(e) {ByRei_dynDiv.init_Action(e,'tl');},
    func_resize_tr   = function(e) {ByRei_dynDiv.init_Action(e,'tr');},
    func_resize_bl   = function(e) {ByRei_dynDiv.init_Action(e,'bl');},
    func_resize_br   = function(e) {ByRei_dynDiv.init_Action(e,'br');},
    func_min_max     = function(e) {ByRei_dynDiv.init_minmaxDiv(e);},
   func_show_resize = function(e) {ByRei_dynDiv.showResize(e, true);},
    func_z_index     = function(obj,i) {if (obj.style.zIndex) {zIndex = obj.style.zIndex;} else {obj.style.zIndex = zIndex = i;}};
  
   var classNames = elem.className.split(' ');
   if (ByRei_dynDiv.check_array(classNames,'dynDiv_',1)) {
   // Vars
   var
    limiter = null,
    droplimiter = false,
    dropmode = false,
    hideaction = false,
    showresize = false,
    status = false,
    parent = elem,
    l_parent = parent.parentNode;
   
    // Firefox Lost Focus Bug
    parent.onmousedown = fix_firefox;
    // Set Event Handler for Moveing and Resizing
   if (ByRei_dynDiv.check_array(classNames,'dynDiv_moveDiv')) {
       func_z_index(parent,i);
      parent.style.cursor = 'move';
       ByRei_dynDiv.set_eventListener(parent,'mousedown', func_move);
   }
    else if (ByRei_dynDiv.check_array(classNames,'dynDiv_moveParentDiv')) {
            ByRei_dynDiv.set_eventListener(parent,'mousedown', func_move_parent);
          parent.style.cursor = 'move';
            parent = parent.parentNode;
             func_z_index(parent,i);
   }
    else if (ByRei_dynDiv.check_array(classNames,'dynDiv_resizeDiv_tl')) {
            parent.style.cursor = 'nw-resize';
            ByRei_dynDiv.set_eventListener(parent,'mousedown', func_resize_tl);
   }
    else if (ByRei_dynDiv.check_array(classNames,'dynDiv_resizeDiv_tr')) {
            parent.style.cursor = 'ne-resize';
            ByRei_dynDiv.set_eventListener(parent,'mousedown', func_resize_tr);
   }
    else if (ByRei_dynDiv.check_array(classNames,'dynDiv_resizeDiv_bl')) {
            parent.style.cursor = 'sw-resize';
            ByRei_dynDiv.set_eventListener(parent,'mousedown', func_resize_bl);
   }
    else if (ByRei_dynDiv.check_array(classNames,'dynDiv_resizeDiv_br')) {
            parent.style.cursor = 'se-resize';
            ByRei_dynDiv.set_eventListener(parent,'mousedown', func_resize_br);
    }
    else if (ByRei_dynDiv.check_array(classNames,'dynDiv_minmaxDiv')) {
            parent.style.cursor = 'pointer';
            ByRei_dynDiv.set_eventListener(parent,'mousedown', func_min_max);
    }
   // Drop Areas
    else if (ByRei_dynDiv.check_array(classNames,'dynDiv_dropArea')) {
            ByRei_dynDiv.dropArea.push([parent,'global']);
    }
   else if (ByRei_dynDiv.check_array(classNames,'dynDiv_dropArea-',1)) {
            ByRei_dynDiv.dropArea.push([parent,ByRei_dynDiv.check_array(classNames,'dynDiv_dropArea-',1)]);
   }
   // Limit Movements
   while (l_parent) {
    if (l_parent.className) {
        if (ByRei_dynDiv.check_array(l_parent.className.split(' '),'dynDiv_setLimit')) {
            if (parent !== l_parent) {limiter = l_parent;}
            break;
        }
    }
    l_parent = l_parent.parentNode;
   }
    // Body Limit
   if (!limiter) {
       if (ByRei_dynDiv.check_array(classNames,'dynDiv_bodyLimit') || ByRei_dynDiv.check_array(parent.parentNode.className.split(' '),'dynDiv_bodyLimit')) {
           limiter = document.body;
       } 
   }
   // Drop Limit
    if (ByRei_dynDiv.check_array(classNames,'dynDiv_dropLimit')) {
      droplimiter = 'global';
   } else if (ByRei_dynDiv.check_array(classNames,'dynDiv_dropLimit-',1)) {
       droplimiter = ByRei_dynDiv.check_array(classNames,'dynDiv_dropLimit-',1);
   }
   // Drop Mode (fit, center)
   if (ByRei_dynDiv.check_array(classNames,'dynDiv_dropMode-',1)) {
       dropmode = ByRei_dynDiv.check_array(classNames,'dynDiv_dropMode-',1);
   }
   // Hide Action (false, move, resize)
   if (ByRei_dynDiv.check_array(classNames,'dynDiv_hideMove') && ByRei_dynDiv.check_array(classNames,'dynDiv_hideResize')) {
       hideaction = 'move_resize';
   } else {
       if (ByRei_dynDiv.check_array(classNames,'dynDiv_hideMove')) {
           hideaction = 'move';
       } else if (ByRei_dynDiv.check_array(classNames,'dynDiv_hideResize')) {
           hideaction = 'resize';
       }
   }
   // Show Resize (active, doubleclick) 
   if (ByRei_dynDiv.check_array(classNames,'dynDiv_showResize-',1)) {
       showresize = ByRei_dynDiv.check_array(classNames,'dynDiv_showResize-',1);
        ByRei_dynDiv.showResize(parent,false);
      if (showresize === 'dblclick') {
                 ByRei_dynDiv.set_eventListener(parent,'dblclick', func_show_resize);
      }
   }
    // Write main DIVs in the DIV List
   if (ByRei_dynDiv.check_array(classNames,'dynDiv_moveParentDiv') || ByRei_dynDiv.check_array(classNames,'dynDiv_moveDiv')) {
      ByRei_dynDiv.divList.push([parent,limiter,status,zIndex,0,0,droplimiter,dropmode,false,hideaction,showresize]);
   }
   }
  }
 },
 
 check_array: function (array,value,ncs) {
  var r_value='';
   if (array && value) {
    for (var i=0;i<array.length;i++) {
     if (ncs && array[i].indexOf(value) >= 0) {
        r_value=array[i].split(value)[1];
       break;
    } else if (array[i] === value) {
        r_value=array[i];
       break;
    }
    }
   }
  return r_value;
 },
 
 del_eventListener: function(obj,event,func) {
  if (obj && event && func) {
   if (window.detachEvent) {obj.detachEvent("on"+event, func);} else {obj.removeEventListener(event, func, false);}
  }
 },
 
 set_eventListener: function(obj,event,func) {
  if (obj && event && func) {
   if (window.attachEvent) {obj.attachEvent("on"+event, func);} else {obj.addEventListener(event, func, false);}
  }
 }
 
};

ByRei_dynDiv.set_eventListener(window, 'load', ByRei_dynDiv.init);