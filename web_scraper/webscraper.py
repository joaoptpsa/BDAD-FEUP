from random import randrange

import requests
import bs4
import sys
import re

website = 'http://int.soccerway.com'
mainpages = ['http://int.soccerway.com/national/germany/bundesliga/20162017/regular-season/r35823/']
session = requests.Session()


def get_team_links():
    team_links = []
    for mainpage in mainpages:
        page = session.get(mainpage, stream=True)
        html = bs4.BeautifulSoup(page.text, 'lxml')
        teams = html.select('.leaguetable.detailed-table .text.team a')

        for team in teams:
            str_list = [website, team['href']]
            team_href = ''.join(str_list)
            team_links.append(team_href)

    return team_links


def get_people_links(team_links):
    people_links = []
    for team_link in team_links:
        team_page = session.get(team_link, stream=True)
        team_html = bs4.BeautifulSoup(team_page.text, 'lxml')
        players = team_html.select('#page_team_1_block_team_squad_8 td div a')
        for player in players:
            str_list = [website, player['href']]
            player_href = ''.join(str_list)
            people_links.append(player_href)

    return people_links


def get_venue_links(team_links):
    venue_links = []
    for team_link in team_links:
        team_page = session.get(team_link, stream=True)
        team_html = bs4.BeautifulSoup(team_page.text, 'lxml')
        venue_link = team_html.select('#page_team_1_block_team_venue_4-wrapper a')[0]['href']
        venue_link_list = [website, venue_link]
        venue_link = ''.join(venue_link_list)
        venue_links.append(venue_link)
    return venue_links


def fix_country(country_name):
    if country_name == 'Netherlands':
        country_name = 'The Netherlands'
    elif country_name == 'Scotland' or country_name == 'England' or country_name == 'Wales' or country_name == 'Northern Ireland':
        country_name = 'United Kingdom'
    elif country_name == 'Korea Republic':
        country_name = 'South Korea'
    elif country_name == 'USA':
        country_name = 'United States'
    elif country_name == 'Russia':
        country_name = 'Russian Federation'
    elif country_name == 'FYR Macedonia':
        country_name = 'Macedonia'
    return country_name


def get_cities(team_links, player_links):
    cities_list = []
    cities_dic = {}
    city = ''
    country = ''

    # Team Pages
    for team_link in team_links:
        team_page = session.get(team_link, stream=True)
        team_html = bs4.BeautifulSoup(team_page.text, 'lxml')
        team_info = team_html.select('#page_team_1_block_team_info_3 dt')

        for info in team_info:
            if info.getText() == 'Address':
                city = info.find_next_sibling('dd').getText().strip().splitlines()[2].strip()

            if info.getText() == 'Country':
                country = info.find_next_sibling('dd').getText().strip()
                country = fix_country(country)

        if city == '':
            city = 'Unknown'

        country_id = str(countries.index(country) + 1)
        str_list = [country_id, ':', city]
        city = ''.join(str_list)
        cities_list.append(city)

    # Player Pages
    for player_link in player_links:
        player_page = session.get(player_link, stream=True)
        player_html = bs4.BeautifulSoup(player_page.text, 'lxml')
        player_infos = player_html.select('#page_player_1_block_player_passport_3 dt')

        for info in player_infos:
            if info.getText() == 'Place of birth':
                city = info.find_next_sibling('dd').getText().strip()
            elif info.getText() == 'Country of birth':
                country = info.find_next_sibling('dd').getText()
                country = fix_country(country)

        if city == '':
            city = 'Unknown'

        country_id = str(countries.index(country) + 1)
        str_list = [country_id, ':', city]
        city = ''.join(str_list)
        cities_list.append(city)
        city = ''

    cities_list = list(set(cities_list))

    for city in cities_list:
        city_info = city.split(':')
        country_id = city_info[0]
        city_name = city_info[1]
        if country_id in cities_dic:
            cities_dic[country_id].append(city_name)
        else:
            cities_dic[country_id] = [city_name]

    return cities_dic


def parse_date(date):
    date = date.strip().split()
    day = date[0].strip()
    month = date[1].strip()
    year = date[2].strip()

    if month == 'January':
        month = '01'
    elif month == 'February':
        month = '02'
    elif month == 'March':
        month = '03'
    elif month == 'April':
        month = '04'
    elif month == 'May':
        month = '05'
    elif month == 'June':
        month = '06'
    elif month == 'July':
        month = '07'
    elif month == 'August':
        month = '08'
    elif month == 'September':
        month = '09'
    elif month == 'October':
        month = '10'
    elif month == 'November':
        month = '11'
    elif month == 'December':
        month = '12'

    date_list = [year, '-', month, '-', day]
    date = ''.join(date_list)

    return date


def parse_weight(weight):
    return weight.split()[0].strip()


def parse_height(height):
    return height.split()[0].strip()


def parse_person_info(infos, person_role):
    person_data = {}

    first_name = ''
    last_name = ''
    date_of_birth = ''
    place_of_birth = ''
    country_of_birth = ''
    height = ''
    weight = ''
    foot = ''

    for info in infos:
        info_name = info.getText().strip()

        if info_name == 'First name':
            first_name = info.find_next_sibling('dd').getText().strip()

        elif info_name == 'Last name':
            last_name = info.find_next_sibling('dd').getText().strip()

        elif info_name == 'Date of birth':
            date_of_birth = info.find_next_sibling('dd').getText().strip()

        elif info_name == 'Place of birth':
            place_of_birth = info.find_next_sibling('dd').getText().strip()

        elif info_name == 'Country of birth':
            country_of_birth = info.find_next_sibling('dd').getText().strip()

        elif info_name == 'Height':
            height = info.find_next_sibling('dd').getText().strip()

        elif info_name == 'Weight':
            weight = info.find_next_sibling('dd').getText().strip()

        elif info_name == 'Position' and person_role == 'player':
            position = info.find_next_sibling('dd').getText().strip()
            if position == 'Goalkeeper':
                position = 'Guarda-Redes'
            elif position == 'Defender':
                position = 'Defesa'
            elif position == 'Midfielder':
                position = 'Medio'
            else:
                position = 'Avancado'
            person_data['position'] = position

        elif info_name == 'Foot' and person_role == 'player':
            foot = info.find_next_sibling('dd').getText().strip()
            if foot == 'Left':
                foot = 'Esquerdo'
            else:
                foot = 'Direito'

    name_list = [first_name, ' ', last_name]
    name = ''.join(name_list)
    person_data['name'] = name

    if date_of_birth != '':
        date_of_birth = parse_date(date_of_birth)
    else:
        date_of_birth = '1996-26-4'
    person_data['date_of_birth'] = date_of_birth

    if place_of_birth == '':
        place_of_birth = 'Unknown'

    country_of_birth = fix_country(country_of_birth)
    country_of_birth = countries.index(country_of_birth) + 1

    person_data['place_of_birth'] = place_of_birth
    person_data['country_of_birth'] = fix_country(country_of_birth)

    if height == '':
        height = '180'
    else:
        height = parse_height(height)
    person_data['height'] = height

    if weight == '':
        weight = '75'
    else:
        weight = parse_weight(weight)
    person_data['weight'] = weight

    if foot == '':
        foot = 'Direito'
    person_data['foot'] = foot
    return person_data


def get_people_data(people_links):
    people_data = []
    coach_link = ''.join([website, '/coaches'])
    player_link = ''.join([website, '/players'])

    for person_link in people_links:
        print(person_link)
        person_page = session.get(person_link, stream=True)
        person_html = bs4.BeautifulSoup(person_page.text, 'lxml')
        person_infos = person_html.select('#page_player_1_block_player_passport_3 dt')

        if person_link.startswith(coach_link):
            person_role = 'coach'
        else:
            person_role = 'player'

        person_team = person_html.select_one('.block_player_squad-wrapper h2 a').getText().strip()
        person_team = re.sub('\ Squad$', '', person_team).strip()
        person = parse_person_info(person_infos, person_role)
        person['role'] = person_role
        person['team'] = person_team

        people_data.append(person)

    return people_data


def get_stadia_data(venue_links):
    stadia_data = []

    for venue_link in venue_links:
        name = ''
        opening_year = ''
        address = ''
        capacity = ''
        city = ''
        stadium = {}
        venue_page = session.get(venue_link, stream=True)
        venue_html = bs4.BeautifulSoup(venue_page.text, 'lxml')
        venue_infos = venue_html.select('#page_team_1_block_venue_info_3-wrapper dt')
        name = venue_html.select_one('#page_team_1_block_venue_info_3-wrapper h2').getText().strip()
        for info in venue_infos:
            info_name = info.getText().strip()
            if info_name == 'Address:':
                address = info.find_next_sibling('dd').getText().strip()
            if info_name == 'City:':
                city = info.find_next_sibling('dd').getText().strip()
            if info_name == 'Opened:':
                opening_year = info.find_next_sibling('dd').getText().strip()
            if info_name == 'Capacity:':
                capacity = info.find_next_sibling('dd').getText().strip()

        stadium['name'] = name
        stadium['opening_year'] = opening_year
        stadium['address'] = address
        stadium['capacity'] = capacity
        stadium['city'] = city
        stadia_data.append(stadium)

    return stadia_data


def get_teams_data(team_links):
    teams_data = []

    for team_link in team_links:
        team = {}
        name = ''
        founded = ''
        stadium = ''

        team_page = session.get(team_link, stream=True)
        team_html = bs4.BeautifulSoup(team_page.text, 'lxml')
        name = team_html.select_one('#page_team_1_block_team_table_9-wrapper .highlight a')['title'].strip()
        founded = team_html.select('#page_team_1_block_team_info_3 dt + dd')[0].getText().strip()
        stadium = team_html.select('#page_team_1_block_team_venue_4 dt + dd')[0].getText().strip()

        team['name'] = name
        team['founded'] = founded
        team['stadium'] = stadium

        teams_data.append(team)

    return teams_data


def make_city_instructions(city_data):
    city_id = 1
    info = [[], []]
    city_instructions = info[0]
    city_list = info[1]

    for country_id in city_data:
        for city_name in city_data[country_id]:
            str_list = ['INSERT INTO Cidade (idCidade, nome, idPais) VALUES (', str(city_id), ",'", city_name, "',",
                        country_id, ');']
            ins_instruction = ''.join(str_list)

            city_list.append(city_name)
            city_id += 1
            city_instructions.append(ins_instruction)

    return info


def make_stadia_instructions(stadia_data):
    info = [[], []]
    stadia_instructions = info[0]
    stadia_list = info[1]
    stadium_id = 1

    for stadium_data in stadia_data:
        stadium_name = stadium_data['name']
        stadium_opening = stadium_data['opening_year']
        stadium_address = stadium_data['address']
        stadium_capacity = stadium_data['capacity']
        stadium_city = str(cities.index(stadium_data['city']) + 1)
        stadium_instruction_lst = [
            'INSERT INTO Estadio (idEstadio, nome, dataAbertura, morada, lotacao,idCidade) VALUES (',
            str(stadium_id), ",'", stadium_name, "','", stadium_opening, "','", stadium_address, "',",
            stadium_capacity, ',', stadium_city, ');']

        stadium_instruction = ''.join(stadium_instruction_lst)
        stadia_instructions.append(stadium_instruction)
        stadia_list.append(stadium_name)

        stadium_id += 1

    return info


def make_team_instructions(teams_data):
    info = [[], []]
    team_instructions = info[0]
    team_list = info[1]
    team_id = 1

    for team_data in teams_data:
        team_name = team_data['name']
        team_founded = team_data['founded']
        team_stadium = str(stadia.index(team_data['stadium']) + 1)

        team_instruction_lst = ['INSERT INTO Equipa (idEquipa, nome, dataFundacao, idEstadio) VALUES (',
                                str(team_id), ",'", team_name, "','", team_founded, "',", team_stadium, ');']
        team_instruction = ''.join(team_instruction_lst)

        team_list.append(team_name)
        team_instructions.append(team_instruction)

        team_id += 1

    return info


def make_people_instructions(people_data):
    instructions = [[], [], [], [], []]
    people_instructions = instructions[0]
    player_instructions = instructions[1]
    staff_instructions = instructions[2]
    player_contract_instructions = instructions[3]
    staff_contract_instructions = instructions[4]
    person_id = 1

    for person in people_data:
        person_name = person['name']
        person_dob = person['date_of_birth']
        person_city = str(cities.index(person['place_of_birth']) + 1)
        person_height = person['height']
        person_weight = person['weight']
        person_team = str(teams.index(person['team']) + 1)
        person_instruction_lst = ['INSERT INTO Pessoa (idPessoa, nome, dataNascimento, altura, peso, idCidadeNasc)'
                                  ' VALUES (', str(person_id), ",'", person_name, "','", person_dob, "',",
                                  person_height,
                                  ',', person_weight, ',', person_city, ');']

        person_instruction = ''.join(person_instruction_lst)
        people_instructions.append(person_instruction)

        contract_id = randrange(1, 5)

        if person['role'] == 'player':
            person_position = person['position']
            person_foot = person['foot']
            player_instruction_lst = ['INSERT INTO Jogador (idPessoa, posicaoPref, pePref) VALUES (', str(person_id),
                                      ",'",
                                      person_position, "','", person_foot, "');"]

            player_contract_instruction_lst = ['INSERT INTO ContratoJogador (idContrato, idJogador, idEquipa) VALUES (',
                                               str(contract_id), ',', str(person_id), ',', person_team, ');']

            player_instruction = ''.join(player_instruction_lst)
            player_contract_instruction = ''.join(player_contract_instruction_lst)
            player_instructions.append(player_instruction)
            player_contract_instructions.append(player_contract_instruction)

        elif person['role'] == 'coach':
            staff_instruction_lst = ['INSERT INTO Staff (idPessoa) VALUES (', str(person_id), ');']
            staff_contract_instruction_lst = [
                'INSERT INTO ContratoStaff (idContrato, idStaff, idEquipa, idFuncao) VALUES (',
                str(contract_id), ',', str(person_id), ',', person_team, ',', '1', ');']

            staff_instruction = ''.join(staff_instruction_lst)
            staff_contract_instruction = ''.join(staff_contract_instruction_lst)
            staff_instructions.append(staff_instruction)
            staff_contract_instructions.append(staff_contract_instruction)

        person_id += 1

    return instructions


countries = []
countriesFile = open('../Data lists/paises.csv')
for line in countriesFile:
    countries.append(line.strip())

outputFile = open('scraped_data.sql', 'w')

gameData = {}

teamLinks = get_team_links()
print('Fetched team links')

venueLinks = get_venue_links(teamLinks)
print('Fetched venue links')

peopleLinks = get_people_links(teamLinks)
print('Fetched people links')

cities = get_cities(teamLinks, peopleLinks)
print('Fetched city data')

peopleData = get_people_data(peopleLinks)
print('Fetched people data')

stadiaData = get_stadia_data(venueLinks)
print('Fetched stadia data')

teamsData = get_teams_data(teamLinks)
print('Fetched teams data')

# Cities
cityInstructions = make_city_instructions(cities)
cities = cityInstructions[1]
cityInstructions = cityInstructions[0]

outputFile.write('--Cidade\n')
for instruction in cityInstructions:
    outputFile.write(instruction)
    outputFile.write('\n')

# Stadia
stadiaInstructions = make_stadia_instructions(stadiaData)
stadia = stadiaInstructions[1]
stadiaInstructions = stadiaInstructions[0]

outputFile.write('\n--Estadio\n')
for instruction in stadiaInstructions:
    outputFile.write(instruction)
    outputFile.write('\n')

# Teams
teamInstructions = make_team_instructions(teamsData)
teams = teamInstructions[1]
teamInstructions = teamInstructions[0]

outputFile.write('\n--Equipa\n')
for instruction in teamInstructions:
    outputFile.write(instruction)
    outputFile.write('\n')

# People, Players and Staff and Contracts
peopleInstructions = make_people_instructions(peopleData)
playerInstructions = peopleInstructions[1]
staffInstructions = peopleInstructions[2]
playerContractInstructions = peopleInstructions[3]
staffContractInstructions = peopleInstructions[4]
peopleInstructions = peopleInstructions[0]

outputFile.write('\n--Pessoa\n')
for personInstruction in peopleInstructions:
    outputFile.write(personInstruction)
    outputFile.write('\n')

outputFile.write('\n--Jogador\n')
for playerInstruction in playerInstructions:
    outputFile.write(playerInstruction)
    outputFile.write('\n')

outputFile.write('\n--Staff\n')
for staffInstruction in staffInstructions:
    outputFile.write(staffInstruction)
    outputFile.write('\n')

outputFile.write('\n--ContratoJogador\n')
for instruction in playerContractInstructions:
    outputFile.write(instruction)
    outputFile.write('\n')

outputFile.write('\n--ContratoStaff\n')
for instruction in staffContractInstructions:
    outputFile.write(instruction)
    outputFile.write('\n')
