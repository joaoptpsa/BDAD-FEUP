import webbrowser
import requests
import bs4
import sql

website = 'http://int.soccerway.com'
mainpage = 'http://int.soccerway.com/national/germany/bundesliga/20162017/regular-season/r35823/'
session = requests.Session()


def get_team_links():
    team_links = []
    page = session.get(mainpage)
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
        team_page = session.get(team_link)
        team_html = bs4.BeautifulSoup(team_page.text, 'lxml')
        players = team_html.select('#page_team_1_block_team_squad_8 td div a')
        for player in players:
            str_list = [website,player['href']]
            player_href = ''.join(str_list)
            people_links.append(player_href)

    return people_links


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
    city = ''
    country = ''

    # Team Pages
    for team_link in team_links:
        team_page = session.get(team_link)
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
        print(player_link)
        player_page = session.get(player_link)
        player_html = bs4.BeautifulSoup(player_page.text, 'lxml')
        player_infos = player_html.select('#page_player_1_block_player_passport_3 dt')

        for info in player_infos:
            if info.getText() == 'Place of birth':
                city = info.find_next_sibling('dd').getText()
            elif info.getText() == 'Country of birth':
                country = info.find_next_sibling('dd').getText()
                country = fix_country(country)

        if city == '':
            city = 'Unknown'

        country_id = str(countries.index(country) + 1)
        str_list = [country_id, ':', city]
        city = ''.join(str_list)
        cities_list.append(city)

    return list(set(cities_list))


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

    date_list = [year, '-', month, '-', year]
    date = ''.join(date_list)

    return date


def parse_weight(weight):
    return weight.split()[0].strip()


def parse_height(height):
    return height.split()[0].strip()


def parse_person_info(infos):
    person_data = {}

    first_name = ''
    last_name = ''
    date_of_birth = ''
    place_of_birth = ''
    country_of_birth = ''
    height = ''
    weight = ''

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

    name_list = [first_name, ' ', last_name]
    name = ''.join(name_list)
    person_data['name'] = name

    if date_of_birth != '':
        date_of_birth = parse_date(date_of_birth)
    else: date_of_birth = '1996-26-4'
    person_data['date_of_birth'] = date_of_birth

    if place_of_birth == '':
        place_of_birth = 'Unknown'
    person_data['place_of_birth'] = place_of_birth
    person_data['country_of_birth'] = fix_country(country_of_birth)

    if height == '':
        height = '180'
    else: height = parse_height(height)
    person_data['height'] = height

    if weight == '':
        weight = '75'
    else:weight = parse_weight(weight)
    person_data['weight'] = weight

    print(person_data)

    return person_data


def get_people_data(people_links):
    people_data = []

    for person_link in people_links:
        person = {}
        person_page = session.get(person_link)
        person_html = bs4.BeautifulSoup(person_page.text, 'lxml')
        person_infos = person_html.select('#page_player_1_block_player_passport_3 dt')
        person = parse_person_info(person_infos)

    return people_data


countries = []
countriesFile = open('../Data lists/paises.csv')
for line in countriesFile:
    countries.append(line.strip())

citiesInstructions = []
peopleInstructions = []
stadiaInstructions = []
teamInstructions = []
contractInstructions = []
playerContractInstructions = []
staffContractInstructions = []
playerInstructions = []
staffInstructions = []
playersData = {}
staffData = {}
refereesData = {}
stadiaData = {}
teamsData = {}
gameData = {}

teamLinks = get_team_links()
print('Fetched team links')

peopleLinks = get_people_links(teamLinks)
print('Fetched people links')

# cities = get_cities(teamLinks, peopleLinks)
peopleData = get_people_data(peopleLinks)
