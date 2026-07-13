//弹出隐藏层
        function showDiv() {
            document.getElementById("loadingdiv").style.display = 'block';
            document.getElementById("fade").style.display = 'block';
            var bgdiv = document.getElementById("fade");
            bgdiv.style.width = document.body.scrollWidth;
            $("#" + "fade").height($(document).height());
//            sc1("#" + "loadingdiv");
        }
        //关闭弹出层
        function closeDiv() {
            document.getElementById("loadingdiv").style.display = 'none';
            document.getElementById("fade").style.display = 'none';
        }

        function sc1(DivId) {
            var Div = $(DivId);
            $(DivId).style.top = (document.documentElement.scrollTop + (document.documentElement.clientHeight - $(DivId).offsetHeight) / 2) + "px";
            $(DivId).style.left = (document.documentElement.scrollLeft + (document.documentElement.clientWidth - $(DivId).offsetWidth) / 2) + "px";
            //alert($(DivId).style.top); 
        } 