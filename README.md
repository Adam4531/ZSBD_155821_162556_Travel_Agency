# Temat projektu
Zarządanie wycieczkami biura podróży

## Członkowie zespołu
Tomasz Piotrowski ( 162 556 )
Adam Rozwadowski ( 155 281 )

## Etapy
### [x] 1. Przygotowanie odpowiedniej struktury bazy danych na wybrany temat. 
- schemat: schemat_V3.png
- tworzenie tabel: zsdb_travel_agency.sql

### [] 2. Skrypt ładujący dane do bazy 
a. Może pobierać dane ze strony – np. odpalany co jakiś czas/ładowanie z plików 
csv, json. (deamon, cron table, itd) 
b. Sprawdzanie poprawności danych. 
c. Gromadzenie i archiwizacja przetworzonych/załadowanych danych do bazy. 

### [] 3. Procedury, funkcje, wyzwalacze obsługujące bazę 
a. Dodawanie, usuwanie, aktualizacja rekordów 
b. Archiwizacja usuniętych danych 
c. Logowanie informacji do tabeli 
d. Obsługa wyjątków, również własne wyjątki 
e. Procedury, funkcje z parametrami, możliwe parametry domyślne, 
wykorzystanie funkcji okienkowych 
f. 
Sprawdzanie poprawności dodawanych danych (np. funkcja sprawdzająca 
poprawność pesel) 

### [] 4. Procedury, funkcje, wyzwalacze tworzące podsumowania 
a. Zestawienia miesięczne, kwartalne, roczne, w zależności od różnych 
parametrów – zapisywane w bazie danych (gotowe do wyświetlania na 
wykresach)
