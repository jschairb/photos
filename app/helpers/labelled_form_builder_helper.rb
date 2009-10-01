module LabelledFormBuilderHelper
      [ :form_for, :fields_for ].each do |method|
      code = <<-END
        def labelled_#{method}(name, *args, &block)
          options = args.extract_options!
          options[:html] ||= {}
          class_names = options[:html][:class] ? options[:html][:class].split(" ") : []
          class_names << "standard"
          options[:html][:class] = class_names.join(" ")
          options = options.merge(:builder => LabelledFormBuilder)
          #{method}(name, *(args << options), &block)
        end
      END
      module_eval code, __FILE__, __LINE__
    end
  class LabelledFormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    
    def check_box(method, options={}, checked_value = "1", unchecked_value = "0")
      order = [:field, :label, :errors]
      wrapper(method, options.merge(:container_class => "checkbox"), order) do |modified_options|
        super(method, modified_options, checked_value, unchecked_value)
      end
    end

    # TODO: add submit to formbuilder
    # def submit()
    # end

    def text_field(method, options={})
      wrapper(method, options) do |modified_options|
        super(method, modified_options)
      end
    end

    def text_area(method, options={})
      wrapper(method, options) do |modified_options|
        super(method, modified_options)
      end
    end

    def password_field(method, options = {})
      wrapper(method, options) do |modified_options|
        super(method, modified_options)
      end
    end

    def select(method, choices, options = {}, html_options = {})
      wrapper(method, options) do |modified_options|
        super(method, choices, modified_options, html_options)
      end
    end
    
    def date_select(method, options = {}, html_options = {})
      wrapper(method, options) do |modified_options|
        super(method, modified_options, html_options)
      end
    end

    def datetime_select(method, options = {}, html_options = {})
      wrapper(method, options) do |modified_options|
        super(method, modified_options, html_options)
      end
    end

    def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
      wrapper(method, options) do |modified_options|
        super(method, collection, value_method, text_method, modified_options, html_options)
      end
    end

    def fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      super record_or_name_or_array, *(args << options.merge(:builder => LabelledFormBuilder)), &block
    end

    private

    def build_container_options(method, options)
      # TODO: josh change to css pseudo selector
      first = options.delete(:first) ? "first" : nil

      css_classes = ["input", options.delete(:container_class), first].compact.join(' ')
      {:id => "#{to_id(@object_name, method)}_container", :class => css_classes}
    end

    def build_errors(method, options)
      unless options.delete(:no_errors)
        error_obj = @object.is_a?(Array) ? @object.last : @object
        @template.error_message_on(error_obj, method, options)
      else
        ''
      end
    end
    
    def build_help(options)
      if options[:help]
        content_tag(:div, options[:help], :class=> "help")
      end
    end

    def build_label(method, options)
      if (options.has_key?(:label) && options[:label]) || !options.has_key?(:label)
        label(method, options[:label])
      else 
        nil
      end
    end

    def build_required(options)
      options[:required] ? content_tag(:span, "required", :class => "required") : nil
    end

    DEFAULT_TAG_ORDER = [:help, :label, :field, :required, :errors]

    def cat_tags(tags, order)
      tag_order = order || DEFAULT_TAG_ORDER
      tag_order.map{ |tag| tags[tag] }.compact.join
    end

    def wrapper(method, options, order=nil)
      # TODO: JOSH add help text
      tags = {}
      options = options.dup

      container_options = build_container_options(method, options)

      tags[:help]     = build_help(options)
      tags[:required] = build_required(options)
      tags[:label]    = build_label(method, options)
      tags[:errors]   = build_errors(method, options)

      %w(required first label help).each { |opt| options.delete(opt.intern) }

      tags[:field]    = yield options

      content_tag(:div, cat_tags(tags, order), container_options)
    end

    def to_id(obj, meth)
      "#{obj}_#{meth}".gsub(/[\[\]]/, '_').squeeze('_')
    end
  end
end
