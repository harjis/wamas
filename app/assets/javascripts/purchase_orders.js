$(document).ready(function () {
    warehouseDropdownChange();
});

function warehouseDropdownChange() {
    $('#warehouse_warehouse_id').change(function () {
        flushWarehouseSpotDropdowns();
        getWarehouseSpots($('#warehouse_warehouse_id').val());
    });
}

function getWarehouseSpots(warehouse_id) {
    $.ajax({
        type:"GET",
        dataType:"JSON",
        async:false,
        url:"/warehouse_spots/all_by_warehouse_id/" + warehouse_id

    }).done(function (data) {
            populateWarehouseSpots(data);
        }).fail(function () {
            alert("An error has occured");
        });
}

function populateWarehouseSpots(warehouse_spots) {
    $.each($('.warehouse_spot'), function (index, value) {
        $.each(warehouse_spots, function (warehouse_spot_index, warehouse_spot) {
            var dropdown_text = warehouse_spot.row + '-' + warehouse_spot.level + '-' + warehouse_spot.position;
            var option = new Option(dropdown_text, warehouse_spot.id);
            $(value).append(option);
        });
    });
}

function flushWarehouseSpotDropdowns() {
    $.each($('.warehouse_spot'), function (index, value) {
        $(value).html('');
        var option = new Option('Select a warehouse spot', '');
        $(value).append(option);
    });
}

function remove_purchase_order_row(link) {
    $(link).prev('input[type=hidden]').val(true);
    $(link).parent().parent().hide();
}

function add_purchase_order_row(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    console.log($(link).parent().find('#purchase_order_rows_table tbody tr:last'));
    $(link).parent().find('#purchase_order_rows_table tbody tr:last').after(content.replace(regexp, new_id));
}