//var area = null;
//var cmbProvince = null;
//var cmbCity = null;
//var cmbArea = null;
var addressInit = function (_carea, _cmbProvince, _cmbCity, _cmbArea, defaultarea, defaultProvince, defaultCity, defaultArea) {

    var area = $("#" + _carea + "");
    var cmbProvince = $("#" + _cmbProvince + "");
    var cmbCity = $("#" + _cmbCity + "");
    var cmbArea = $("#" + _cmbArea + "");
    bindArea();
    bindProvincelist();
    bindCity();
    bindcmbArea();

    area.on('select', function (event) {
        bindProvincelist();
    });
    cmbProvince.on('select', function () {
        bindCity();
    });
    cmbCity.on('select', function () {

        bindcmbArea();
    });


    function bindArea() {
        area.jqxDropDownList('clear');
        var arealist = getDataTableList(" reserved_field1 as code,reserved_field2 as name ", "rcm_int_dictionary", " where xtype ='Z004' order by reserved_field1 ");
        area.jqxDropDownList({
            source: arealist,
            searchMode: 'contains',
            valueMember: 'CODE',
            displayMember: 'NAME',
            filterable: true,
            placeHolder: "",
            width: '100',
            dropDownHeight: 250
            //        , selectedIndex: 0
        });

    }

    function bindProvincelist() {
        cmbProvince.jqxDropDownList('clear');
        var cmbProvincelist = [""];
        var index = area.jqxDropDownList('getSelectedIndex');
        if (index != -1) {
            var item = area.jqxDropDownList('getItem', index).value;
            cmbProvincelist = getDataTableList("reserved_field1 as code,reserved_field2 as name ", "rcm_int_dictionary", " where xtype ='Z005' and reserved_field4='" + $.trim(item) + "'  order by reserved_field1  ");
        }

        cmbProvince.jqxDropDownList({
            source: cmbProvincelist,
            searchMode: 'contains',
            valueMember: 'CODE',
            displayMember: 'NAME',
            filterable: true,
            width: '150',
            placeHolder: "",
            dropDownHeight: 250
        , selectedIndex: 0
        });

    }

    function bindCity() {
        cmbCity.jqxDropDownList('clear');
        var cmbCitylist = [""];
        var index1 = cmbProvince.jqxDropDownList('getSelectedIndex');
        if (index1 != -1) {
            var item1 = cmbProvince.jqxDropDownList('getItem', index1).value;
            cmbCitylist = getDataTableList(" reserved_field1 as code,reserved_field2 as name ", "rcm_int_dictionary", " where xtype ='Z006' and reserved_field4='" + $.trim(item1) + "'  order by reserved_field1 ");
        }

        cmbCity.jqxDropDownList({
            source: cmbCitylist,
            searchMode: 'contains',
            valueMember: 'CODE',
            displayMember: 'NAME',
            filterable: true,
            width: '150',
            placeHolder: "",
            dropDownHeight: 250
        , selectedIndex: 0
        });


    }
    function bindcmbArea() {
        cmbArea.jqxDropDownList('clear');
        var cmbArealist = [""];
        var index2 = cmbCity.jqxDropDownList('getSelectedIndex');
        if (index2 != -1) {
            var item2 = cmbCity.jqxDropDownList('getItem', index2).value;
            cmbArealist = getDataTableList(" reserved_field1 as code,reserved_field2 as name ", "rcm_int_dictionary", " where xtype ='Z007' and reserved_field4='" + $.trim(item2) + "'  order by reserved_field1 ");
        }

        cmbArea.jqxDropDownList({
            source: cmbArealist,
            searchMode: 'contains',
            valueMember: 'CODE',
            displayMember: 'NAME',
            filterable: true,
            width: '150',
            placeHolder: "",
            dropDownHeight: 250
        , selectedIndex: 0
        });

    }


    area.jqxDropDownList('val', defaultarea == undefined ? "" : defaultarea);
    cmbProvince.jqxDropDownList('val', defaultProvince == undefined ? "" : defaultProvince);
    cmbCity.jqxDropDownList('val', defaultCity == undefined ? "" : defaultCity);
    cmbArea.jqxDropDownList('val', defaultArea == undefined ? "" : defaultArea);

}


//function clear() {
//    cmbProvince.jqxDropDownList('clear');
//    cmbArea.jqxDropDownList('clear');
//    cmbCity.jqxDropDownList('clear');
//}
