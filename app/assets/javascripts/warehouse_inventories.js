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
        $.each($('.warehouse_spot'), function(index, warehouse_spot) {
            $(warehouse_spot).warehouseSpotPlugin();
            var warehouse_spot_plugin = $(warehouse_spot).data('warehouseSpotPlugin');
            warehouse_spot_plugin.populateWarehouseSpotDropdown($(warehouse_select).val());
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
        var database_quantity = $(this).parent().parent().find('.database_quantity');
        $(database_quantity).warehouseSpotPlugin();
        var warehouse_spot_plugin = $(database_quantity).data('warehouseSpotPlugin');
        warehouse_spot_plugin.populateWarehouseSpotBalance($(warehouse_select).val(), $(this).val());
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
    $('.product_autocomplete').live('railsAutocomplete.select', function(event, data){
        $(this).parent().parent().find('.real_product_id').val(data.item.id);

        var warehouse_inventory_row = $(this).parent().parent();
        $(warehouse_inventory_row).productPlugin();
        var product_plugin = $(warehouse_inventory_row).data('productPlugin');
        var product_balance_request_object = product_plugin.fetchBalance($('#warehouse_inventory_warehouse_id').val(), data.item.id);

        product_balance_request_object.done(function(product_balance) {
            //used floor to convert float to int
            $(warehouse_inventory_row).find('.database_quantity').val(Math.floor(product_balance.balance));
        });
    });
}