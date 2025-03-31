def calculate_bac(uzytkownik_id, historia_data):
    from datetime import datetime
    from Models import Uzytkownik

    waga = Uzytkownik.get_waga(uzytkownik_id)
    plec = Uzytkownik.get_plec(uzytkownik_id)

    r = 0.68 if plec  else 0.55
    alcohol_grams_per_ml = 0.789
    metabolism = 0.015
    current_time = datetime.now()
    total_alcohol_grams = 0
    
    for record in historia_data:
        zawartosc_procentowa = record['zawartosc_procentowa'] / 100
        ilosc_wypitego_ml = record['ilosc_wypitego_ml']
        czas_picia = datetime.strptime(record['data'], "%Y-%m-%d %H:%M:%S")  
        hours_since_drinking = (current_time - czas_picia).total_seconds() / 3600
        alcohol_grams = ilosc_wypitego_ml * alcohol_grams_per_ml * zawartosc_procentowa
        alcohol_grams -= max(0, hours_since_drinking * metabolism * waga * r)
        total_alcohol_grams += max(0, alcohol_grams)
    
    BAC = total_alcohol_grams / (r * waga)

    print(BAC)
        


    if BAC < 0.2:
        stan = "Trzeźwy"
    elif 0.2 <= BAC < 0.5:
        stan = "Lekka nietrzeźwość"
    elif 0.5 <= BAC < 0.8:
        stan = "Średnia nietrzeźwość"
    elif 0.8 <= BAC < 1.5:
        stan = "Poważna nietrzeźwość"
    else:
        stan = "Stan ciężkiego upojenia"
    return round(BAC, 2), stan
