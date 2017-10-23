require 'rails_helper'

RSpec.describe 'hyrax/base/_form_metadata.html.erb', type: :view do
  let(:ability) { double }
  let(:work) { FactoryGirl.build(:etd) }
  let(:form) { Hyrax::EtdForm.new(work, ability, controller) }

  let(:form_template) do
    %(
      <%= simple_form_for [main_app, @form] do |f| %>
        <%= render "hyrax/base/form_metadata", f: f %>
      <% end %>
     )
  end

  let(:page) do
    assign(:form, form)
    render inline: form_template
    Capybara::Node::Simple.new(rendered)
  end

  it "renders the additional fields button" do
    expect(page).to have_content('Additional fields')
  end

  describe 'form fields' do
    it 'has titles' do
      expect(page)
        .to have_multivalued_field(:title)
        .on_model(work.class)
        .with_label 'Title'
    end

    it 'has keywords' do
      expect(page)
        .to have_multivalued_field(:keyword)
        .on_model(work.class)
        .with_label 'Keyword'
    end

    it 'has resource_types' do
      expect(page)
        .to have_multivalued_field(:resource_type)
        .on_model(work.class)
        .with_label('Resource type')
        .and_options('article', 'capstone', 'dissertation', 'portfolio', 'thesis')
    end
  end
end
