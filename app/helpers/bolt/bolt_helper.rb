module Bolt
  module BoltHelper
    
    def bolt_get_version_info  
      YAML::load_file File.join(File.dirname(__FILE__), '..', '..', '..', 'PUBLIC_VERSION.yml')
    end
    
    def bolt_get_full_version_string
      version_info = bolt_get_version_info
      "v.#{version_info['major']}.#{version_info['minor']}.#{version_info['patch']}"
    end
    
    def bolt_get_short_version_string
      version_info = bolt_get_version_info
      "v.#{version_info['major']}"
    end
    
    def bolt_generate_page_title
      
      if @bolt_page_title.nil?
        return bolt_config_website_name
      end
      
      @bolt_page_title + " > " + bolt_config_website_name
    end
    
    def bolt_get_access_level_text level
      case level
      when $BOLT_USER_ACCESS_LEVEL_ADMIN
        return "Administrator"
      when $BOLT_USER_ACCESS_LEVEL_USER
        return "User"
      when $BOLT_USER_ACCESS_LEVEL_TO_API 
        return "API User"
      when $BOLT_USER_ACCESS_LEVEL_TO_CMS
        return "CMS USER"
      when $BOLT_USER_ACCESS_LEVEL_TO_API_AND_CMS
        return "CMS and API user"
      when $BOLT_ACCESS_NONE
        return "Ignored"
      else
        return "Unknown"
      end
    end
    
    def bolt_get_access_level_array
      [["Administrator", $BOLT_USER_ACCESS_LEVEL_ADMIN], ["User", $BOLT_USER_ACCESS_LEVEL_USER], ["API user", $BOLT_USER_ACCESS_LEVEL_TO_API], ["CMS user", $BOLT_USER_ACCESS_LEVEL_TO_CMS], ["CMS and API User",$BOLT_USER_ACCESS_LEVEL_TO_API_AND_CMS], ["Ignore User", $BOLT_ACCESS_NONE]]
    end
    
    def bolt_table_cell_link contents, link, options = {}
      
      if options.key? :bolt_truncate
        contents = truncate(contents, :length => options[:bolt_truncate], :omission => "...")
      end
      
      link_to "#{contents}".html_safe, link, options
    end
    
    def bolt_table_cell_no_link contents, options = {}
      
      if options.key? :bolt_truncate
        contents = truncate(contents, :length => options[:bolt_truncate], :omission => "...")
      end
      
      "<div class='noLink'>#{contents}</div>".html_safe
    end
    
    def bolt_show_icon icon_name
      "<div class='icon'><img src='/bolt/images/icons/#{icon_name}.png' alt='' /></div>".html_safe
    end
    
    def bolt_show_row_icon icon_name
      "<div class='iconRow'><img src='/bolt/images/icons/#{icon_name}.png' alt='' /></div>".html_safe
    end
    
    # Styled form tag helpers
    
    def bolt_text_field form, obj, attribute, options = {}
      bolt_form_tag_wrapper(form.text_field(attribute, strip_bolt_options(options_hash_with_merged_classes(options, 'boltTextField'))), form, obj, attribute, options).html_safe
    end
    
    def bolt_password_field form, obj, attribute, options = {}
      bolt_form_tag_wrapper(form.password_field(attribute, strip_bolt_options(options_hash_with_merged_classes(options, 'boltTextField'))), form, obj, attribute, options).html_safe
    end
    
    def bolt_text_area form, obj, attribute, options = {}
      bolt_form_tag_wrapper(form.text_area(attribute, strip_bolt_options(options_hash_with_merged_classes(options, 'boltTextArea'))), form, obj, attribute, options).html_safe
    end
    
    def bolt_text_area_big form, obj, attribute, options = {}
      bolt_form_tag_wrapper(form.text_area(attribute, strip_bolt_options(options_hash_with_merged_classes(options, 'boltTextAreaBig'))), form, obj, attribute, options).html_safe
    end
    
    def bolt_check_box form, obj, attribute, options = {}
      form_tag = form.check_box(attribute, strip_bolt_options(options))
      
      if options.key? :bolt_box_label
        form_tag = "<div>" + form_tag + "<span class=\"rcText\">#{options[:bolt_box_label]}</span></div>".html_safe
      end
      
      bolt_form_tag_wrapper(form_tag, form, obj, attribute, options).html_safe
    end
    
    def bolt_check_box_group form, obj, check_boxes = {}
      form_tags = ""
      
      for check_box in check_boxes
        form_tags += bolt_check_box form, obj, check_box[0], check_box[1]
      end
      
      bolt_form_tag_wrapper form_tag, form, obj, attribute, options
    end
    
    def bolt_radio_button form, obj, attribute, tag_value, options = {}
      form_tag = form.radio_button(obj, attribute, tag_value, strip_bolt_options(options))
      
      if options.key? :bolt_button_label
        form_tag = "<div>" + form_tag + "<span class=\"rcText\">#{options[:bolt_button_label]}</span></div>".html_safe
      end
      
      bolt_form_tag_wrapper(form_tag, form, obj, attribute, options).html_safe
    end
    
    def bolt_radio_button_group form, obj, radio_buttons = {}
      form_tags = ""
      
      for radio_button in radio_buttons
        form_tags += bolt_radio_button form, obj, check_box[0], check_box[1], check_box[2]
      end
      
      bolt_form_tag_wrapper(form_tag, form, obj, attribute, options).html_safe
    end
    
    def bolt_select form, obj, attribute, option_tags, options = {}
      bolt_form_tag_wrapper(form.select(attribute, option_tags, strip_bolt_options(options), merged_class_hash(options, 'boltSelect')), form, obj, attribute, options).html_safe
    end
    
    def bolt_time_zone_select form, obj, attribute, option_tags, options = {}
      bolt_form_tag_wrapper(form.time_zone_select(attribute, option_tags, strip_bolt_options(options), merged_class_hash(options, 'boltSelect')), form, obj, attribute, options).html_safe
    end
    
    def bolt_collection_select form, obj, object, attribute, collection, value_method, text_method, options = {}
      bolt_form_tag_wrapper(collection_select(object, attribute, collection, value_method, text_method, strip_bolt_options(options), merged_class_hash(options, 'boltSelect')), form, obj, attribute, options).html_safe
    end
    
    def bolt_date_select form, obj, attribute, options = {}
      bolt_form_tag_wrapper(form.date_select(attribute, strip_bolt_options(options), merged_class_hash(options, 'boltDateTimeSelect')), form, obj, attribute, options).html_safe
    end

    def bolt_time_select form, obj, attribute, options = {}
      bolt_form_tag_wrapper(form.time_select(attribute, strip_bolt_options(options), merged_class_hash(options, 'boltDateTimeSelect')), form, obj, attribute, options).html_safe
    end
    
    def bolt_datetime_select form, obj, attribute, options = {}
      bolt_form_tag_wrapper(form.datetime_select(attribute, strip_bolt_options(options), merged_class_hash(options, 'boltDateTimeSelect')), form, obj, attribute, options).html_safe
    end
    
    def bolt_file_field form, obj, object_name, attribute, options = {}
      class_hash = merged_class_hash(options, 'boltFileFieldContainer')
      contents = "<div class='#{class_hash[:class]}'>" + file_field(object_name, attribute, strip_bolt_options(options)) + '</div>'
      bolt_form_tag_wrapper(contents, form, obj, attribute, options).html_safe
    end
    
    def bolt_hidden_field form, obj, attribute, options = {}
      form.hidden_field(attribute, strip_bolt_options(options)).html_safe
    end
    
    protected

    def strip_bolt_options options
      options.reject {|key, value| key.to_s.include? "bolt_" }
    end
    
    def merged_class_hash options, new_class
      if options.key? :class
        new_class += " #{options[:class]}"
      end
      
      {:class => new_class}
    end
    
    def options_hash_with_merged_classes options, new_class
      if options.key? :class
        new_class += " #{options[:class]}"
      end
      options[:class] = new_class
      options
    end

    def bolt_form_tag_wrapper form_tag, form, obj, attribute, options = {}
      unless options.key? :bolt_label
        human_attribute_name = attribute.to_s.humanize
      else
        human_attribute_name = options[:bolt_label]
      end
      
      html = "<p>"
      
      if obj && obj.errors[attribute].any?
        html += "<span class='formError'>#{human_attribute_name} #{obj.errors[attribute].first}</span>".html_safe
      else
        html += form.label(attribute, human_attribute_name)
      end
      
      html += "</p>\n<p>#{form_tag}</p>"
    end
  end
end
