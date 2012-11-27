function remove_sales_order_row(link) {
   $(link).prev('input[type=hidden_field]').val(1);
   $(link).parent().hide();
}