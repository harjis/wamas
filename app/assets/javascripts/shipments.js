(function ($) {
    var ShipmentPlugin = function (element) {
        var element = $(element);
        var obj = this;

        var warehouse_spots = new Array();

        this.populateWarehouseEntrySpotDropdowns = function (warehouse_id) {

        };

        var fetchWarehouseSpotsWithBalanceBySalesOrderRow = function (warehouse_id) {
            return $.ajax({
                async:false,
                dataType:'json',
                type:'GET',
                url:'/warehouse_spots/all_by_warehouse_id/' + warehouse_id + '.json'
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