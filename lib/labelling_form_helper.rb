ActionView::Base.field_error_proc = proc { |input, instance| input }

class LabellingFormBuilder < ActionView::Helpers::FormBuilder

  @@_name_id_counter = 0

  def initialize(*a, &b)
    @@_name_id_counter += 1
    super(*a, &b)
  end

  def text_field(name, opts={})
    opts[:id] ||= "#{idize object_name}_#{name}"
    p_opts = extract_p_opts(opts)
    add_class(p_opts, "text")
    p(name, super(name, opts), p_opts)
  end

  def text_area(name, opts={})
    opts[:id] ||= "#{idize object_name}_#{name}"
    p_opts = extract_p_opts(opts)
    add_class(p_opts, "textarea")
    p(name, super(name, opts), p_opts)
  end

  def check_box(name, opts={})
    opts[:id] ||= "#{idize object_name}_#{name}"
    p_opts = extract_p_opts(opts)
    add_class(p_opts, "checkbox")
    p(name, super(name, opts), p_opts)
  end

  def submit_tag(value, opts={})
    p_opts = extract_p_opts(opts)
    tag('p', tag('input', opts.merge(:value => value, :type => 'submit')), {:class => 'button'}.merge(p_opts))
  end
  
  def file_field(name, opts={})
    opts[:id] ||= "#{idize object_name}_#{name}"
    p_opts = extract_p_opts(opts)
    add_class(p_opts, "file")
    p(name, super(name, opts), p_opts)
  end
  
  def password_field(name, opts={})
    opts[:id] ||= "#{idize object_name}_#{name}"
    p_opts = extract_p_opts(opts)
    add_class(p_opts, "password")
    p(name, super(name, opts), p_opts)
  end

  def select(name, choices, opts={}, html_opts={})
    html_opts[:id] ||= "#{idize object_name}_#{name}"
    p_opts = extract_p_opts(opts)
    add_class(p_opts, "select")
    add_class(p_opts, "multiple") if html_opts[:multiple]
    p(name, super(name, choices, opts, html_opts), p_opts)
  end

  def date_select(name, opts={}, html_opts={})
    opts[:id] ||= "#{idize object_name}_#{name}"
    p_opts = extract_p_opts(opts)
    add_class(p_opts, "select-date")
    p(name, super(name, opts, html_opts), p_opts)
  end
  
  def submit(value='Save', opts={})
    if opts.delete(:label)
      p_opts = extract_p_opts(opts)
      p('submit', super(value, opts), {:class => 'submit button'}.merge(p_opts))
    else
      tag('p', super(value, opts), :class => 'submit button')
    end
  end

  alias default_fields_for fields_for

  def fields_for(*a, &b)
    options = a.last.is_a?(Hash) ? a.pop : {}

    options.reverse_merge!(
      :builder => LabellingFormBuilder
    )

    super(*(a << options), &b)
  end

  def next
    @@_name_id_counter += 1
  end


  private

    def extract_p_opts(opts)
      p_opts = opts.delete(:p) || {}
      p_opts[:label] = opts.delete(:label)
      p_opts[:class] = p_opts[:class].blank? ? "required" : "#{p_opts[:class]} required" if opts.delete(:required)
      p_opts[:opts] = opts
      p_opts
    end

    def p(name, content, opts={})
      name = name.to_s
      label = opts.delete(:label)
      label ||= object.class.human_attribute_name(name)
      optz = opts.delete(:opts) || {}
      opts[:class] = "#{opts[:class].blank? ? '' : opts[:class]+' '}error" if object.errors.on(name)
      tag('p', tag('label', label, :for => optz[:id] || "#{idize object_name}_#{name}") + content, opts)
    end

    def add_class(opts, class_name)
      opts[:class] = opts[:class].blank? ? class_name : "#{opts[:class]} #{class_name}"
    end

    def tag(name, *args, &b)
      MyOwnFreakingBuilderThatDoesntRelyOnMethodMissing.new.tag!(name, *args, &b)
    end

    #foo[bar][baz][] => foo_bar_baz_1
    def idize(s)
      "#{s}".gsub(/\[([^\[]+)\]/, '_\1').gsub(/\[\]/, "_#{@@_name_id_counter}")
    end

end

class MyOwnFreakingBuilderThatDoesntRelyOnMethodMissing

  def tag!(name, *opts, &b)
    attrs = opts.last.is_a?(Hash) ? opts.pop : {}
    t = "<#{name}"
    t << (attrs.empty? ? '' : ' '+attrs.map{|k,v| "#{__h k}=\"#{__h v}\"" }.join(' '))
    if opts.first
      t << ">#{opts.first}<\/#{name}>"
    elsif block_given?
      t << ">#{yield}<\/#{name}>"
    else
      t << '/>'
    end

    t
  end

  private

    def method_missing(*what, &ever)
      tag!(*what, &ever)
    end

    def __h(html)
      "#{html}".gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;').gsub(/"|'/, '&quot;')
    end

end
