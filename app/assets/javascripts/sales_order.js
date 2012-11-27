function remove_sales_order_row(link) {
    $(link).prev('input[type=hidden]').val(true);
    $(link).parent().hide();
}

function add_sales_order_row(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).after(content.replace(regexp, new_id));
}

