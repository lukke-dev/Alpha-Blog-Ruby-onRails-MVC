require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test 'get new category form and reject invalida category submission' do
    get '/categories/new'
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: ' ' } }
    end
    assert_match 'erros', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
