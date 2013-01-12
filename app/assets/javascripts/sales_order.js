function remove_sales_order_row(link) {
    $(link).prev('input[type=hidden]').val(true);
    $(link).parent().parent().hide();
}

function add_sales_order_row(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    console.log($(link).parent().find('#sales_order_rows_table tbody tr:last'));
    $(link).parent().find('#sales_order_rows_table tbody tr:last').after(content.replace(regexp, new_id));
}

