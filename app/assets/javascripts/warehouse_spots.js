(function ($) {
    var WarehouseSpotPlugin = function (element) {
        var element = $(element);
        var obj = this;

        this.populateWarehouseSpotDropdown = function (warehouse_id) {

            var warehouse_spots_request_obj = fetchWarehouseSpots(warehouse_id);
            warehouse_spots_request_obj.done(function (fetched_warehouse_spots) {
                $.each(fetched_warehouse_spots, function (index, warehouse_spot) {
                    var option = new Option(warehouse_spot.name, warehouse_spot.id);
                    $(element).append(option);

                    var attr = $(element).attr('name');
                    //some weird bug here, doesnt go into if
                    if (typeof attr !== 'undefined' && attr !== false) {
                        var spot_index = $(element).parent().parent().find('.child_index').html();
                        spot_index = spot_index.replace(/\D/g, '');
                        $(element).attr('name', 'warehouse_spots[' + spot_index + '][warehouse_spot]');
                    }
                    else {
                        var spot_index = $(element).parent().parent().find('.child_index').html();
                        spot_index = spot_index.replace(/\D/g, '');
                        $(element).attr('name', 'warehouse_spots[' + spot_index + '][warehouse_spot]');
                    }
                });
            });
        };

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
                            var spot_index = $(dropdown).attr('name');
                            spot_index = spot_index.replace(/\D/g, '');
                            $(dropdown).attr('name', 'warehouse_spots[' + spot_index + '][warehouse_spot]');
                        }
                        else {
                            var spot_index = $(dropdown).parent().parent().find('.supplied_quantity').attr('name');
                            spot_index = spot_index.replace(/\D/g, '');
                            $(dropdown).attr('name', 'warehouse_spots[' + spot_index + '][warehouse_spot]');
                        }
                    });
                });
            });
        };

        this.populateWarehouseSpotBalance = function (warehouse_id, warehouse_spot_id) {
            var warehouse_spot_content_request_obj = fetchWarehouseSpotContent(warehouse_id, warehouse_spot_id);
            warehouse_spot_content_request_obj.done(function (spot_content) {

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
                        console.log('Warehouse spots were fetched by warehouse_id: ' + warehouse_id);
                        console.log(data);
                    }
                });
        };

        var fetchWarehouseSpotContent = function (warehouse_id, warehouse_spot_id) {
            return $.ajax({
                async:false,
                dataType:'json',
                type:'GET',
                url:'/warehouse_spots/' + warehouse_spot_id + '/content/' + warehouse_id
            }).done(function (data) {
                    if (console && console.log) {
                        console.log('Balance was fetched');
                        console.log(data);
                    }
                });
        }
    };

    $.fn.warehouseSpotPlugin = function () {
        return this.each(function () {
            var element = $(this);

            if (element.data('warehouseSpotPlugin')) {
                return;
            }

            var warehouseSpotPlugin = new WarehouseSpotPlugin(this);

            element.data('warehouseSpotPlugin', warehouseSpotPlugin);
        });
    };

})(jQuery);