(function ($) {
    var SupplyPlugin = function (element, options) {
        var element = $(element);
        var obj = this;

        this.populateSupplyRows = function (purchase_order_id) {
            var purchase_order_row_headers = {
                id: 'id',
                row_number: 'Row number',
                name: 'Name',
                unit_cost: 'Unit cost',
                order_quantity: 'Order quantity',
                line_amount: 'Line amount'
            };

            if(purchase_order_id != '') {
                var table = generatePurchaseOrderRowTable(purchase_order_id, purchase_order_row_headers);

                $(element).append(table);
            }
        };

        var generatePurchaseOrderRowTable = function (purchase_order_id, purchase_order_row_headers) {
            var table = document.createElement('table');
            $(table).attr('class', 'purchase_order_row_table');

            var table_thead = document.createElement('thead');
            var table_thead_tr = document.createElement('tr');
            $.each(purchase_order_row_headers, function(index,value){
                var table_th = document.createElement('th');
                $(table_th).html(value);
                $(table_thead_tr).append(table_th);
            });
            $(table_thead).append(table_thead_tr);

            fetchPurchaseOrder(purchase_order_id, function(purchase_order) {
                var table_tbody = document.createElement('tbody');
                $.each(purchase_order.purchase_order_rows, function(purchase_order_rows_index, purchase_order_rows_value){
                    var table_tr = document.createElement('tr');
                    $.each(purchase_order_row_headers, function(header_index, header_value){
                        var table_td = document.createElement('td');
                        $(table_td).html(purchase_order_rows_value[header_value]);

                        $(table_tr).append(table_td);
                    });
                    $(table_tbody).append(table_tr);
                });
            });
            console.log(table_tbody);
            $(table).append(table_thead);
            $(table).append(table_tbody);

            return table;
        };

        var fetchPurchaseOrder = function(purchase_order_id, callback) {
            $.ajax({
                async: true,
                dataType: 'json',
                type: 'GET',
                url: '/purchase_orders/' + purchase_order_id + '.json'
            }).done(function(data){
                    if( console && console.log ) {
                        console.log('Purchase order was fetched');
                    }

                    callback(data);
                });
        };
    };

    $.fn.supplyPlugin = function () {
        return this.each(function () {
            var element = $(this);

            if (element.data('supplyPlugin')) {
                return;
            }

            var supplyPlugin = new SupplyPlugin(this);

            element.data('supplyPlugin', supplyPlugin);
        });
    };

})(jQuery);

$(document).ready(function () {
    warehouse_dropdown_change();
    bind_purchase_order_change();
});

function bind_purchase_order_change() {
    $('.purchase_orders').live('change', function () {
        populate_purchase_order_rows($(this).val());
    });
}

function populate_purchase_order_rows(purchase_order_id) {
    $('#purchase_order_rows_wrapper').supplyPlugin();
    var supply_plugin = $('#purchase_order_rows_wrapper').data('supplyPlugin');
    supply_plugin.populateSupplyRows(purchase_order_id);

}

function warehouse_dropdown_change() {
    $('#warehouse_warehouse_id').change(function () {
        flush_warehouse_spot_dropdowns();
        get_warehouse_spots($('#warehouse_warehouse_id').val());
    });
}

function get_warehouse_spots(warehouse_id) {
    $.ajax({
        type:"GET",
        async:false,
        url:"/warehouse_spots/all_by_warehouse_id/" + warehouse_id

    }).done(function (data) {
            populate_warehouse_spots(data);
        }).fail(function () {
            alert("An error has occured");
        });
}

function populate_warehouse_spots(warehouse_spots) {
    $.each($('.warehouse_spot'), function (index, value) {
        $.each(warehouse_spots, function (warehouse_spot_index, warehouse_spot) {
            var dropdown_text = warehouse_spot.row + '-' + warehouse_spot.level + '-' + warehouse_spot.position;
            var option = new Option(dropdown_text, warehouse_spot.id);
            $(value).append(option);
        });
    });
}

function flush_warehouse_spot_dropdowns() {
    $.each($('.warehouse_spot'), function (index, value) {
        $(value).html('');
        var option = new Option('Select a warehouse spot', '');
        $(value).append(option);
    });
}

function remove_purchase_order(link) {
    $(link).prev('input[type=hidden]').val(true);
    $(link).parent().hide();
}

function add_purchase_order(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().append(content.replace(regexp, new_id));
}