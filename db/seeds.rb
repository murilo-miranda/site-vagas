# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

muzak_company = Company.create!(name: 'Muzak', address: 'Santana',
                cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')

kaiba_corp = Company.create!(name: 'Kaiba Corp', address: 'Domino City',
                cnpj: '01.234.567/0001-80', site: 'www.kaibacorp.com.br')
kaiba_corp.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'kc.jpg')),
                filename: 'kc.jpg')

Vacancy.create!(name: 'Programador Ruby',
                description: 'Possuimos sistemas legados e estamos'\
                ' a procura de programadores que nos ajudem a '\
                'fazer a transição para o novo rails 6.0',
                salary: 4000,
                job_title: 'Pleno',
                mandatory_requirements: 'Conhecimento de Rails '\
                'e 3 anos de experiência em desenvolvimento',
                expiration_date: '20/03/2021', max_vacancies: 5,
                company: muzak_company)

Vacancy.create!(name: 'Programador Ruby',
                description: 'Buscamos desenvolvedor Ruby interessado em ' \
                'consolidar seus conhecimentos em programação Ruby para ' \
                'integrar nossa equipe.',
                salary: 2500,
                job_title: 'Júnior',
                mandatory_requirements: 'Experiência com desenvolvimento web '\
                'usando Ruby on Rails. BDD + Rspec. Javascript. Git.',
                expiration_date: '20/03/2021', max_vacancies: 5,
                company: muzak_company)

Vacancy.create!(name: 'Duel Disk connection',
                description: 'Kaiba Corp é conhecida pelo seu produto Duel Disk'\
                ' , e estamos a procura de programadores para integrar nosso '\
                'produto com os nossos parceiros.',
                salary: 4500,
                job_title: 'Pleno',
                mandatory_requirements: 'Conhecimentos em API e nosso querido '\
                'produto.',
                expiration_date: '20/03/2021', max_vacancies: 3,
                company: kaiba_corp)

User.create!(email: 'murilo@muzak.com', password: '123456')

User.create!(email: 'seto@kaiba.com', password: '123456')

User.create!(email: 'murilo@gmail.com', password: '123456')