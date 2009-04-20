module ApplicationHelper
  def flash_div *keys
    divs = keys.select { |k| flash[k] }.collect do |k|
      content_tag :div, h(flash[k]), :class => "flash #{k}" 
    end
    divs.join
  end

  class StandardFormBuilder < ActionView::Helpers::FormBuilder
    def field_settings(method, options = {}, tag_value = nil)
      field_name = "#{@object_name}_#{method.to_s}"
      default_label = tag_value.nil? ? "#{method.to_s.gsub(/\_/, " ")}".titleize : "#{tag_value.to_s.gsub(/\_/, " ")}".titleize
      label = options[:label] ? options.delete(:label) : default_label
      options[:class] ||= ""
      options[:class] += options[:required] ? " required" : ""
      label += "<strong><sup>*</sup></strong>" if options[:required]
      [field_name, label, options]
    end

    def text_field(method, options = {})
      field_name, label, options = field_settings(method, options)
      wrapper("text", field_name, label, super, options)
    end
    
    def file_field(method, options = {})
      field_name, label, options = field_settings(method, options)
      wrapper("file", field_name, label, super, options)
    end

    def datetime_select(method, options = {})
      field_name, label, options = field_settings(method, options)
      wrapper("datetime", field_name, label, super, options)
    end
    
    def date_select(method, options = {})
      field_name, label, options = field_settings(method, options)
      wrapper("date", field_name, label, super, options)
    end
    
    def radio_button(method, tag_value, options = {})
      field_name, label, options = field_settings(method, options)
      wrapper("radio", field_name, label, super, options)
    end
    
    def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
      field_name, label, options = field_settings(method, options)
      wrapper("check-box", field_name, label, super, options)
    end
    
    def select(method, choices, options = {}, html_options = {})
      field_name, label, options = field_settings(method, options)
      wrapper("select", field_name, label, super, options)
    end
    
    def time_zone_select(method, choices, options = {}, html_options = {})
      field_name, label, options = field_settings(method, options)
      # wrapping("time-zone-select", field_name, label, super, options)
      select_box = this_check_box = @template.select(@object_name, method, choices, options.merge(:object => @object), html_options)
      wrapper("time-zone-select", field_name, label, select_box, options)    
    end
    
    def password_field(method, options = {})
      field_name, label, options = field_settings(method, options)
      wrapper("password", field_name, label, super, options)
    end
    
    def text_area(method, options = {})
      field_name, label, options = field_settings(method, options)
      wrapper("textarea", field_name, label, super, options)
    end
    
    def submit(method, options = {})
      field_name, label, options = field_settings(method, options.merge( :label => "&nbsp;"))
      wrapper("submit", field_name, label, super, options)
    end
    
    def submit_and_cancel(submit_name, cancel_name, options = {})
      submit_button = @template.submit_tag(submit_name, options)
      cancel_button = @template.submit_tag(cancel_name, options)
      wrapper("submit", nil, "", submit_button+cancel_button, options)
    end
    
    private
    def wrapper(type, field_name, label, field, options = {})
      help = %Q{<span class="help">#{options[:help]}</span>} if options[:help]
      to_return = []
      to_return << %Q{<div class="#{type}-field #{options[:class]}">}
      to_return << %Q{<label for="#{field_name}">#{label}#{help}</label>} unless ["radio","check", "submit"].include?(type)
      to_return << %Q{<div class="input">}
      to_return << field
      to_return << %Q{<label for="#{field_name}">#{label}</label>} if ["radio","check"].include?(type)    
      to_return << %Q{</div></div>}
    end
  end

  def labelled_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for( record_or_name_or_array, 
              *(args << options.merge(:builder => StandardFormBuilder)), &proc)
  end

  def labelled_fields_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    fields_for( record_or_name_or_array, 
                *(args << options.merge(:builder => LabelledFormBuilder)), &proc)
  end

end
