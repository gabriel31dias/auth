require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example) # Assume que você tem um usuário de exemplo nos fixtures
  end

  test 'should get new' do
    get login_path
    assert_response :success
  end

  test 'should log in with valid credentials' do
    post login_path, params: { username: @user.username, password: 'password' }
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'p', 'Logado com sucesso!'
  end

  test 'should not log in with invalid credentials' do
    post login_path, params: { username: @user.username, password: 'wrong_password' }
    assert_template 'sessions/new'
    assert_select 'div.alert', 'Usuário ou senha incorretos.'
  end

  test 'should log out' do
    delete logout_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'p', 'Deslogado com sucesso!'
  end
end
