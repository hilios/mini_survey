module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.input(:_destroy, :as => :boolean, :label => false) + link_to(name, '#', :"data-nested" => 'remove')
  end
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    field = f.simple_fields_for(association, new_object, :child_index => "new_fields") do |builder|
      render(association.to_s.singularize + '_fields', :f => builder).gsub(/\n/, '').html_safe
    end
    link_to(name, '#', :"data-nested" => 'add', :"data-fields" => "#{field}")
  end
  # from: http://simplesideias.com.br/exibindo-mensagens-no-rails/
  def flash_messages
    messages = ""
    [:notice, :info, :warning, :error].each do |type|
      messages += simple_format flash[type], :class => "flash #{type}" if flash[type]
    end
    messages.html_safe
  end
  
  def controller_is? *controllers, &block
    has_value = controllers.collect { |item| item.is_a?(Symbol) ? item.to_s : item }.include? params[:controller]
    return block_given? ? yield(has_value) : has_value
  end
  
  def action_is? *actions, &block
    has_value = actions.collect { |item| item.is_a?(Symbol) ? item.to_s : item }.include? params[:action]
    return block_given? ? yield(has_value) : has_value
  end
end
