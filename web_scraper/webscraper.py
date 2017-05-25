import webbrowser, requests, bs4, sql

website = 'http://int.soccerway.com'
mainpage = 'http://int.soccerway.com/national/germany/bundesliga/20162017/regular-season/r35823/'
session = requests.Session()
# print(html.prettify())
# print(len(teams))

countries = []
countriesFile = open('../Data lists/paises.csv')
for line in countriesFile:
    countries.append(line.strip())

citiesData = {}
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
cities = []


def get_team_links():
    team_links = []
    page = session.get(mainpage)
    html = bs4.BeautifulSoup(page.text, 'lxml')
    teams = html.select('.leaguetable.detailed-table .text.team a')

    for team in teams:
        team_href = website + team['href']
        team_links.append(team_href)

    return team_links


def get_player_links(team_links):
    player_links = []
    for team_link in team_links:
        team_page = session.get(team_link)
        team_html = bs4.BeautifulSoup(team_page.text,'lxml')
        players = team_html.select('#page_team_1_block_team_squad_8 td div a')
        for player in players:
            player_href = website + player['href']
            player_links.append(player_href)

    return player_links


teamLinks = get_team_links()
playerLinks = get_player_links(teamLinks)

print(teamLinks)
print(playerLinks)



#     teamPage = session.get(teamHref)
#     teamHtml = bs4.BeautifulSoup(teamPage.text, 'lxml')
#     players = teamHtml.select('#page_team_1_block_team_squad_8 td div a')
#
#     for player in players:
#         playerHref = website + player['href']
#         playerPage = session.get(playerHref)
#         playerHtml = bs4.BeautifulSoup(playerPage.text, 'lxml')
#         infoTitles = playerHtml.select('#page_player_1_block_player_passport_3 dt')
#         city = ''
#         countryOfBirth = ''
#
#         for title in infoTitles:
#             if title.getText() == 'Place of birth':
#                 city = title.find_next_sibling('dd').getText()
#
#             # Mapping to what is on the database
#             elif title.getText() == 'Country of birth':
#                 countryOfBirth = title.find_next_sibling('dd').getText()
#                 if countryOfBirth == 'Netherlands':
#                     countryOfBirth = 'The Netherlands'
#                 elif countryOfBirth == 'Scotland' or countryOfBirth == 'England' or countryOfBirth == 'Wales' or countryOfBirth == 'Northern Ireland':
#                     countryOfBirth = 'United Kingdom'
#                 elif countryOfBirth == 'Korea Republic':
#                     countryOfBirth = 'South Korea'
#                 elif countryOfBirth == 'USA':
#                     countryOfBirth = 'United States'
#                 elif countryOfBirth == 'Russia':
#                     countryOfBirth = 'Russian Federation'
#                 elif countryOfBirth == 'FYR Macedonia':
#                     countryOfBirth = 'Macedonia'
#
#         countryId = str(countries.index(countryOfBirth) + 1)
#         if city == '':
#             city = 'Unknown'
#         city = countryId + ':' + city
#         cities.append(city)
#
#     teamInfo = teamHtml.select('#page_team_1_block_team_info_3 dt')
#     for info in teamInfo:
#         if info.getText() == 'Address':
#             address = info.find_next_sibling('dd').getText().strip().splitlines()[0].strip()
#             clubCity = info.find_next_sibling('dd').getText().strip().splitlines()[2].strip()
#             print(address)
#             print(clubCity)
#         if info.getText() == 'Country':
#             clubCountry = info.find_next_sibling('dd').getText().strip()
#             print(clubCountry)
#
#     break
#
# cities = list(set(cities))
# print(cities)
# for city in cities:
#     countryId = city.split(':')[0]
#     print(countryId)
#     cityName = city.split(':')[1]
#     print(cityName)
#     if countryId in citiesData:
#         citiesData[countryId].append(cityName)
#     else:
#         citiesData[countryId] = []
#         citiesData[countryId].append(cityName)
#
# print(str(citiesData))

