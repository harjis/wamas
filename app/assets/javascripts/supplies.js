(function ($) {
    var SupplyPlugin = function (element) {
        var element = $(element);
        var obj = this;

        var warehouse_spots = new Array();

        this.populateSupplyRows = function (purchase_order_id, warehouse_id) {
            var purchase_order_row_headers = {
                id: 'id',
                row_number: 'Row number',
                name: 'Name',
                unit_cost: 'Unit cost',
                order_quantity: 'Order quantity',
                line_amount: 'Line amount',
                warehouse_spot: 'Warehouse Spot',
                supplied_quantity: 'Supplied Quantity'
            };

            if(purchase_order_id != '' && warehouse_id != '') {
                var table = generatePurchaseOrderRowTable(purchase_order_id, warehouse_id, purchase_order_row_headers);
                $(element).append(table);
            }
        };

        this.removePurchaseOrderRows = function(purchase_order_id) {
            $(element).find('.purchase_order_id_input[value='+purchase_order_id+']').parent().remove();
        };

        var generatePurchaseOrderRowTable = function (purchase_order_id, warehouse_id, purchase_order_row_headers) {
            var table = document.createElement('table');
            $(table).attr('class', 'purchase_order_row_table');

            var purchase_order_id_input = document.createElement('input');
            $(purchase_order_id_input).attr('disabled' , 'disabled').attr('class', 'purchase_order_id_input').attr('type', 'hidden').val(purchase_order_id);
            $(table).append(purchase_order_id_input);

            var table_thead = document.createElement('thead');
            var table_thead_tr = document.createElement('tr');
            $.each(purchase_order_row_headers, function(index,value){
                if(index != 'id') {
                    var table_th = document.createElement('th');
                    $(table_th).html(value);
                    $(table_thead_tr).append(table_th);
                }
            });
            $(table_thead).append(table_thead_tr);

            var request_obj = fetchPurchaseOrder(purchase_order_id);

            request_obj.done(function(purchase_order){
                var table_tbody = document.createElement('tbody');
                $.each(purchase_order.purchase_order_rows, function(purchase_order_rows_index, purchase_order_rows_value){
                    var table_tr = document.createElement('tr');
                    var purchase_order_row_id = '';
                    $.each(purchase_order_row_headers, function(header_index, header_value){
                        if(purchase_order_rows_value.hasOwnProperty(header_index)) {
                            var table_td = document.createElement('td');
                            $(table_td).attr('align', 'center').html(purchase_order_rows_value[header_index]);

                            if(header_index == 'id') {
                                purchase_order_row_id = purchase_order_rows_value[header_index];
                                var id_input = document.createElement('input');
                                $(id_input).attr('type', 'hidden').attr('name' , 'supply[supply_rows_attributes]['+purchase_order.id+'][warehouse_entry]['+purchase_order_row_id+'][purchase_order_id]').val(purchase_order_rows_value[header_index]);
                                $(table_td).css('display', 'none');
                            }

                            $(table_tr).append(table_td);
                        }
                    });
                    $(table_tr).append(warehouseSpotTableTD(warehouse_id, purchase_order.id, purchase_order_row_id));
                    $(table_tr).append(suppliedQuantityTableTD(purchase_order.id, purchase_order_row_id));
                    $(table_tbody).append(table_tr);
                });

                $(table).append(table_thead);
                $(table).append(table_tbody);
            });

            return table;
        };

        var fetchPurchaseOrder = function(purchase_order_id) {
            return $.ajax({
                async: true,
                dataType: 'json',
                type: 'GET',
                url: '/purchase_orders/' + purchase_order_id + '.json'
            }).done(function(data) {
                    if( console && console.log ) {
                        console.log('Purchase order was fetched');
                        console.log(data);
                    }
                });
        };

        var warehouseSpotTableTD = function (warehouse_id, purchase_order_id, purchase_order_row_id) {
            var table_td = document.createElement('td');
            $(table_td).attr('aling', 'center');

            if (warehouse_spots.length == 0) {
                var warehouse_spots_request_obj = fetchWarehouseSpots(warehouse_id);
                warehouse_spots_request_obj.done(function (fetched_warehouse_spots) {
                    $.each(fetched_warehouse_spots, function(index,value){
                        warehouse_spots.push(value);
                    });
                });
            }

            var warehouse_spot_select = document.createElement('select');
            $(warehouse_spot_select).attr('class', 'warehouse_spot_select').attr('name', 'supply[supply_rows_attributes]['+purchase_order_id+'][warehouse_entry]['+purchase_order_row_id+'][warehouse_spot]');

            var option = new Option('Select a warehouse spot', '');
            $(warehouse_spot_select).append(option);

            $.each(warehouse_spots, function (warehouse_spot_index, warehouse_spot) {
                var dropdown_text = warehouse_spot.row + '-' + warehouse_spot.level + '-' + warehouse_spot.position;
                var option = new Option(dropdown_text, warehouse_spot.id);
                $(warehouse_spot_select).append(option);
            });

            $(table_td).append(warehouse_spot_select);

            return table_td;
        };

        var suppliedQuantityTableTD = function(purchase_order_id, purchase_order_row_id) {
            var table_td = document.createElement('td');
            $(table_td).attr('aling', 'center');
            var supplied_quantity_input = document.createElement('input');
            $(supplied_quantity_input).attr('class', 'supplied_quantity').attr('name', 'supply[supply_rows_attributes]['+purchase_order_id+'][warehouse_entry]['+purchase_order_row_id+'][supplied_quantity]');
            $(table_td).append(supplied_quantity_input);

            return table_td;
        };

        var fetchWarehouseSpots = function(warehouse_id) {
            return $.ajax({
                async: false,
                dataType: 'json',
                type: 'GET',
                url: '/warehouse_spots/all_by_warehouse_id/' + warehouse_id + '.json'
            }).done(function(data){
                    if( console && console.log ) {
                        console.log('Warehouse spots were fetched');
                        console.log(data);
                    }
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
        $(this).attr('name' , 'supply[purchase_orders_attributes]['+$(this).val()+'][purchase_order_id]');
        populate_purchase_order_rows($(this).val(), $(document).find('#warehouse_warehouse_id').val());
    });
}

function populate_purchase_order_rows(purchase_order_id, warehouse_id) {
    $('#purchase_order_rows_wrapper').supplyPlugin();
    var supply_plugin = $('#purchase_order_rows_wrapper').data('supplyPlugin');
    supply_plugin.populateSupplyRows(purchase_order_id, warehouse_id);

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

    remove_purhcase_order_rows($(link).parent().find('.purchase_orders').val());
}

function remove_purhcase_order_rows(purchase_order_id) {
    $('#purchase_order_rows_wrapper').supplyPlugin();
    var supply_plugin = $('#purchase_order_rows_wrapper').data('supplyPlugin');
    supply_plugin.removePurchaseOrderRows(purchase_order_id);
}

function add_purchase_order(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().append(content.replace(regexp, new_id));
}