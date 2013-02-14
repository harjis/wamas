(function ($) {
    var WarehouseInventoryPlugin = function (element) {
        var element = $(element);
        var obj = this;

        this.createInventoryRow = function (index) {
            var inventory_row = $('#warehouse_inventroy_row_template').clone();

            $(inventory_row).attr('id', 'warehouse_inventory_row');
            $(inventory_row).find('.real_product_id').attr('name', 'warehouse_inventory[warehouse_inventory_rows_attributes][' + index + '][product]');
            $(inventory_row).find('.warehouse_entry_spot_id').attr('name', 'warehouse_inventory[warehouse_inventory_rows_attributes][' + index + '][warehouse_entry_spot_id]');
            $(inventory_row).find('.name_helper').attr('name', 'warehouse_inventory[warehouse_inventory_rows_attributes][' + index + '][name]');
            $(inventory_row).find('.counted_quantity').attr('name', 'warehouse_inventory[warehouse_inventory_rows_attributes][' + index + '][counted_quantity]');

            $(inventory_row).css('display', 'block');

            return inventory_row;
        };

        this.populateWarehouseEntrySpotContent = function(warehouse_entry_spot) {
            //all warehouse_entries point to same product id
            //if warehouse_entries > 1 it means that there is a supply and shipments for this spot
            $(element).find('.real_product_id').val(warehouse_entry_spot.warehouse_entries[0].product.id);
            $(element).find('.warehouse_entry_spot_id').val(warehouse_entry_spot.id);
            $(element).find('.name_helper').val(warehouse_entry_spot.warehouse_entries[0].product.name);
            $(element).find('.database_quantity').val(warehouse_entry_spot.remaining_spot_quantity);
        };

    };

    $.fn.warehouseInventoryPlugin = function () {
        return this.each(function () {
            var element = $(this);

            if (element.data('warehouseInventoryPlugin')) {
                return;
            }

            var warehouseInventoryPlugin = new WarehouseInventoryPlugin(this);

            element.data('warehouseInventoryPlugin', warehouseInventoryPlugin);
        });
    };

})(jQuery);

var warehouse_select;
$(document).ready(function () {
    map_product_autocomplete_field_to_id_field();
    warehouse_dropdown_change();
    warehouse_spot_dropdown_change();
});

function warehouse_dropdown_change() {
    $('#warehouse_inventory_warehouse_id').on('change', function () {
        warehouse_select = this;
        flush_warehouse_spot_dropdowns();
        $.each($('.warehouse_spot'), function (index, warehouse_spot) {
            $(warehouse_spot).warehouseSpotPlugin();
            var warehouse_spot_plugin = $(warehouse_spot).data('warehouseSpotPlugin');
            warehouse_spot_plugin.populateWarehouseSpotDropdown($(warehouse_select).val());

            //DEVELOPER NOTE: it has been decided that this function only works with one spot inventory per layout
            //considering this we can say that the warehouse_spot name attribute can be
            //warehouse_inventory[warehouse_inventory_rows_attributes][warehouse_spot]
            //$(warehouse_spot).attr('name', 'warehouse_inventory[warehouse_inventory_rows_attributes][warehouse_spot]');
            $(warehouse_spot).attr('name', 'warehouse_spot[id]');
        });
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

function warehouse_spot_dropdown_change() {
    $('.warehouse_spot').on('change', function () {
        var warehouse_inventory_row = $(this).parent().parent();
        $(warehouse_inventory_row).warehouseSpotPlugin();
        var warehouse_spot_plugin = $(warehouse_inventory_row).data('warehouseSpotPlugin');
        var spot_content_request_obj = warehouse_spot_plugin.fetchWarehouseSpotContent($(warehouse_select).val(), $(this).val());

        spot_content_request_obj.done(function (fetched_spot) {
            $.each(fetched_spot.warehouse_entry_spots, function (index, warehouse_entry_spot) {
                $(warehouse_inventory_row).warehouseInventoryPlugin();
                var warehouse_inventory_plugin = $(warehouse_inventory_row).data('warehouseInventoryPlugin');
                var created_inventory_row = warehouse_inventory_plugin.createInventoryRow(index);

                $(created_inventory_row).warehouseInventoryPlugin();
                var warehouse_inventory_plugin = $(created_inventory_row).data('warehouseInventoryPlugin');
                warehouse_inventory_plugin.populateWarehouseEntrySpotContent(warehouse_entry_spot);

                $(warehouse_inventory_row).append(created_inventory_row);
            });
        });
    });
}

function remove_warehouse_inventory_row(link) {
    $(link).prev('input[type=hidden]').val(true);
    $(link).parent().parent().hide();
}

function add_warehouse_inventory_row(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().find('#warehouse_inventory_rows:last').after(content.replace(regexp, new_id));
}

function map_product_autocomplete_field_to_id_field() {
    //when product autocomplete select is clicked this event is called
    $('.product_autocomplete').live('railsAutocomplete.select', function (event, data) {
        $(this).parent().parent().find('.real_product_id').val(data.item.id);

        var warehouse_inventory_row = $(this).parent().parent();
        $(warehouse_inventory_row).productPlugin();
        var product_plugin = $(warehouse_inventory_row).data('productPlugin');
        var product_balance_request_object = product_plugin.fetchBalance($('#warehouse_inventory_warehouse_id').val(), data.item.id);

        product_balance_request_object.done(function (product_balance) {
            //used floor to convert float to int
            $(warehouse_inventory_row).find('.database_quantity').val(Math.floor(product_balance.balance));
        });
    });
}