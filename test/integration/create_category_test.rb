require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: 'esportes')
    @admin = User.create(username: 'lucas', email: 'lucas10@gmail.com', password: '101010e', admin: true)
  end

  test 'get new category form and reject invalida category submission' do
    sign_in_as(@admin)
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
