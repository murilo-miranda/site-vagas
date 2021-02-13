require 'rails_helper'

feature 'User create account' do
  scenario 'successfully' do
    user = User.new(email: 'murilo@campuscode',
                                password: '123456')

    visit root_path
    click_on 'Registrar-se'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    click_on 'Cadastre-se'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content user.email
    expect(page).to have_link 'Sair'
  end

  scenario 'unsuccessfully - blank field' do

    visit root_path
    click_on 'Registrar-se'
    click_on 'Cadastre-se'

    expect(page).to have_content 'Não foi possível salvar usuário: 2 erros' #I18n
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end
end