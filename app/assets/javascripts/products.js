(function ($) {
    var ProductPlugin = function (element) {
        var element = $(element);
        var obj = this;

        this.fetchBalance = function (warehouse_id, product_id) {
            return $.ajax({
                async:false,
                dataType:'json',
                type:'GET',
                url:'/products/balance/' + warehouse_id + '/' + product_id
            }).done(function (data) {
                    if (console && console.log) {
                        console.log('Balance was fetched');
                        console.log(data);
                    }
                });
        };
    };

    $.fn.productPlugin = function () {
        return this.each(function () {
            var element = $(this);

            if (element.data('productPlugin')) {
                return;
            }

            var productPlugin = new ProductPlugin(this);

            element.data('productPlugin', productPlugin);
        });
    };

})(jQuery);