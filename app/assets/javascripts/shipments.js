(function ($) {
    var ShipmentPlugin = function (element) {
        var element = $(element);
        var obj = this;

        var warehouse_spots = new Array();

        this.populateWarehouseEntrySpotDropdowns = function (warehouse_id) {
            var shipment_rows = $(element).find('.shipment_row');

            $.each(shipment_rows, function(index, shipment_row) {
                var warehouse_spots_request_object =
                    fetchWarehouseSpotsWithBalanceBySalesOrderRow(
                        warehouse_id,
                        $(shipment_row).find('input.sales_order_id').val()
                    );
                warehouse_spots_request_object.done(function(fetched_warehouse_spots) {
                    $.each(fetched_warehouse_spots, function(index2, warehouse_spot) {
                        $.each(warehouse_spot.warehouse_entry_spots, function(index3, warehouse_entry_spot){
                            var name = warehouse_spot.name + ': quantity: ' + warehouse_entry_spot.remaining_spot_quantity;
                            var option = new Option(name, warehouse_entry_spot.id);
                            var dropdown = $(shipment_row).find('select.warehouse_entry_spot');

                            $(dropdown).append(option);

                            var shipment_row_index = $(shipment_row).find('input.shipped_quantity').attr('name');
                            shipment_row_index = shipment_row_index.replace(/\D/g, '');
                            $(dropdown).attr('name', 'warehouse_entry_spots[' + shipment_row_index + '][warehouse_entry_spot]');
                        });
                    });
                });
            });
        };

        var fetchWarehouseSpotsWithBalanceBySalesOrderRow = function (warehouse_id, sales_order_row_id) {
            return $.ajax({
                async:false,
                dataType:'json',
                type:'GET',
                url:'/warehouse_spots/spots_with_balance_by_warehouse_id_sales_order_row_id/' + warehouse_id + '/' + sales_order_row_id
            }).done(function (data) {
                    if (console && console.log) {
                        console.log('Warehouse spots were fetched');
                        console.log(data);
                    }
                });
        };
    };

    $.fn.shipmentPlugin = function () {
        return this.each(function () {
            var element = $(this);

            if (element.data('shipmentPlugin')) {
                return;
            }

            var shipmentPlugin = new ShipmentPlugin(this);

            element.data('shipmentPlugin', shipmentPlugin);
        });
    };

})(jQuery);

$(document).ready(function () {
    warehouseDropdownChange();
});

function warehouseDropdownChange() {
    $('#warehouse_warehouse_id').on('change', function () {
        flush_warehouse_spot_dropdowns();
        $('.shipment_rows').shipmentPlugin();
        var shipment_plugin = $('.shipment_rows').data('shipmentPlugin');
        shipment_plugin.populateWarehouseEntrySpotDropdowns($(this).val());
    });
}

function flush_warehouse_spot_dropdowns() {
    if ($('.warehouse_spot:first').children().length > 1) {
        $.each($('.warehouse_entry_spot'), function (index, value) {
            $(value).html('');
            var option = new Option('Select a warehouse spot', '');
            $(value).append(option);
        });
    }
}