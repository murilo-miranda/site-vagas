require 'rails_helper'

feature 'User sign' do
  scenario 'successfully' do
    collaborator = User.create!(email: 'murilo@campuscode',
                                password: '123456')

    visit root_path
    click_on 'Entrar' #Sign in
    fill_in 'user[email]', with: collaborator.email
    fill_in 'user[password]', with: collaborator.password
    click_on 'Log in'

    expect(page).to have_content 'Login efetuado com sucesso!' #i18n
    expect(page).to have_content collaborator.email
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar' #i18n
  end

  scenario 'unsuccessfully - blank field' do

    visit root_path
    click_on 'Entrar'
    click_on 'Log in'

    expect(page).to have_content 'E-mail ou senha inválida.' #I18n
    expect(page).to have_link 'Entrar' #I18n
  end
end