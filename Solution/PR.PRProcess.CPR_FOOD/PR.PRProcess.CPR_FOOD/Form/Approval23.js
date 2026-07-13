//Custom method write here
function beforeSubmit() {
    return true;
}
$(function () {
    //将总价金额转化成千分位显示
    var Amount = Number($("#read_AMOUNT").text());
    $("#read_AMOUNT").text(Amount.toLocaleString());

    var Amount = Number($("#fld_SUBTOTALAMOUNT").text());
    $("#fld_SUBTOTALAMOUNT").text(Amount.toLocaleString());
})
