(function ($) {
    var SupplyPlugin = function (element) {
        var element = $(element);
        var obj = this;

        var warehouse_spots = new Array();

        this.populateWarehouseSpotDropdowns = function (warehouse_id) {
            var warehouse_spot_dropdowns = $(element).find('.warehouse_spot');

            var warehouse_spots_request_obj = fetchWarehouseSpots(warehouse_id);
            warehouse_spots_request_obj.done(function (fetched_warehouse_spots) {
                $.each(fetched_warehouse_spots, function (index, warehouse_spot) {
                    $.each(warehouse_spot_dropdowns, function (index, dropdown) {
                        var option = new Option(warehouse_spot.name, warehouse_spot.id);
                        $(dropdown).append(option);

                        var attr = $(dropdown).attr('name');
                        //some weird bug here, doesnt go into if
                        if (typeof attr !== 'undefined' && attr !== false) {
                            var supply_row_index = $(dropdown).attr('name');
                            supply_row_index = supply_row_index.replace(/\D/g, '');
                            $(dropdown).attr('name', 'warehouse_spots[' + supply_row_index + '][warehouse_spot]');
                        }
                        else {
                            var supply_row_index = $(dropdown).parent().parent().find('.supplied_quantity').attr('name');
                            supply_row_index = supply_row_index.replace(/\D/g, '');
                            $(dropdown).attr('name', 'warehouse_spots[' + supply_row_index + '][warehouse_spot]');
                        }
                    });
                });
            });
        };

        var fetchWarehouseSpots = function (warehouse_id) {
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
    warehouseDropdownChange();
});

function warehouseDropdownChange() {
    $('#warehouse_warehouse_id').on('change', function () {
        flush_warehouse_spot_dropdowns();
        $('.supply_rows').supplyPlugin();
        var supply_plugin = $('.supply_rows').data('supplyPlugin');
        supply_plugin.populateWarehouseSpotDropdowns($(this).val());
    });
}

function flush_warehouse_spot_dropdowns() {
    if ($('.warehouse_spot:first').children().length > 1) {
        $.each($('.warehouse_spot'), function (index, value) {
            $(value).html('');
            var option = new Option('Select a warehouse spot', '');
            $(value).append(option);
        });
    }
}