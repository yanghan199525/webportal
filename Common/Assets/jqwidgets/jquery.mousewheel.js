(function ($) {
    var methods = {
        init: function (options) {
            //$("#jqxgrid").mousewheel(); 调用方法
            var $form = $(this); //传进来的控件   
            var objID = $form.get(0); //document.getElementById('img');要注册的控件  objID改为window或者document为全局

            var wheel = function (event) {
                var delta = 0;
                if (!event) /* For IE. */
                    event = window.event;
                if (event.wheelDelta) { /* IE/Opera. */
                    delta = event.wheelDelta / 120;
                } else if (event.detail) {
                    /** Mozilla case. */
                    /** In Mozilla, sign of delta is different than in IE. 
                    * Also, delta is multiple of 3. 
                    */
                    delta = -event.detail / 3;
                }
                /** If delta is nonzero, handle it. 
                * Basically, delta is now positive if wheel was scrolled up, 
                * and negative, if wheel was scrolled down. 
                */
                if (delta)
                    handle(delta);
                /** Prevent default actions caused by mouse wheel. 
                * That might be ugly, but we handle scrolls somehow 
                * anyway, so don't bother here.. 
                */
                if (event.preventDefault)
                    event.preventDefault();
                event.returnValue = false;
            }

            /** 火狐DOMMouseScroll is for mozilla. */
            if (objID.addEventListener) {
                objID.addEventListener('DOMMouseScroll', wheel, false);
            }

            /*IE*/
            if (objID.attachEvent) {
                objID.attachEvent('onmousewheel', wheel);
            }

            /** IE/Opera. * 大部分浏览器全局添加方法 火狐除外/
            //window.onmousewheel = document.onmousewheel = wheel;

            /**Opera/Chrome/safari**/
            if (objID.addEventListener) {
                objID.addEventListener('mousewheel', wheel, false);
            }

            /** This is high-level function. 
            * It must react to delta being more/less than zero. 
            */
            var timerId = null;
            var i = 0;
            var handle = function (delta) {
                var state = $form.jqxGrid('getpaginginformation');
                var pagenum = state.pagenum;
                if (delta < 0) {
                    // 鼠标滑轮向下滚动 
                    i++;
                    clearTimeout(timerId);
                    timerId = setTimeout(function () {
                        //$form.jqxGrid('gotonextpage'); 
                        $form.jqxGrid('gotopage', pagenum + i);
                        i = 0;
                    }, 300);
                    return;
                } else {
                    // 鼠标滑轮向上滚动
                    i--;
                    clearTimeout(timerId);
                    timerId = setTimeout(function () {
                        $form.jqxGrid('gotopage', pagenum + i >= 0 ? pagenum + i : 0);
                        i = 0; 
                    }, 300);
                    return;
                }
            }
            return this;
        }
    };


    $.fn.mousewheel = function (method) {
        var form = $(this);
        if (!form) return false;
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.mousewheel');
        }
    };



})(jQuery);