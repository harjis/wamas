$(document).ready(function () {
    map_product_autocomplete_field_to_id_field();
});

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
            console.log(product_balance.balance);
            //used floor to convert float to int
            $(warehouse_inventory_row).find('.database_quantity').val(Math.floor(product_balance.balance));
        });
    });
}