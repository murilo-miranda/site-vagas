require 'rails_helper'

feature 'User create account' do
  scenario 'successfully' do
    collaborator = User.new(email: 'murilo@campuscode',
                                password: '123456')

    visit root_path
    click_on 'Registrar-se'
    fill_in 'user[email]', with: collaborator.email
    fill_in 'user[password]', with: collaborator.password
    fill_in 'user[password_confirmation]', with: collaborator.password
    click_on 'Sign up'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content collaborator.email
    expect(page).to have_link 'Sair'
  end

  scenario 'unsuccessfully - blank field' do

    visit root_path
    click_on 'Entrar'
    click_on 'Registrar-se'
    click_on 'Sign up'

    expect(page).to have_content 'Não foi possível salvar usuário: 2 erros' #I18n
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    click_on 'Sign up'
  end
end