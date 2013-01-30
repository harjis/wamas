module SuppliesHelper
  def link_to_add_purchase_order(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_dropdown", :f => builder)
    end
    logger.debug fields
    link_to_function(name, "add_purchase_order(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_remove_purchase_order(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_purchase_order(this)")
  end
end
