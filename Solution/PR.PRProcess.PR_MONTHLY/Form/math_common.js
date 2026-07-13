//数字加千分位
//function thousands(num) {
//    var c = (num.toString().indexOf('.') !== -1) ? num.toLocaleString() : num.toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
//    return c;
//}
function thousands(num) {
    var Amount = num.split(".");
    var number = Amount.length > 1 ? Amount[1].substring(0, 2) : "00";
    if (number.length <= 1) {
        number += "0";
    }
    return Amount[0].replace(/\B(?=(?:\d{3})+\b)/g, ',') + "." + number;
}


//去除千分位
function numberval(num) {
    if (num && num != 'undefined' && num != 'null') {
        let numS = num;
        numS = numS.toString();
        numS = numS.replace(/,/gi, '');
        return Number(numS);
    } else {
        return 0;
    }
}