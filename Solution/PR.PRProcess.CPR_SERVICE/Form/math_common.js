//数字加千分位
function thousands(num) {
    var c = (num.toString().indexOf('.') !== -1) ? num.toLocaleString() : num.toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
    return c;
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