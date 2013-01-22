(function ($) {
    var SupplyPlugin = function (element) {
        var element = $(element);
        var obj = this;

        this.populateSupplyRows = function () {
            console.log('populatesupply rows called');
        };
    };

    $.fn.supplyplugin = function () {
        return this.each(function () {
            var element = $(this);

            if (element.data('supplyplugin')) {
                return;
            }

            var supplyplugin = new SupplyPlugin(this);

            element.data('supplyplugin', supplyplugin);
        });
    };

})(jQuery);

$(document).ready(function () {
    warehouse_dropdown_change();
    bind_purchase_order_change();
});

function bind_purchase_order_change() {
    $('.purchase_orders').live('change', function () {
        populate_purchase_order_rows($(this).val());
    });
}

function populate_purchase_order_rows(purchase_order_id) {
    $('#purchase_order_rows_wrapper').supplyplugin()
    var supply_plugin = $('#purchase_order_rows_wrapper').data('supplyplugin');
    supply_plugin.populateSupplyRows();

}

function warehouse_dropdown_change() {
    $('#warehouse_warehouse_id').change(function () {
        flush_warehouse_spot_dropdowns();
        get_warehouse_spots($('#warehouse_warehouse_id').val());
    });
}

function get_warehouse_spots(warehouse_id) {
    $.ajax({
        type:"GET",
        async:false,
        url:"/warehouse_spots/all_by_warehouse_id/" + warehouse_id

    }).done(function (data) {
            populate_warehouse_spots(data);
        }).fail(function () {
            alert("An error has occured");
        });
}

function populate_warehouse_spots(warehouse_spots) {
    $.each($('.warehouse_spot'), function (index, value) {
        $.each(warehouse_spots, function (warehouse_spot_index, warehouse_spot) {
            var dropdown_text = warehouse_spot.row + '-' + warehouse_spot.level + '-' + warehouse_spot.position;
            var option = new Option(dropdown_text, warehouse_spot.id);
            $(value).append(option);
        });
    });
}

function flush_warehouse_spot_dropdowns() {
    $.each($('.warehouse_spot'), function (index, value) {
        $(value).html('');
        var option = new Option('Select a warehouse spot', '');
        $(value).append(option);
    });
}

function remove_purchase_order(link) {
    $(link).prev('input[type=hidden]').val(true);
    $(link).parent().hide();
}

function add_purchase_order(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().append(content.replace(regexp, new_id));
}