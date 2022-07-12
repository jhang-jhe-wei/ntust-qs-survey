# frozen_string_literal: true

class RecommenderFormBuilder < ActionView::Helpers::FormBuilder
  def text_with_label_field(attribute, options = {})
    label(attribute, class: 'recommender-form-label') +
      text_field(attribute, {
        required: true,
        class: 'recommender-form-input',
        pattern: '[A-Za-z0-9. ,_-]*',
        title: '限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。'
      }.merge(options))
  end
end
