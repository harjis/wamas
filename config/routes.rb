Wamas::Application.routes.draw do

  # Product
  get 'products/balance/:warehouse_id/:product_id' => 'products#balance'
  resources :products

  # Purchase order
  get "purchase_orders/autocomplete_product_name"
  get 'purchase_orders/show_receive/:id'  => 'purchase_orders#show_receive'
  resources :purchase_orders do
    resources :purchase_order_rows
    get :autocomplete_product_name, :on => :collection
  end

  # Sales order
  get "sales_orders/autocomplete_product_name"
  get 'sales_orders/show_delivery/:id' => 'sales_orders#show_delivery'
  resources :sales_orders do
    resources :sales_order_rows
    get :autocomplete_product_name, :on => :collection
  end

  # Shipment
  post 'shipments/deliver' => 'shipments#deliver'
  resources :shipments do
    resource :shipment_rows
  end

  # Supply
  post 'supplies/receive/' => 'supplies#receive'
  resources :supplies do
    resources :supply_rows
  end

  # Warehouse Spot
  #we need to introduce the custom routes before the standard recources
  #otherwise warehouse_spots/spots_with_balance_by_warehouse_id_sales_order_row_id would map to warehouse_spots/show
  get 'warehouse_spots/all_by_warehouse_id/:warehouse_id'  => 'warehouse_spots#all_by_warehouse_id'
  get 'warehouse_spots/spots_with_balance_by_warehouse_id_sales_order_row_id/:warehouse_id/:sales_order_row_id' => 'warehouse_spots#spots_with_balance'
  get 'warehouse_spots/:warehouse_spot_id/content/:warehouse_id' => 'warehouse_spots#content'
  resources :warehouse_spots do
    get :warehouse_spots_by_warehouse_id
  end

  # Warehouse inventory
  get "warehouse_inventories/autocomplete_product_name"
  get "warehouse_inventories/warehouse_select" => "warehouse_inventories#warehouse_select"
  get "warehouse_inventories/warehouse_spots_by_warehouse" => "warehouse_inventories#warehouse_spots_by_warehouse"
  get "warehouse_inventories/inventory_by_warehouse_spot" => "warehouse_inventories#inventory_by_warehouse_spot"
  resources :warehouse_inventories do
    resources :warehouse_inventory_rows
    get :autocomplete_product_name, :on => :collection
  end

  # Warehouse
  resources :warehouses

  get "home/index"
   root :to => 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
