function EnableDisable(OrderRulesID, IsActived) {
    $.ajax({
        type: "post", //要用post方式                 
        url: "OrderRulesManagement.aspx/EnableDisable",//方法所在页面和方法名
        data: "{\"OrderRulesID\":\"" + OrderRulesID + "\",\"IsActived\":\"" + IsActived + "\"}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(data.d);//返回的数据用data.d获取内容
            if (data.d != "") {
                var obj = JSON.parse(data.d);
                if (obj.state == 1) {
                    alert("操作成功");
                    javascript: location.href = location.href;
                }
                else {
                    alert("操作失败，请联系管理员");
                }
            }
        },
        error: function (err) {
            alert("操作失败，请联系管理员");
        }
    });
}

function deleteOrderRule(OrderRulesID) {
    $.ajax({
        type: "post", //要用post方式                 
        url: "OrderRulesManagement.aspx/DeleteOrderRule",//方法所在页面和方法名
        data: "{\"OrderRulesID\":\"" + OrderRulesID + "\"}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(data.d);//返回的数据用data.d获取内容
            if (data.d != "") {
                var obj = JSON.parse(data.d);
                if (obj.state == 1) {
                    alert("操作成功");
                    javascript: location.href = location.href;
                }
                else {
                    alert("操作失败，请联系管理员");
                }
            }
        },
        error: function (err) {
            alert("操作失败，请联系管理员");
        }
    });
}
 