$(document).ready(function () {
    map_product_autocomplete_field_to_id_field();
});

function remove_purchase_order_row(link) {
    $(link).prev('input[type=hidden]').val(true);
    $(link).parent().parent().hide();
}

function add_purchase_order_row(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().find('#purchase_order_rows_table tbody tr:last').after(content.replace(regexp, new_id));
}

function map_product_autocomplete_field_to_id_field() {
    //when product autocomplete select is clicked this event is called
    $('.product_autocomplete').live('railsAutocomplete.select', function(event, data){
        $(this).parent().parent().find('.real_product_id').val(data.item.id);
    });
}